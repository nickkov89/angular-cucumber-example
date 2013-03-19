{ Spine } = require 'lib/setup'
Me        = require 'models/me'

class StatsController extends Spine.Controller
  className: 'stats'

  elements:
    '.awards-count':    'awardsCount'
    '.charity':         'charity'
    '.finishes-count':  'finishesCount'
    '.location':        'location'
    '.mug':             'mug'
    '.name':            'name'
    '.stars-count':     'starsCount'

  constructor: ->
    super
    @html require('views/stats')

    Me.bind 'refresh', (mes) =>
      me = mes[0]
      @mug.attr('src', me.profile_photo_url)
      @name.text("#{me.first_name} #{me.last_name[0]}.")
      @location.text("#{me.residence_city}, #{me.residence_state}")
      @charity.text(me.charity)
      @starsCount.text(me.stars_count)
      @awardsCount.text(me.top_awards_count)
      @finishesCount.text(me.top_finish_count)

module.exports = StatsController
