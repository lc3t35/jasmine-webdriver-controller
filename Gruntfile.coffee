module.exports = (grunt) ->
    'use strict'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-jasmine'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-express'
    grunt.loadNpmTasks 'grunt-webdriver-jasmine-runner'
    grunt.loadNpmTasks 'grunt-bower-task'

    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')

        clean: [
            'spec/dist'
            'dist'
            'components'
            'lib'
        ]

        bower:
            install:{}

        coffee:
            test:
                expand: true
                cwd: 'spec/src'
                src: ['**/*.coffee']
                dest: 'spec/dist'
                ext: '.js'

            main:
                expand: true
                cwd: 'src'
                src: ['**/*.coffee']
                dest: 'dist'
                ext: '.js'

        jasmine:
            main:
                src: [
                    'dist/WebdriverHelper.js'
                    'dist/JasmineSetup.js'
                ]
                options:
                    specs: 'spec/dist/*Spec.js'
                    vendor: [
                        'lib/jquery/jquery.js'
                        'lib/lodash/lodash.compat.js'
                        'src/lib/webdriver.js'
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

    grunt.registerTask 'test', ['clean', 'bower', 'coffee', 'jasmine:main:build', 'express', 'webdriver_jasmine_runner']

