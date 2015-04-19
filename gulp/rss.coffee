gulp = require 'gulp'
fs = require 'fs'
rss = require './helper/rss'
articles = require './helper/articles'
{paths} = require '../gulpfile'

module.exports = ->
  gulp.src articles().slice(-20).reverse()
    .pipe rss
      title: 'kaihatsu'
      description: 'development log'
      feed_url: 'http://dev.jgs.me/feed.xml'
      site_url: 'http://dev.jgs.me'
      image_url: 'http://dev.jgs.me/icon.png'
      author: 'jigsaw'
      copyright: '(c) 2015 jigsaw'
      updated: new Date()
    .pipe gulp.dest paths.dest
