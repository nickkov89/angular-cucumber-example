Spine    = require 'spine'
Resource = require '../lib/resource'

class Me extends Spine.Model
  @configure 'Me', 'id', 'first_name', 'last_name', 'email', 'charity', 'charity_id',
                   'flags_count', 'profile_photo_url', 'stars_count', 'residence_city',
                   'residence_state', 'top_awards_count', 'top_finish_count'

  @extend Spine.Model.Ajax
  @extend Resource

  @url: '/api/v2/me'

module.exports = Me
