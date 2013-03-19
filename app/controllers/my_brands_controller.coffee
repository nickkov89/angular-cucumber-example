{ Spine } = require 'lib/setup'
Brand     = require 'models/brand'

class MyBrandsController extends Spine.Controller
  attributes:
    id: 'my-brands'

  elements:
    '.my-brands-list': 'list'

  constructor: ->
    super

    @html require('views/my_brands')

    Brand.bind 'refresh', =>
      brands = Brand.all()
      @list.html require('views/shared/brand_box')(brands)

module.exports = MyBrandsController
