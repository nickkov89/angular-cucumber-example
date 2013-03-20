{ Spine } = require 'lib/setup'
Brand     = require 'models/brand'

class BrandsController extends Spine.Controller
  attributes:
    id: 'brands'

  elements:
    '.brand-box[data-action-count=0]':  'emptyBrands'
    '#hide-empty-brands':               'hideBrandsCheckbox'
    '#my-brands':                       'myBrands'
    '#new-brands':                      'newBrands'

  events:
    'click #hide-empty-brands':  'toggleEmptyBrands'

  constructor: ->
    super
    @html require('views/brands')
    Brand.bind 'refresh', @update

  update: =>
    @myBrands.html  require('views/brands/brand_box')(Brand.myBrands())
    @newBrands.html require('views/brands/brand_box')(Brand.newBrands())
    @refreshElements()
    @toggleEmptyBrands()

  toggleEmptyBrands: =>
    @emptyBrands.toggle !@hideBrandsCheckbox.is(':checked')

module.exports = BrandsController
