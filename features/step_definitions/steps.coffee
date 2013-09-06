module.exports = ->
  @World = require('../support/world.coffee').World

  @Given /^I am on the homepage$/, (callback) ->
    @app.get '/api/v2/brands', (req, res) ->
      brands_arr = []
      _(6).times ->
        brands_arr.push Factory.build('Brand')
      _(4).times ->
        brands_arr.push Factory.build('Brand', { actions_count: 0, actions_new: 0, actions_expiring: 0, actions_in_progress: 0 })
      res.json brands_arr
    @app.listen(9002)
    @browser.get('http://localhost:9002').then ->
      callback()

  @When /^I change my name to "(.*)"$/, (name, callback) ->
    el = @browser.findElement(@By.tagName 'input')
    el.clear()
    el.sendKeys(name).then ->
      callback()

  @When /^I click the input box "(.*)"$/, (input, callback) ->
    el = @browser.findElement(@By.id input)
    el.click()
    callback()

  @Then /^I should see my name as "(.*)"$/, (name, callback) ->
    @browser.findElement(@By.tagName 'span').getText().then (text) =>
      @assert.equal text, name
      callback()
