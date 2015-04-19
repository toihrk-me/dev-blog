gulp = require 'gulp'
{paths} = require '../gulpfile'

module.exports = -> gulp.src('src/CNAME').pipe gulp.dest(paths.dest)
