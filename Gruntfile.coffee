module.exports = (grunt) ->
    'use strict'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-jasmine'
#    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-clean'

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
