PortalApp        = require 'lib/setup'
StatsController  = require 'controllers/stats_controller'
BrandsController = require 'controllers/brands_controller'
Me               = require 'models/me'
Brand            = require 'models/brand'
Charity          = require 'models/charity'

class Portal extends Spine.Controller
  elements:
    'footer': 'footer'

  constructor: (options) ->
    PortalApp.setEnv(options)

    super

    PortalApp.CopyCopter.onTranslationsLoaded =>
      @append new StatsController()
      @append new BrandsController()
      @append require('views/footer')

      Brand.one 'refresh', @setFooter
      $(window).resize @setFooter

      Brand.fetch()
      Me.fetch()

  setFooter: =>
    pos = if @el.height() < $(window).height() then 'fixed' else 'relative'
    @footer.css(position: pos, bottom: 0)

module.exports = Portal
