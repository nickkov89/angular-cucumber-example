{ Spine } = require 'lib/setup'

HeaderController = require 'controllers/header_controller'
StatsController  = require 'controllers/stats_controller'
Me               = require 'models/me'

class Portal extends Spine.Controller
  elements:
    '#brandfirst-header': 'header'

  constructor: (options) ->
    Spine.env = Spine.environments[options.env] || Spine.environments.development
    Spine.current_user = options.current_user
    Spine.assets_version = options.assets_version
    super

    @append new HeaderController()
    @append new StatsController()

    Me.fetch()

module.exports = Portal
