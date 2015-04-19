gulp = require 'gulp'
{paths} = require '../gulpfile'

module.exports = ->
  gulp.src 'src/favicons/*'
    .pipe gulp.dest paths.dest
