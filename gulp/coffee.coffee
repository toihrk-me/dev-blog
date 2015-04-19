gulp = require 'gulp'
coffee = require 'gulp-coffee'
{paths} = require '../gulpfile'

module.exports = ->
  gulp.src paths.coffee
    .pipe coffee()
    .pipe gulp.dest(paths.dest)
