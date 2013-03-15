Browser     = require 'zombie'
{ Factory } = require 'forgery'
Hem         = require 'hem'
nock        = require 'nock'
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
    @browser   = new Browser()
    @selectors = require './selectors'
    @nock      = nock(Browser.site, { allowUnmocked: true })
                 #.log(console.log)

    nock('http://copycopter.example.com')
      .persist()
      .filteringPath(/translations.+/g, 'translations')
      .get('/translations')
      .reply(200, (path) -> "#{path.match(/callback=(.+)/)[1]}({ 'en': { } })")
      #.log(console.log)

    callback(@)

  visit: (url, next) ->
    @browser.visit url, (err, browser, status) =>
      throw err if err
      browser.wait (err) =>
        throw err if err
        @$ = @jQuery = browser.window.$
        next err, browser, status

  selectorFor: (locator) ->
    for regexp, path of @selectors
      if match = locator.match(new RegExp(regexp))
        return if path?() then path(match.slice(1)) else path

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
