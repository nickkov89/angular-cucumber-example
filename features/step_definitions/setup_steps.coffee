module.exports = ->
  @World = require('../support/world').World

  @Given /^I have (not )?seen the welcome modal$/, (negator, next) ->
    @env = { show_welcome_modal: !!negator }
    next()

  @Given /^I am logged into crowdtap as:$/, (table, next) ->
    me = table.hashes()[0]
    me = @Factory('Me', me)
    @nock.get('/api/v2/me').reply(200, JSON.stringify(me))
    next()
