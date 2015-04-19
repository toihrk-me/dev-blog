gulp = require 'gulp'
fs = require 'fs'
_ = require 'lodash'
rename = require 'gulp-rename'
{paths} = require '../gulpfile'

module.exports = -> fs.readdir "#{paths.dest}/archives", (err, files)->
  files = _.filter files, (file)-> /^page-\d*\.html$/.test file
  gulp.src "#{paths.dest}/archives/#{_.head(files)}"
    .pipe rename('index.html')
    .pipe gulp.dest("#{paths.dest}/archives")
