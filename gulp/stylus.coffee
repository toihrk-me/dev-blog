gulp = require 'gulp'
styl = require 'gulp-stylus'
{paths} = require '../gulpfile'

module.exports = ->
  gulp.src paths.styl
    .pipe styl
      compress: true
    .pipe gulp.dest(paths.dest)
