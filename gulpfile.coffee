gulp = require 'gulp'
connect = require 'gulp-connect'
run = require 'run-sequence'
deploy = require 'gulp-gh-pages'

exports.paths = paths =
  posts: 'posts/**/*.md'
  styl: 'src/*.styl'
  dest: 'build'
  coffee: 'src/*.coffee'

[
  'article'
  'indexpage'
  'CNAME'
  'gfm'
  'stylus'
  'coffee'
  'archive-json'
  'archive-page'
  'archive-head'
  'rss'
  'favicon'
  'write'
].forEach (name)-> gulp.task name, require "./gulp/#{name}"

gulp.task 'archive', (callback)-> run 'archive-json', 'archive-page', 'archive-head', callback
gulp.task 'default', ['article', 'indexpage', 'archive', 'rss', 'CNAME', 'gfm', 'favicon', 'stylus', 'coffee']
gulp.task 'watch', ['default'], ->
  gulp.watch paths.posts, ['article', 'index']
  gulp.watch paths.styl, ['stylus']
  connect.server
    root: paths.dest
gulp.task 'deploy', ->
  gulp.src './build/**/*'
    .pipe deploy
      cacheDir: 'tmp'
