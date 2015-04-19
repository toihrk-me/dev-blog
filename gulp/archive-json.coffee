gulp = require 'gulp'
archive = require './helper/archive.coffee'
{paths} = require '../gulpfile'

module.exports = ->
  gulp.src paths.posts,
    read: false
  .pipe archive("#{paths.dest}/archives")
