path = require 'path'

module.exports = (grunt) ->

  seleniumPath = path.resolve 'selenium'

  grunt.initConfig
    env:
      test:
        PATH: "#{seleniumPath}:process.env.PATH"
    connect:
      server:
        options:
          keepalive: true
          port: 9001
          base: 'app'

    cucumberjs:
      files: 'features/*.feature'

  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-cucumber'
  grunt.loadNpmTasks 'grunt-env'

  grunt.registerTask 'server', [
    'connect:server'
  ]

  grunt.registerTask 'test', [
    'env:test'
    'cucumberjs'
  ]
