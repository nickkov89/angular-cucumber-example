{ Spine } = require 'lib/setup'
Brand     = require 'models/brand'

class BrandsController extends Spine.Controller
  attributes:
    id: 'brands'

  elements:
    '#my-brands':                          'myBrands'
    '#new-brands':                         'newBrands'
    '#my-brands a[data-action-count=0]':   'myBrandsEmpty'
    '#new-brands a[data-action-count=0]':  'newBrandsEmpty'
    '#hide-empty-brands':                  'hideBrandsCheckbox'
    '#no-actions-container':               'noActionsContainer'

  events:
    'click #hide-empty-brands':  'renderBrandsLists'

  constructor: ->
    super
    @html require('views/brands')
    Brand.bind 'refresh', @update

  update: =>
    if Brand.totalActions() == 0
      @noActionsContainer.html require('views/brands/actions_zero_state')
      @hideBrandsCheckbox.attr
        checked:  false
        disabled: true

    @renderBrandsLists()

  renderBrandsLists: =>
    @renderBrandsList('my')
    @renderBrandsList('new')

  renderBrandsList: (type) =>
    properName = "#{type}Brands"
    section    = @[properName]
    brands     = Brand[properName]()

    section.html require('views/brands/brand_box')(brands)
    @refreshElements()

    if @hideBrandsCheckbox.is(':checked')
      @["#{properName}Empty"].remove()
      section.html require("views/brands/#{type}_brands_zero_actions") unless Brand.totalActions(properName)

    section.html require("views/brands/#{type}_brands_zero_state") if !brands.length

module.exports = BrandsController
