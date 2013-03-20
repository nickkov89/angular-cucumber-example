nock   = require 'nock'

apiSteps = module.exports = ->

  @Given /^the brand menu API request returns the following:$/, (table, next) ->
    brands = table.hashes()
    @nock.get("/api/v2/brands").reply(200, JSON.stringify(brands))
    next()
