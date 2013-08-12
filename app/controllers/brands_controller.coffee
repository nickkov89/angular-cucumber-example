Spine   = require 'spine'
Brand   = require 'models/brand'
Me      = require 'models/me'
Tooltip = require 'lib/tooltip'

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
    'click a.brand-box':         'trackBrandVisit'
    'change #hide-empty-brands': 'changeHideEmptyBrands'

  constructor: ->
    super
    @html require('views/brands')

    Me.fetch()
    Me.one 'refresh', =>
      Brand.fetch(data: 'all=true')
      Brand.one 'refresh', =>
        @html require('views/brands')
        @update()
        Brand.bind 'refresh', @update

  update: =>
    if Brand.totalActions() == 0 && Brand.myBrands().length > 0
      @noActionsContainer.html require('views/brands/actions_zero_state')
      @hideBrandsCheckbox.attr
        checked:  false
        disabled: true
    else
      @hideBrandsCheckbox.attr('checked', Me.first().hide_empty_brands)

    @renderBrandsLists(false)
    Tooltip.tooltip(placement: 'bottom')

  renderBrandsLists: (animate) =>
    @renderBrandsList('my', animate)
    @renderBrandsList('new', animate)

  changeHideEmptyBrands: =>
    me = Me.first()
    me.hide_empty_brands = @hideBrandsCheckbox.is(':checked')
    me.save()
    @renderBrandsLists()

  renderBrandsList: (type, animate) =>
    properName = "#{type}Brands"
    grid       = @["#{properName}Grid"]
    brands     = Brand[properName]()

    grid.html require("views/brands/brand_box")(brands)

    @["#{properName}Count"].text(brands.length || '-')
    @["#{properName}ActionsCount"].text(Brand.totalActions(properName) || '-')
    @refreshElements()

    if type == 'my'
      if brands.length
        if @hideBrandsCheckbox.is(':checked')
          remove = => @myBrandsEmpty.remove()
          if animate
            @myBrandsEmpty.addClass('bounceOut')
            setTimeout remove, 180
          else
            remove()

          grid.html require("views/brands/#{type}_brands_zero_actions") unless Brand.totalActions(properName)
      else if @hideBrandsCheckbox.is(':checked')
        grid.html require("views/brands/#{type}_brands_zero_state")

    else
      grid.html require("views/brands/#{type}_brands_zero_state") if !brands.length

  trackBrandVisit: (event) ->
    mixpanel.track('Brand Visit', { internal_referrer: 'Portal' })

module.exports = BrandsController
