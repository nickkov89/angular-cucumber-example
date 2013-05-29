require 'json2ify'
require 'es5-shimify'
require 'spine/lib/ajax'
require 'spine/lib/manager'
require 'spine/lib/route'

Spine = require 'spine'

environments =
  development:
    real_browser:   true
    assetPrefixUrl: 'http://d18w78eemwzu3j.cloudfront.net/crowdtap.portal'
    copycopter:
      apiKey: '0f393bf25199072b53d57bdde4480101'
      host:   'copycopter.crowdtap.com'
  local:
    real_browser:   true
    assetPrefixUrl: 'http://localhost:9295'
    copycopter:
      apiKey: 'api-key'
      host:   'localhost:4004'
  test:
    real_browser:   false
    assetPrefixUrl: ''
    copycopter:
      apiKey: 'api-key'
      host:   'copycopter.example.com'
  production:
    real_browser:   true
    assetPrefixUrl: 'http://d18w78eemwzu3j.cloudfront.net/crowdtap.portal'
    hashAssets:     true
    copycopter:
      apiKey: '0f393bf25199072b53d57bdde4480101'
      host:   'copycopter.crowdtap.com'
  staging:
    real_browser:   true
    assetPrefixUrl: 'http://localhost:9295'
    copycopter:
      apiKey: '0f393bf25199072b53d57bdde4480101'
      host:   'copycopter.crowdtap.com'

PortalApp = {}
PortalApp.setEnv  = (options) ->
  @env            = environments[options.env] || environments.development
  @current_user   = options.current_user
  @assets_version = options.assets_version
  @CopyCopter     = require('copycopter')(@env.copycopter)
  @H              = require('lib/helpers')
  @Swerve         = require('swerve')
  @Swerve.setEnv(options.env)

module.exports = window.PortalApp = PortalApp
