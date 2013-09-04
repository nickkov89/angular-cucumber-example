express = require('express')
Factory = require('rosie').Factory
require './spec/factories/index'
app = express()

app.get '/api/v2/me', (req, res) ->
  res.send JSON.stringify(Factory.build('Me'))

module.exports = app
