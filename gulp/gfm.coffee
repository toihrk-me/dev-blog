gulp = require 'gulp'
{paths} = require '../gulpfile'

module.exports = -> gulp.src('github-markdown-css/github-markdown.css').pipe gulp.dest(paths.dest)
