assert = require 'assert'
path = require 'path'
express = require 'express'
Factory = require('rosie').Factory
require '../../spec/factories/index'

protractor = require 'protractor'

class World
  constructor: (callback) ->
    @By = protractor.By
    @assert = assert
    @app = express()
    @app.use express.static(path.join(process.cwd(), 'public'))
    callback()

module.exports.World = World
