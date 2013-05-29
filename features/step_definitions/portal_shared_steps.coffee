should = require 'should'
path   = require 'path'

serialize = (obj) ->
  str = []
  for k, v of obj
    str.push "#{encodeURIComponent(k)}=#{encodeURIComponent(v)}"
  str.join('&')

module.exports = ->

  @Given /^I am on the portal page$/, (next) ->
    @me or= @Factory('Me')
    @nock.get('/api/v2/me').reply(200, JSON.stringify(@me))
    @visit "/test.html", next

  @Given /^I am on the portal page with the following params:$/, (table, next) ->
    @me or= @Factory('Me')
    @nock.get('/api/v2/me').reply(200, JSON.stringify(@me))
    params = serialize(table.hashes()[0])
    @visit "/test.html?#{params}", next
