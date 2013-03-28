nock = require 'nock'

apiSteps = module.exports = ->

  @After (next) ->
    @browser.wait =>
      if !@nock.isDone()
        console.log '\n\nWarning: Not all Mocked requests were cleared!\n'
      next()

  @Given /^the brand menu API request returns the following:$/, (table, next) ->
    brands = table.hashes()
    @nock.get("/api/v2/brands").reply(200, JSON.stringify(brands))
    next()

  @Given /^the API returns the following JSON response for ([^:]+):$/, (pathMatcher, jsonString, next) ->
    path = @selectorFor(pathMatcher)
    @nock.get(path).reply(200, JSON.parse(jsonString))
    next()


  @Given /^the API returns a successful response for (GET|POST|PUT) requests to "([^"]*)"(?: and responds with:)?$/, (requestType, path, body, next) ->
    unless typeof next == 'function'
      next = body
      body = ""

    switch requestType
      when "POST"
        @nock.filteringRequestBody( () -> return '').post(path).reply(200, body)
      when "PUT"
        @nock.filteringRequestBody( () -> return '').put(path).reply(200, body)
      else
        @nock.get(path).reply(200, body)

    next()

  @Given /^the API returns the following charities:$/, (table, next) ->
    charities = []
    for row in table.hashes()
      row.default = row.default == 'true'
      charities.push @Factory('Charity', row)

    @nock.get('/api/v2/charities').reply(200, charities)
    next()

  @Given /^the API returns a (\d+) for (GET|PUT|DELETE) requests to "([^"]+)"(?: with:)?$/, (status, verb, path, jsonString, next) ->
    next = jsonString unless typeof next == 'function'
    jsonString = '{}' unless typeof jsonString == 'string'

    @nock.filteringRequestBody(-> '')[verb.toLowerCase()](path).reply(status, JSON.parse(jsonString))
    next()

  @Then /^I should (not )?have made a (POST|PUT) request to "([^"]*)"(?: with:)?$/, (negation, verb, path, string, next) ->
    unless typeof next == 'function'
      next = string
      string = "{}"
    verb = verb.toLowerCase().capitalize()

    requests = @recorder["all#{verb}sByPath"](path)
    if negation
      requests.length.should.eql 0, "A #{verb} request was made to #{path} but should not have"
    else
      requests.length.should.not.eql 0, "No #{verb} request was made to #{path}"
      expected = JSON.parse(string)

      actuals = @_.map requests, (request) ->
        delete request.params.id
        request.params

      @_.any(actuals, (actual) =>
        JSON.stringify(Object.keys(actual).sort()) == JSON.stringify(Object.keys(expected).sort()) &&
          @_.all( Object.keys(actual), (key) -> JSON.stringify(actual[key]) == JSON.stringify(expected[key]) )
      ).should.eql true, "Expected Request did not match Actual Requests"

    next()
