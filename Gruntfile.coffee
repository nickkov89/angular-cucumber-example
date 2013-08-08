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

    shell:
      selenium:
        command: 'java -jar selenium/selenium-server-standalone-2.33.0.jar -Dwebdriver.chrome.driver=./selenium/chromedriver'
        options:
          stdout: true

  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-cucumber'
  grunt.loadNpmTasks 'grunt-env'
  grunt.loadNpmTasks 'grunt-shell'

  grunt.registerTask 'server', [
    'connect:server'
  ]

  grunt.registerTask 'selenium', [
    'shell:selenium'
  ]

  grunt.registerTask 'test', [
    'env:test'
    'cucumberjs'
  ]
