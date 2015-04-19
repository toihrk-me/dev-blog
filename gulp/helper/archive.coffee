gutil = require 'gulp-util'
through = require 'through2'
path = require 'path'
mkdir = require 'mkdirp'
fs = require 'fs'
async = require 'async'
_ = require 'lodash'

module.exports = (dest)->
  filepaths = []
  cwd = null
  transform = (file, encoding, callback)->
    filepaths.push file.path
    if cwd is null then cwd = file.cwd
    callback()

  flush = (callback)->
    async.map filepaths, (filepath, callback)->
      fs.readFile filepath, (err, file)->
        url = /(\d{4})\/(\d{2})\/(\d{2})\/(.*)\.md$/.exec filepath
        res =
          filename: filepath.replace cwd, ''
          url: "/#{url[1]}/#{url[2]}/#{url[3]}/#{url[4]}.html"
          title: /^# \[(.*)\]/.exec(file.toString().split('\n')[0])[1]
          year: url[1]
          month: url[2]
        callback err, res
    , (err, posts)->
      posts = posts.reverse()
      allArchive = for i in [0..(posts.length / 20)] then posts.slice (i*20), (((i+1)*20)-1)
      yearlyArchive = _.groupBy posts, (post)-> post.year
      monthlyArchive = _.groupBy posts, (post)-> "#{post.year}-#{post.month}"
      allArchive = allArchive.map (posts, index)-> {index: index, posts: posts, isHead: false, isLast: false}
      allArchive[0].isHead = allArchive[allArchive.length-1].isLast = true
      _.each _.keys(yearlyArchive), (key)-> yearlyArchive[key] = {year: key, posts: yearlyArchive[key]}
      _.each _.keys(monthlyArchive), (key)->
        splitedKey = key.split '-'
        monthlyArchive[key] = {year: splitedKey[0], month: splitedKey[1], posts: monthlyArchive[key]}

      mkdir.sync dest

      allWrite = (archive, cb)-> fs.writeFile path.resolve(dest, "page-#{archive.index}.json"), JSON.stringify(archive), (err)-> if err? then cb err else cb null
      yearWrite = (key, cb)-> fs.writeFile path.resolve(dest, "#{key}.json"), JSON.stringify(yearlyArchive[key]), (err)-> if err? then cb err else cb null
      monthWrite = (key, cb)-> fs.writeFile path.resolve(dest, "#{key}.json"), JSON.stringify(monthlyArchive[key]), (err)-> if err? then cb err else cb null

      async.parallel [
        (callback)-> async.each allArchive, allWrite, (err)-> callback err
        (callback)-> async.each _.keys(yearlyArchive), yearWrite, (err)-> callback err
        (callback)-> async.each _.keys(monthlyArchive), monthWrite, (err)-> callback err
      ], (err)-> callback err

  through.obj transform, flush
