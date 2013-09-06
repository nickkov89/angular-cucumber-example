Factory = require('rosie').Factory
_       = require('underscore')
require '../../spec/factories/index'

module.exports = ->
  @World = require('../support/world.coffee').World

  @Before (callback) ->
    @server = @app.listen(9002)
    callback()

  @After (callback) ->
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
    @app.get '/api/v2/me', (req, res) ->
      res.json Factory.build('Me')

    @browser.get('http://localhost:9002').then ->
      callback()

  @Then /^I should see "(.*)" brands$/, (number, callback) ->
    @browser.findElement(@By.className 'brand-name' ).getText().then (text) =>
      @assert.equal text, number
      callback()

  @When /^I click the input box "(.*)"$/, (input, callback) ->
    el = @browser.findElement(@By.id input)
    el.click()
    callback()
