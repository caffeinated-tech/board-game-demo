browserify = require 'browserify'
browserifyIncremental = require 'browserify-incremental'
buffer = require 'vinyl-buffer'
coffee = require 'gulp-coffee'
gulp = require 'gulp'
source = require 'vinyl-source-stream'
watch = require 'watch'

build = ->
	console.log '\nbuilding...'

	b = browserify(
		entries: ['./src/index.coffee']
		transform: ['coffeeify']
		extensions: ['.coffee']
		cache: {})
	# cache compiled js so that only changes need to be compiled
	browserifyIncremental(b, { cacheFile: 'tmp/cache.json'} )

	b.bundle()
		.on('error', (error) ->
			console.log error
			this.emit 'end') 
		.on('end', ->
			console.log 'finished compiling coffeescript' 
			)
    .pipe(
    	source(
    		'index.js'))
		.pipe(
			buffer())
		.pipe(
			gulp.dest(
				'./dist'))
		.pipe(
			gulp.dest(
				'./../back_end/app/assets/javascripts'))

gulp.task 'default', build
	
gulp.task 'watch', ->
  watch.watchTree('./src', build)




