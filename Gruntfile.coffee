module.exports = (grunt) ->

	# Project configuration.
	grunt.initConfig
		coffee:
			server: 
				expand: true,
				flatten: false,
				cwd: 'app/coffee',
				src: ['**/*.coffee'],
				dest: 'app/js/',
				ext: '.js'

			app_server: 
				expand: true,
				flatten: false,
				src: ['app.coffee'],
				dest: './',
				ext: '.js'

			server_tests:
				expand: true,
				flatten: false,
				cwd: 'test/unit/coffee',
				src: ['*.coffee', '**/*.coffee'],
				dest: 'test/unit/js/',
				ext: '.js'

		watch:
			server_coffee:
				files: ['app/*.coffee','app/**/*.coffee', 'test/unit/coffee/**/*.coffee', 'test/unit/coffee/*.coffee', "app.coffee"]
				tasks: ["clean", 'coffee', 'mochaTest']

		clean: ["app/js", "test/unit/js", "app.js"]

		nodemon:
			dev:
				options:
					file: 'app.js'

		concurrent:
			dev:
				tasks: ['nodemon', 'watch']
				options:
					logConcurrentOutput: true

		mochaTest:
			unit:
				src: ["test/unit/js/#{grunt.option('feature') or '**'}/*.js"]
				options:
					reporter: grunt.option('reporter') or 'spec'
					grep: grunt.option("grep")
				

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-nodemon'
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-concurrent'
	grunt.loadNpmTasks 'grunt-mocha-test'

	grunt.registerTask "test:unit", ["coffee", "mochaTest:unit"]
	grunt.registerTask "ci", "test:unit"
	grunt.registerTask 'default', ['coffee', 'concurrent']

	grunt.registerTask "compile", "coffee"
	grunt.registerTask "install", "compile"

