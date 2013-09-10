express = require('express')
_       = require('underscore')
Factory = require('rosie').Factory
require './spec/factories/index'
app = express()

app.get '/api/v2/me', (req, res) ->
  res.json Factory.build('Me')

app.get '/api/v2/brands', (req, res) ->
  brands_arr = []
  _(6).times ->
    brands_arr.push Factory.build('Brand')
  _(4).times ->
    brands_arr.push Factory.build('Brand', { actions_count: 0, actions_new: 0, actions_expiring: 0, actions_in_progress: 0 })
  res.json brands_arr

module.exports = app
