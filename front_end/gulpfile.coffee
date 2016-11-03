gulp = require 'gulp'
coffee = require 'gulp-coffee'
 
gulp.task 'build', () ->
	# compile project
  gulp.src('./src/index.coffee')
    .pipe(coffee())
    .pipe(gulp.dest('dist/'))
  # copy to rails directory 
  gulp.src('./dist/index.js')
  	.pipe(gulp.dest('./../back_end/app/assets/javascripts')); 
