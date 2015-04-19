gulp = require 'gulp'
jade = require 'gulp-jade-template'
rename = require 'gulp-rename'
{paths} = require '../gulpfile'

module.exports = ->
  gulp.src "#{paths.dest}/archives/*.json"
    .pipe jade('src/archive.jade')
    .pipe rename
      extname: '.html'
    .pipe gulp.dest("#{paths.dest}/archives")
