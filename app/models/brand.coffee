Spine = require('spine')

class Brand extends Spine.Model
  @configure 'Brand', 'id', 'name', 'slug', 'description', 'header_image_url', 'logo', 'actions_count',
                      'actions_new', 'actions_expiring', 'actions_in_progress', 'crowd_participant'

  @extend Spine.Model.Ajax

  @url: '/api/v2/brands'

  @myBrands: ->
    @select (brand) -> brand.crowd_participant

  @newBrands: ->
    @select (brand) -> !brand.crowd_participant && brand.actions_count > 0

  @totalActions: (set) ->
    brands = if set? then @[set]() else @all()
    action_counts = brands.map (brand) -> parseInt brand.actions_count
    if action_counts.length then action_counts.reduce (acc, count) -> acc + count else 0

module.exports = Brand
