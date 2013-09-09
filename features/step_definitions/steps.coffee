Factory = require('rosie').Factory
express = require 'express'
_       = require('underscore')
require '../../spec/factories/index'

module.exports = ->
  @World = require('../support/world.coffee').World

  @Before (callback) ->
    @server = @app.listen(9002)
    callback()

  @After (callback) ->
    @server.close()
    callback()

  @Given /^the brands API request returns the following:$/, (table, callback) ->
    brands = table.hashes()
    brands_arr = []
    @app.get '/api/v2/brands', (req, res) ->
      for brand in brands
        brands_arr.push Factory.build('Brand', brand)
      res.json brands_arr
    callback()

  @Given /^I am logged in as:$/, (table, callback) ->
    me = table.hashes()[0]
    @app.get '/api/v2/me', (req, res) ->
      res.json Factory.build('Me', me)
    callback()

  @Given /^I am on the homepage$/, (callback) ->
    @browser.get('http://localhost:9002').then ->
      callback()

  @Then /^I should see (\d+) brand boxes$/, (number, callback) ->
    @browser.findElements(@By.className 'brand-box' ).then (elements_arr) =>
      @assert.equal elements_arr.length, number
      callback()

  @When /^I click the input box "(.*)"$/, (input, callback) ->
    el = @browser.findElement(@By.id input).click().then ->
      callback()
