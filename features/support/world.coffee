Browser     = require 'zombie'
{ Factory } = require 'forgery'
Hem         = require 'hem'
nock        = require 'nock'
selectors   = require './selectors'
recorder    = require './recorder'
should      = require 'should'

# Hem options
hemOptions      = require '../../slug.json'
hemOptions.port = process.env.PORT || 9296

# Start the Hem Server
new Hem(hemOptions).server()

# Zombie options
Browser.site = "http://localhost:#{ hemOptions.port }/"
Browser.debug = true if process.env.DEBUG == 'true'

class World
  constructor: (callback) ->
    @browser  = new Browser()
    @recorder = recorder
    @nock     = nock(Browser.site, { allowUnmocked: true })

    #Enable this to log nock calls
    #@nock.log(console.log)

    nock('http://copycopter.example.com')
      .persist()
      .filteringPath(/translations.+/g, 'translations')
      .get('/translations')
      .reply(200, (path) -> "#{path.match(/callback=(.+)/)[1]}({ 'en': { } })")
      #.log(console.log)

    callback(@)

  visit: (url, next) ->
    @browser.visit url, (err, browser, status) =>
      console.log err if err
      browser.wait (err, browser) =>
        console.log err if err
        @$ = @jQuery = browser.window.$
        next err, browser, status

  selectorFor: (locator) ->
    for regexp, path of selectors
      if match = locator.match(new RegExp(regexp))
        if path?() then path(match.slice(1)) else path

  Factory: (factoryName, options) ->
    for key, value of options
      if value == 'true'
        options[key] = true
      else if value == 'false'
        options[key] = false
      else if value == 'null'
        options[key] = null

    Factory factoryName, options

module.exports.World = World
