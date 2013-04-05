require('lib/setup')

StatsController  = require 'controllers/stats_controller'
BrandsController = require 'controllers/brands_controller'
Me               = require 'models/me'
Brand            = require 'models/brand'
WelcomeModal     = require 'controllers/welcome_modal'
Charity          = require 'models/charity'
Translations     = require 'lib/translations'

class Portal extends Spine.Controller
  elements:
    'footer': 'footer'

  constructor: (options) ->
    Spine.env = Spine.environments[options.env] || Spine.environments.development
    Spine.current_user = options.current_user
    Spine.assets_version = options.assets_version
    Spine.config =
      show_welcome_modal: options.show_welcome_modal
    super

    Translations.onLoaded =>
      @append new StatsController()
      @append new BrandsController()
      @append require('views/footer')

      @setFooter()
      $(window).resize @setFooter

      if Spine.config.show_welcome_modal
        @append( new WelcomeModal )

      Brand.fetch()
      Me.fetch()

  setFooter: =>
    pos = if @el.height() < $(window).height() then 'fixed' else 'relative'
    @footer.css(position: pos, bottom: 0)

module.exports = Portal
