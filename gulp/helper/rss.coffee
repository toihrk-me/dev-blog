gutil   = require 'gulp-util'
through = require 'through2'
RSS     = require 'rss'
path    = require 'path'

module.exports = (opt)->
  cwd = base = null
  feed = new RSS opt

  transform = (file, encoding, callback)->
    if cwd is null then cwd = file.cwd
    if base is null then base = file.cwd
    article = file.contents.toString().split '\n'
    url = /(\d{4})\/(\d{2})\/(\d{2})\/(.*)\.md$/.exec file.path

    feed.item
      title: /^# \[(.*)\]/.exec(article[0])[1]
      description: article.slice(2, 5).join '\n'
      url: "#{opt.site_url}/#{url[1]}/#{url[2]}/#{url[3]}/#{url[4]}.html"
      date: new Date url[1], parseInt(url[2])-1, url[3]

    callback()

  flush = (callback)->
    @push new gutil.File
      cwd: cwd
      base: base
      path: path.resolve cwd, 'feed.xml'
      contents: new Buffer feed.xml()
    callback()

  through.obj transform, flush
