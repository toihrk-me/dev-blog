gulp = require 'gulp'
inquirer = require 'inquirer'
data = require 'gulp-data'
through = require 'through2'
mkdir = require 'mkdirp'

transform = (file, encoding, callback)-> inquirer.prompt [
  type: 'input'
  name: 'title'
  message: 'title'
,
  type: 'input'
  name: 'url'
  message: 'url'
], (answers)->
  {title, url} = answers

  today = new Date()
  year = today.getFullYear()
  month = today.getMonth() + 1
  day = today.getDate()
  if month.toString().length is 1 then month = "0#{month}"
  if day.toString().length is 1 then day = "0#{day}"

  mkdir.sync "#{file.base}#{year}/#{month}/#{day}"

  file.path = "#{file.base}#{year}/#{month}/#{day}/#{url}.md"
  file.contents = new Buffer "# [#{title}](/#{year}/#{month}/#{day}/#{url}.html)"

  callback null, file

module.exports = ->
  gulp.src '',
    read: false
  .pipe through.obj transform
  .pipe gulp.dest 'posts'
