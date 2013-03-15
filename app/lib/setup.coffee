require 'json2ify'
require 'es5-shimify'
require 'spine/lib/ajax'
require 'spine/lib/manager'
require 'spine/lib/route'

Spine = require 'spine'

Spine.environments =
  development:
    real_browser:       true
    assetPrefixUrl: -> 'http://localhost:9294'
  test:
    real_browser:       false
    assetPrefixUrl:     -> ''
  production:
    real_browser:       true
    assetPrefixUrl:     (hash) -> "http://d18w78eemwzu3j.cloudfront.net/crowdtap.portal/#{hash}"
  staging:
    real_browser:       true
    assetPrefixUrl: ->  'http://localhost:9294'

window?.Helper = window?.H = require('lib/helpers')

module.exports =
  Spine: Spine
