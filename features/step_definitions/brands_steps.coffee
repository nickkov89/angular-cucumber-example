module.exports = ->

  @Given /^the brands API request returns the following:$/, (table, next) ->
    brands = table.hashes().map (row) => @Factory('Brand', row)
    @nock.get('/api/v2/brands').reply(200, JSON.stringify(brands))
    next()
