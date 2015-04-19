gulp = require 'gulp'
mark = require 'gulp-markdown'
article = require './helper/article'
jade = require 'gulp-jade-template'
publish = require 'gulp-article-publish'
{paths} = require '../gulpfile'

module.exports = ->
  gulp.src paths.posts
    .pipe mark()
    .pipe article()
    .pipe jade('src/page.jade')
    .pipe article()
    .pipe publish(paths.dest)
