module.exports = (grunt) ->
    # -----------------------------------
    # Options
    # -----------------------------------
    grunt.config.init
        compass:
            src:
                options:
                    sassDir: './src'
                    cssDir: './dist'
                    outputStyle: 'compressed'

        coffee:
            source:
                files:
                    './dist/alert_view.js': ['./src/*.coffee']
            site:
                files:
                    './site/site.js': ['./site/*.coffee']

        watch:
            compass:
                files: ['./src/*.scss']
                tasks: ['compass']
                options:
                    spawn: no
            coffeeSource:
                files: ['./src/*.coffee']
                tasks: ['coffee:source']
                options:
                    spawn: no

        connect:
            server:
                options:
                    protocol: 'http'
                    hostname: '*'
                    port: 8000
                    base: '.'

    # -----------------------------------
    # register task
    # -----------------------------------
    grunt.registerTask 'dev', ['connect', 'watch']

    # -----------------------------------
    # Plugins
    # -----------------------------------
    grunt.loadNpmTasks 'grunt-contrib-compass'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-connect'