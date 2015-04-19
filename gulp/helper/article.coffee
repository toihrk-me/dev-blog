gutil = require 'gulp-util'
through = require 'through2'

module.exports = ->
  transform = (file, encoding, callback)->
    if file.isNull() then return callback null, file
    if file.isStream() then return callback new gutil.PluginError('gulp-article', 'Stream not supported')

    html = file.contents.toString()
    filename = /(\d{4})\/(\d{2})\/(\d{2})\/(.*)\.html$/.exec file.path
    res =
      body: html
      date:
        year: filename[1]
        month: filename[2]
        day: filename[3]
      url: filename[4]
    file.contents = new Buffer JSON.stringify res
    callback null, file

  through.obj transform
