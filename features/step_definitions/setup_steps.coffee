module.exports = ->
  @World = require('../support/world').World

  @Given /^I am logged into crowdtap as:$/, (table, next) ->
    me = table.hashes()[0]
    me = @Factory('Me', me)
    @nock.get('/api/v2/me').reply(200, JSON.stringify(me))
    next()
