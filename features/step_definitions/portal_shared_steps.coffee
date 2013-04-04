should = require 'should'
path   = require 'path'

module.exports = ->

  @Given /^I am on the portal page( and have seen the welcome modal)?$/, (hideModal, next) ->
    @me or= @Factory('Me')
    @nock.get('/api/v2/me').reply(200, JSON.stringify(@me))
    @visit "/test.html?hideModal=#{hideModal?}", next
