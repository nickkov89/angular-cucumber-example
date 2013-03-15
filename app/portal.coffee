{ Spine } = require 'lib/setup'

HeaderController = require 'controllers/header_controller'

class Portal extends Spine.Controller
  elements:
    '#brandfirst-header': 'header'

  constructor: (options) ->
    Spine.env = Spine.environments[options.env] || Spine.environments.development
    Spine.current_user = options.current_user
    super

    $.get('http://crowdtap-static-assets.s3.amazonaws.com/crowdtap.portal/LATEST').always (hash) =>
      Spine.assets_hash = hash

      @append new HeaderController()

module.exports = Portal
