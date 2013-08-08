assert = require 'assert'
path = require 'path'

protractor = require 'protractor'
webdriver = require 'selenium-webdriver'
SeleniumServer = (require 'selenium-webdriver/remote').SeleniumServer

jarPath = path.join __dirname, '../..', 'selenium/selenium-server-standalone-2.33.0.jar'
server = new SeleniumServer jarPath,
  port: 4444

server.start()

driver = new webdriver.Builder().
  usingServer(server.address()).
  withCapabilities(webdriver.Capabilities.chrome()).
  build()

ptor = protractor.wrapDriver driver

class World
  constructor: (callback) ->
    @browser = ptor
    @assert = assert
    callback()

module.exports.World = World
