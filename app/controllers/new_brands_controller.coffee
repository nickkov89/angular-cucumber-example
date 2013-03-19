{ Spine } = require 'lib/setup'
Brand     = require 'models/brand'

class NewBrandsController extends Spine.Controller
  attributes:
    id: 'new-brands'

  elements:
    '.new-brands-list': 'list'

  constructor: ->
    super

    @html require('views/new_brands')

    Brand.bind 'refresh', =>
      brands = Brand.newBrands()
      @list.html require('views/shared/brand_box')(brands)

module.exports = NewBrandsController
