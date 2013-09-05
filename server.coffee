express = require('express')
_       = require('underscore')
Factory = require('rosie').Factory
require './spec/factories/index'
app = express()

app.get '/api/v2/me', (req, res) ->
  res.json Factory.build('Me')

app.get '/api/v2/brands', (req, res) ->
  brands_arr = []
  _(10).times ->
    brands_arr.push Factory.build('Brand')
  res.json brands_arr

module.exports = app
