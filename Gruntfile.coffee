module.exports = (grunt) ->
    'use strict'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-jasmine'
#    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-express'
    grunt.loadNpmTasks 'grunt-webdriver-jasmine-runner'

    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')

        clean: [
            'spec/js'
            'js'
        ]


        coffee:
            test:
                expand: true
                cwd: 'spec/src'
                src: ['**/*.coffee']
                dest: 'spec/js'
                ext: '.js'

            main:
                expand: true
                cwd: 'src'
                src: ['**/*.coffee']
                dest: 'js'
                ext: '.js'

        jasmine:
            main:
                src: 'js/**/*.js'
                options:
                    specs: 'spec/js/*Spec.js'
                    helpers: [
                        'js/WebdriverHelper.js'
                        'js/JasmineSetup.js'
                    ]
                    vendor: [
                        'spec/libs/jquery-1.10.1.min.js'
                        'libs/lodash.min.js'
                        'libs/webdriver.js'
                    ]

        express:
            server:
                options:
                    port: 8777
                    bases: [
                        '.'
                    ]
                    debug: false

        webdriver_jasmine_runner:
            main:
                options:
                    testServerPort: 8777

    grunt.registerTask 'test', ['clean', 'coffee', 'jasmine:main:build', 'express', 'webdriver_jasmine_runner']

