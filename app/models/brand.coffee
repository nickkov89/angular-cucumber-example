Spine = require('spine')

class Brand extends Spine.Model
  @configure 'Brand', 'id', 'name', 'slug', 'description', 'header_image_url', 'logo', 'action_count', 'crowd_participant'

  @extend Spine.Model.Ajax

  @url: '/api/v2/brands'

  @myBrands: ->
    @select (brand) -> brand.crowd_participant

  @newBrands: ->
    @select (brand) -> !brand.crowd_participant

module.exports = Brand
