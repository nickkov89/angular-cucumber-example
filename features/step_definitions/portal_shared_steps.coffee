should = require 'should'
path   = require 'path'

module.exports = ->

  @Given /^I am on the portal page$/, (next) ->
    @me or= @Factory('Me')
    @nock.get('/api/v2/me').reply(200, JSON.stringify(@me))
    @visit "/test.html", next
