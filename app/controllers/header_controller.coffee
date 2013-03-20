{ Spine } = require 'lib/setup'
Brand = require 'models/brand'

class HeaderController extends Spine.Controller
  className: 'brandfirst-header'
  attributes: { 'id': 'header-bar' }

  elements:
    '#brand-menu .dropdown > a':              'brandMenuLink'
    '#brand-menu ul.dropdown-menu .wrapper':  'brandMenuList'
    '.user-specific .profile-link':           'profileLink'

  constructor: ->
    super
    @html require('views/header')
    Brand.bind 'refresh', @renderBrandMenu

  renderBrandMenu: =>
    brand_menu_items = Brand.all()
    brand_ids = (brand.id for brand in brand_menu_items)
    brand_menu_items = Brand.all()

    if brand_menu_items.length > 0
      @brandMenuList.html require('views/brand_header/brand_menu_item')(brand_menu_items)

      sum = 0
      for item in brand_menu_items
        sum += parseInt(item.action_count)
      @brandMenuLink.append require('views/brand_header/badge')(count: sum)
    else
      @brandMenuList.html require('views/brand_header/brand_menu_empty')

module.exports = HeaderController
