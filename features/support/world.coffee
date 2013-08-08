assert = require 'assert'
path = require 'path'

protractor = require 'protractor'
webdriver = require 'selenium-webdriver'

driver = new webdriver.Builder().
  usingServer('http://localhost:4444/wd/hub').
  withCapabilities(webdriver.Capabilities.phantomjs()).
  build()

ptor = protractor.wrapDriver driver

class World
  constructor: (callback) ->
    @browser = driver
    @By = webdriver.By
    @assert = assert
    callback()

module.exports.World = World
