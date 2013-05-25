Spine    = require 'spine'
Confirm  = require 'controllers/welcome_modal/confirm_controller'
Carousel = require 'controllers/welcome_modal/carousel_controller'
Me       = require 'models/me'

class WelcomeModalController extends Spine.Stack
  className: 'welcome-modal stack modal hide fade'
  attributes: { id: 'welcome-modal' }

  controllers:
    confirm:  Confirm
    carousel: Carousel

  routes:
    'welcome-carousel': 'carousel'

  default: 'confirm'

  constructor: ->
    super

    Me.one 'refresh', =>
      @el.modal({ keyboard: false, backdrop: 'static' })

    Spine.bind 'modal:complete', =>
      @el.modal('hide')

module.exports = WelcomeModalController
