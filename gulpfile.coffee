gulp = require 'gulp'
gutil = require 'gulp-util'
jshint = require 'gulp-jshint'
browserify = require 'gulp-browserify'
concat = require 'gulp-concat'
clean = require 'gulp-clean'
refresh = require 'gulp-livereload'
lrserver = require('tiny-lr')()
livereload = require 'connect-livereload'
nodemon = require 'gulp-nodemon'
mocha = require 'gulp-spawn-mocha'
require 'coffee-script/register'
expressroot = __dirname
livereloadport = 35729
serverport = 5000

paths =
  styles : ['webapp/app/styles/*.css']
  scripts : ['webapp/app/scripts/*.coffee', 'webapp/app/scripts/**/*.coffee']
  html : ['webapp/app/*.html', 'webapp/app/views/*.html']

gulp.task 'serve', ->
  nodemon
    script: './server/bin/server.coffee',
    ignore: './webapp'

gulp.task 'lint', ->
  gulp.src 'webapp/app/scripts/*.js'
    .pipe jshint()
    .pipe jshint.reporter 'jshint-stylish'

gulp.task 'styles', ->
  gulp.src 'webapp/app/styles/*.css'
    .pipe gulp.dest 'webapp/dist/css'
    .pipe refresh lrserver

gulp.task 'browserify', (event) ->
  gulp.src 'webapp/app/scripts/main.coffee', read: false
    .pipe browserify
      debug: true
      transform: ['coffeeify']
      extensions: ['.coffee']
    .pipe concat 'bundle.js'
    .pipe gulp.dest 'webapp/dist/js'
    .pipe refresh lrserver


gulp.task 'html', ->
  gulp.src 'webapp/app/index.html'
    .pipe gulp.dest 'webapp/dist'
    .pipe refresh lrserver

  gulp.src 'webapp/app/views/*.html'
    .pipe gulp.dest 'webapp/dist/views'
    .pipe refresh lrserver

gulp.task 'livereload', ->
  lrserver.listen livereloadport, (err) ->
    console.error err if err

gulp.task 'textures', ->
  gulp.src 'webapp/app/textures/*.jpg'
    .pipe gulp.dest 'webapp/dist/textures'

gulp.task 'build', ['copyDeps', 'html', 'styles', 'lint', 'browserify', 'textures']

gulp.task 'watch', ->
 gulp.watch paths.scripts, ['mocha', 'lint', 'browserify']
 gulp.watch paths.html, ['lint', 'html']
 gulp.watch paths.styles, ['styles']

gulp.task 'copyDeps', ->
  gulp.src 'node_modules/bootstrap/dist/css/bootstrap.css'
    .pipe gulp.dest 'webapp/dist/css'

gulp.task 'mocha', ->
  gulp.src(['webapp/test/*.coffee', 'webapp/test/**/*.coffee'], { read: false })
    .pipe(mocha({
      require: ['sinon']
    })).on('error', gutil.log)

gulp.task 'watch-mocha', ->
  gulp.watch ['webapp/test/**', 'webapp/test/**/**'], ['mocha']

gulp.task 'default', ['build', 'mocha', 'livereload', 'serve', 'watch', 'watch-mocha']

gulp.task 'production', ['build', 'serve']
