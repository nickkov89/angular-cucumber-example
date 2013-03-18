{ Spine } = require 'lib/setup'

HeaderController = require 'controllers/header_controller'

class Portal extends Spine.Controller
  elements:
    '#brandfirst-header': 'header'

  constructor: (options) ->
    Spine.env = Spine.environments[options.env] || Spine.environments.development
    Spine.current_user = options.current_user
    Spine.assets_version = options.assets_version
    super

    @append new HeaderController()

module.exports = Portal
