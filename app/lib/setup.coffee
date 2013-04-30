require 'json2ify'
require 'es5-shimify'
require 'spine/lib/ajax'
require 'spine/lib/manager'
require 'spine/lib/route'

Spine = require 'spine'

Spine.environments =
  development:
    copycopterUrl:      'http://copycopter.crowdtap.com/api/v2/projects/0f393bf25199072b53d57bdde4480101/published_blurbs?format=hierarchy'
    real_browser:       true
    assetPrefixUrl:     'http://d18w78eemwzu3j.cloudfront.net/crowdtap.portal'
  local:
    copycopterUrl:     'http://localhost:4004/translations'
    real_browser:       true
    assetPrefixUrl:    'http://localhost:9295'
  test:
    copycopterUrl:      'http://copycopter.example.com/translations'
    real_browser:       false
    assetPrefixUrl:     ''
  production:
    copycopterUrl:      'http://copycopter.crowdtap.com/api/v2/projects/0f393bf25199072b53d57bdde4480101/published_blurbs?format=hierarchy'
    real_browser:       true
    assetPrefixUrl:     'http://d18w78eemwzu3j.cloudfront.net/crowdtap.portal'
    hashAssets:         true
  staging:
    copycopterUrl:      'http://copycopter.crowdtap.com/api/v2/projects/0f393bf25199072b53d57bdde4480101/published_blurbs?format=hierarchy'
    real_browser:       true
    assetPrefixUrl:     'http://localhost:9295'

window?.I18n    = require('lib/i18n')
window?.Helper  = window?.H = require('lib/helpers')

window?.Swerve = require('swerve')

module.exports =
  Spine: Spine
  I18n:  I18n
