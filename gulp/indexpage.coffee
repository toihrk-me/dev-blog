fs = require 'fs'
gulp = require 'gulp'
_ = require 'lodash'
mark = require 'gulp-markdown'
article = require './helper/article'
articles = require './helper/articles'
jade = require 'gulp-jade-template'
rename = require 'gulp-rename'
{paths} = require '../gulpfile'

module.exports = ->
  gulp.src _.last articles()
    .pipe mark()
    .pipe article()
    .pipe jade('src/page.jade')
    .pipe rename('index.html')
    .pipe gulp.dest(paths.dest)
