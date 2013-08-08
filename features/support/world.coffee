assert = require 'assert'
path = require 'path'

protractor = require 'protractor'
webdriver = require 'selenium-webdriver'

driver = new webdriver.Builder().
  withCapabilities(webdriver.Capabilities.chrome()).
  build()

ptor = protractor.wrapDriver driver

class World
  constructor: (callback) ->
    @browser = driver
    @By = webdriver.By
    @assert = assert
    callback()

module.exports.World = World
