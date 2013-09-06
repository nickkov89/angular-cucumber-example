path = require 'path'

module.exports = (grunt) ->

  seleniumPath = path.resolve 'selenium'

  grunt.initConfig
    env:
      test:
        PATH: "#{seleniumPath}:process.env.PATH"

    cucumberjs:
      files: 'features/*.feature'

    less:
      production:
        options:
          paths:       ['public/css']
          yuicompress: true
        files: [
          {
            src:  'public/css/index.less'
            dest: 'public/application.css'
          }
        ]

    express:
      custom:
        options:
          hostname: 'localhost'
          port: 9001
          bases: 'public'
          server: path.resolve('./server')

    copy:
      main:
        files: [
          { expand: true, cwd: 'vendor/jquery/', src: ['**'], dest: 'public/vendor/jquery' },
          { expand: true, cwd: 'vendor/angular/', src: ['**'], dest: 'public/vendor/angular' },
          { expand: true, cwd: 'vendor/angular-resource/', src: ['**'], dest: 'public/vendor/angular-resource' },
          { expand: true, cwd: 'vendor/angular-mocks/', src: ['**'], dest: 'public/vendor/angular-mocks' }
        ]

    shell:
      selenium:
        command: 'java -jar selenium/selenium-server-standalone-*.jar -Dwebdriver.chrome.driver=./selenium/chromedriver'
        options:
          stdout: true

    watch:
      coffee:
        files: ['public/js/**/*.coffee', 'spec/*_spec.coffee']
        tasks: 'coffee'
      less:
        files: ['public/css/**/*.less']
        tasks: 'less'

    coffee:
      compile:
        options:
          bare: true
        files:
          'public/application.js': ['public/js/**/*.coffee'],
          'spec/tests.js': ['spec/*_spec.coffee']

    concurrent:
      target:
        tasks: [
          'coffee'
          'server'
          'watch'
          'shell:selenium'
          'less'
          'copy'
        ]

  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-express'
  grunt.loadNpmTasks 'grunt-concurrent'
  grunt.loadNpmTasks 'grunt-cucumber'
  grunt.loadNpmTasks 'grunt-env'
  grunt.loadNpmTasks 'grunt-shell'

  grunt.registerTask 'default', ['concurrent:target']

  grunt.registerTask 'server', ['express', 'express-keepalive']

  grunt.registerTask 'test', [
    'env:test'
    'cucumberjs'
  ]
