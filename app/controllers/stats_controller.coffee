{ Spine } = require 'lib/setup'
Me        = require 'models/me'

class StatsController extends Spine.Controller
  className: 'stats'

  elements:
    '.charity':   'charity'
    '.location':  'location'
    '.mug':       'mug'
    '.name':      'name'

  constructor: ->
    super
    @html require('views/stats')

    Me.bind 'refresh', (mes) =>
      me = mes[0]
      @mug.attr('src', me.profile_photo_url)
      @name.text("#{me.first_name} #{me.last_name[0]}.")
      @location.text("#{me.residence_city}, #{me.residence_state}")
      @charity.text(me.charity)

module.exports = StatsController
