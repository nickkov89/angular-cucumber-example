Spine   = require 'spine'
Charity = require 'models/charity'
Me      = require 'models/me'

class CarouselController extends Spine.Controller
  className: 'carousel-pane carousel slide controller'
  attributes: { id: 'welcome-carousel' }

  elements:
    '#crowdtap-notify-warning': 'warning'
    '#prizes form':             'charityForm'
    '.charity_id .controls':    'charityDropdown'

  events:
    'click .second-slide-confirm': 'moveNext'
    'click .third-slide-confirm':  'moveNext'
    'click .prize-confirm':        'updateMyCharity'
    'click #crowdtap-notify':      'displayWarning'

  constructor: ->
    super
    @html require('views/welcome_modal/carousel')
    @el.carousel({ 'interval': false }).carousel('next')
    @el.mouseover()

    Charity.one 'refresh', =>
      @charityDropdown.html(
        require('views/welcome_modal/charity_dropdown')(
          charities:       Charity.all()
          default_charity: Charity.findByAttribute('default',  true)
        )
      )

    Charity.fetch()

  moveNext: (e) ->
    e.preventDefault()
    @el.carousel('next')

  displayWarning: (e) => @warning.toggle()

  updateMyCharity: (e) ->
    e.preventDefault()

    Me.first().fromForm(@charityForm).save()
    Spine.trigger 'modal:complete'

module.exports = CarouselController
