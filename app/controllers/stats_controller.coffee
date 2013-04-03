{ Spine } = require 'lib/setup'
Tipsyable = require 'lib/tipsyable'
Me        = require 'models/me'

class StatsController extends Spine.Controller
  className: 'stats'

  elements:
    '.awards-count':       'awardsCount'
    '.charity':            'charity'
    '.finishes-count':     'finishesCount'
    '.location':           'location'
    '.mug img':            'mug'
    '.name':               'name'
    '.stars-count':        'starsCount'
    '.status-plate':       'statusPlate'
    'img.one-year-ribbon': 'ribbon'

  constructor: ->
    super
    @html require('views/stats')

    Spine.bind 'member:saved', -> Me.fetch()

    Me.bind 'refresh', (mes) =>
      me = mes[0]
      @mug.attr('src', me.profile_photo_url)
      @name.text("#{me.first_name} #{me.last_name[0]}.")
      @location.text(me.cityState())
      @charity.text(me.charity)
      @starsCount.text(me.stars_count)
      @awardsCount.text(me.top_awards_count)
      @finishesCount.text(me.top_finish_count)
      @statusPlate.html require("views/stats/status_flag_#{me.flags_count}")

      created_at   = (new Date(me.created_at))
      one_year_ago = (new Date).addYears(-1)

      @ribbon.toggle(created_at.isBefore(one_year_ago) )

      Tipsyable.tipsy()

module.exports = StatsController
