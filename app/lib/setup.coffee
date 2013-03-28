require 'json2ify'
require 'es5-shimify'
require 'spine/lib/ajax'
require 'spine/lib/manager'
require 'spine/lib/route'

Spine = require 'spine'

Spine.environments =
  development:
    copycopterUrl:     'http://localhost:3004/translations'
    real_browser:       true
    assetPrefixUrl:    'http://localhost:9294'
  test:
    copycopterUrl:      'http://copycopter.example.com/translations'
    real_browser:       false
    assetPrefixUrl:     ''
  production:
    copycopterUrl:      'http://copycopter.crowdtap.com/api/v2/projects/671ada692a700a3b8adceb463c278cfd/published_blurbs?format=hierarchy'
    real_browser:       true
    assetPrefixUrl:     'http://d18w78eemwzu3j.cloudfront.net/crowdtap.portal'
  staging:
    copycopterUrl:      'http://copycopter.crowdtap.com/api/v2/projects/671ada692a700a3b8adceb463c278cfd/published_blurbs?format=hierarchy'
    real_browser:       true
    assetPrefixUrl:     'http://localhost:9294'

window?.I18n   = require('lib/i18n')
window?.Helper = window?.H = require('lib/helpers')

module.exports =
  Spine: Spine
  I18n:  I18n
