{ Spine } = require 'lib/setup'
Brand     = require 'models/brand'

class BrandsController extends Spine.Controller
  attributes:
    id: 'brands'

  elements:
    '#my-brands .brands-grid':             'myBrandsGrid'
    '#new-brands .brands-grid':            'newBrandsGrid'
    '#my-brands a[data-action-count=0]':   'myBrandsEmpty'
    '#new-brands a[data-action-count=0]':  'newBrandsEmpty'
    '#hide-empty-brands':                  'hideBrandsCheckbox'
    '#no-actions-container':               'noActionsContainer'
    '#my-brands .brands-count':            'myBrandsCount'
    '#my-brands .actions-count':           'myBrandsActionsCount'
    '#new-brands .brands-count':           'newBrandsCount'
    '#new-brands .actions-count':          'newBrandsActionsCount'

  events:
    'click #hide-empty-brands':  'renderBrandsLists'

  constructor: ->
    super
    @html require('views/brands')
    Brand.bind 'refresh', @update

    Spine.bind 'member:saved', ->
      Brand.fetch()

  update: =>
    if Brand.totalActions() == 0 && Brand.myBrands().length > 0
      @noActionsContainer.html require('views/brands/actions_zero_state')
      @hideBrandsCheckbox.attr
        checked:  false
        disabled: true

    @renderBrandsLists(false)

  renderBrandsLists: (animate) =>
    @renderBrandsList('my', animate)
    @renderBrandsList('new', animate)

  renderBrandsList: (type, animate) =>
    properName = "#{type}Brands"
    grid       = @["#{properName}Grid"]
    brands     = Brand[properName]()

    grid.html require("views/brands/brand_box")(brands)

    @["#{properName}Count"].text brands.length
    @["#{properName}ActionsCount"].text Brand.totalActions(properName)
    @refreshElements()

    if type == 'my' && @hideBrandsCheckbox.is(':checked')
      remove = => @myBrandsEmpty.remove()
      if animate
        @myBrandsEmpty.addClass('bounceOut')
        setTimeout remove, 180
      else
        remove()
      grid.html require("views/brands/#{type}_brands_zero_actions") unless Brand.totalActions(properName)

    grid.html require("views/brands/#{type}_brands_zero_state") if !brands.length

module.exports = BrandsController
