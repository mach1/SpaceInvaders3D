gulp = require 'gulp'
gutil = require 'gulp-util'
jshint = require 'gulp-jshint'
browserify = require 'gulp-browserify'
concat = require 'gulp-concat'
clean = require 'gulp-clean'
nodemon = require 'gulp-nodemon'
mocha = require 'gulp-spawn-mocha'
browserSync = require 'browser-sync'
reload = browserSync.reload
notify = require 'gulp-notify'
gulpif = require 'gulp-if'

require 'coffee-script/register'

paths =
  styles : ['webapp/app/styles/*.css']
  scripts : ['webapp/app/scripts/*.coffee', 'webapp/app/scripts/**/*.coffee']
  html : ['webapp/app/*.html', 'webapp/app/views/*.html']

gulp.task 'serve', (cb) ->
  nodemon
    script: './server/bin/server.coffee',
    ignore: ['./webapp', 'gulpfile.coffee']
  .on 'start', ->
    cb() if not browserSync.active

gulp.task 'browser-sync', ['serve'], ->
  browserSync.init null,
    proxy: 'localhost:5000',
    files: ['webapp/dist/**/*.**']
    browser: 'google chrome',
    port: 7000

gulp.task 'lint', ->
  gulp.src 'webapp/app/scripts/*.js'
    .pipe jshint()
    .pipe jshint.reporter 'jshint-stylish'

gulp.task 'styles', ->
  gulp.src 'webapp/app/styles/*.css'
    .pipe gulp.dest 'webapp/dist/css'

gulp.task 'browserify', ->
  gulp.src 'webapp/app/scripts/main.coffee', read: false
    .pipe browserify
      debug: true
      transform: ['coffeeify']
      extensions: ['.coffee']
    .pipe concat 'bundle.js'
    .pipe gulp.dest 'webapp/dist/js'
    .pipe browserSync.reload({stream: true})

gulp.task 'html', ->
  gulp.src paths.html
    .pipe gulp.dest 'webapp/dist'

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

gulp.task 'default', ['build', 'mocha',  'browser-sync', 'watch', 'watch-mocha']

gulp.task 'production', ['build', 'serve']
