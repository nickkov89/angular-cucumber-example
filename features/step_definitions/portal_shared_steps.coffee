should = require 'should'
path   = require 'path'

module.exports = ->

  @Given /^I am on the portal page$/, (next) ->
    @visit "/index.html", next
