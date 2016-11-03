gulp = require 'gulp'
coffee = require 'gulp-coffee'
 
gulp.task 'build', () ->
  gulp.src('./src/index.coffee')
    .pipe(coffee())
    .pipe(gulp.dest('dist/'))
