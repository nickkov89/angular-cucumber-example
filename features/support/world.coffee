assert = require 'assert'
path = require 'path'
express = require 'express'
Factory = require('rosie').Factory
require '../../spec/factories/index'

protractor = require 'protractor'
webdriver = require 'selenium-webdriver'

driver = new webdriver.Builder().
  usingServer('http://localhost:4444/wd/hub').
  withCapabilities(webdriver.Capabilities.phantomjs()).
  build()

ptor = protractor.wrapDriver driver

class World
  constructor: (callback) ->
    @browser = ptor
    @By = protractor.By
    @assert = assert
    @app = express()
    @app.use express.static(path.join('/Users/nickk/dev/angular-cucumber-example/', 'public'))
    callback()

module.exports.World = World
