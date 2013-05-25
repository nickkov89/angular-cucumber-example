PortalApp = require 'lib/setup'
Spine     = require 'spine'
Resource  = require '../lib/resource'

class BrandMe extends Spine.Model
  @configure 'BrandMe', 'id', 'member_id', 'brand_id', 'can_be_contacted_by_brand'

  @extend Spine.Model.Ajax
  @extend Resource

  @url: ->
    "/api/v2/brands/#{PortalApp.current_brand.id}/me"

module.exports = BrandMe
