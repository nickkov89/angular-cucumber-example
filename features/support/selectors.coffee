module.exports =

  # Shared

  '^(.*) within (.*)$': (inner, outer) ->
    "#{@selectorFor(outer)} #{@selectorFor(inner)}"

  '^the "([^"]*)" image$': (imageUrl) ->
    "img[src='#{imageUrl}']"

  '^the "([^"]*)" icon$': (name) ->
    "i.icon-#{name}"

  '^"([^"]*)" linking to "([^"]*)"$': (text, url) ->
    "a[href*='#{url}']:contains('#{text}')"

  '^"([^"]*)"$': (text) ->
    "a:contains(#{text})"

  '^the brand menu item for brand "(.+)"$': (brand_id) ->
    "#brand-menu li.#{brand_id}"

  # Portal-specific

  '^the (.+) plate$': (which) ->
    ".#{which}-plate"

  '^the "([^"]*)" brand box$': (slug) ->
    "a##{slug}.brand-box[href='/#{slug}']"

  '^the "([^"]*)" brand box header$': (slug) ->
    "##{slug}.brand-box .brand-header"

  '^the (brands|actions) count of the (my|new) brands section$': (countType, section) ->
    "##{section}-brands .#{countType}-count"

  '^the (new|in-progress|expiring) actions count badge for "([^"]+)"$': (type, slug) ->
    "##{slug} .actions-count-#{type}"

  '^the stats section$':                         '.stats'
  '^the brands section$':                        '#brands'
  '^the My Brands section$':                     '#my-brands'
  '^the New Brands section$':                    '#new-brands'
  '^the hide brands with no actions checkbox$':  '#hide-empty-brands'
  '^the no actions zero state$':                 '#no-actions-zero-state'
  '^the my brands zero state$':                  '#my-brands-zero-state'
  '^the my brands zero actions state$':          '#my-brands-zero-actions'
  '^the new brands zero state$':                 '#new-brands-zero-state'
  '^the footer$':                                'footer'
  '^the status help icon$':                      '.status-plate .status-help'
  '^the one year ribbon$':                       'img.one-year-ribbon'

  '^the (.+) input with the value "([^"]+)"$': (field, value) ->
    "input[id*='#{field.toUnderscore()}'][value='#{value}']"

  '^the (.+) input with the selected value "([^"]+)"$': (field, value) ->
    "select[id*='#{field.toUnderscore()}'] option[value='#{value}'][selected]"

  '^the (.+) pane$': (type) ->
    ".#{type}-pane"

  '^the (.+) item$': (slide) ->
    "##{slide}"

  '^the (.+) input$': (id) ->
    "input[id*='#{id.toUnderscore()}']"

  '^the (active|completed) (carousel|list) actions?$': (type, section) ->
    "##{type}-actions-#{section}"

  '^the (.+) control group error$': (type) ->
    ".control-group.#{type.toUnderscore()}.error .help-block"

  # Fall through

  '^(.+)$': (selector) ->
    console.log "\n\nNo selector was found for '#{selector}'"
    console.log "Please do not commit code that uses this into master\n"
    selector
