{ Spine } = require('lib/setup')
Brand     = require 'models/brand'
Charity   = require 'models/charity'
Me        = require 'models/me'

class CarouselController extends Spine.Controller
  className: 'carousel-pane carousel slide controller'
  attributes: { id: 'welcome-carousel' }

  elements:
    '.carousel-inner':          'items'
    '.item#prizes':             'prizes'
    '#email-share':             'brandCheckbox'
    '#crowdtap-notify':         'crowdtapCheckbox'
    '#crowdtap-notify-warning': 'warning'
    '#prizes form':             'charityForm'

  events:
    'click .second-slide-confirm': 'moveNext'
    'click .third-slide-confirm':  'saveAndSubmitMe'
    'click .prize-confirm':        'updateMyCharity'
    'click #crowdtap-notify':      'displayWarning'

  constructor: ->
    super
    @html require('views/welcome_modal/carousel')

    Me.one 'refresh', =>
      Charity.one 'refresh', =>
        @items.append require('views/welcome_modal/welcome')
        @items.append require('views/welcome_modal/action')

        @items.append require('views/welcome_modal/prizes')(
          charities:       Charity.all()
          default_charity: Charity.findByAttribute('default',  true)
        )

        @refreshElements()
        @el.carousel({ 'interval': false }).carousel('next')
        @el.mouseover()

  saveAndSubmitMe: (event) =>
    event.preventDefault()
    me = Me.first()
    #TODO make sure to clean this up after Zombie upgrade
    #using the spine element doesnt work here for some reason
    me.can_be_contacted_by_crowdtap = !@$('#crowdtap-notify').attr('checked')
    me.update()
    @el.carousel('next')

  moveNext: (e) -> @el.carousel('next')

  displayWarning: (e) => @warning.toggle()

  updateMyCharity: (e) ->
    e.preventDefault()
    Me.first().fromForm(@charityForm).save()
    Spine.trigger 'modal:complete'

module.exports = CarouselController
