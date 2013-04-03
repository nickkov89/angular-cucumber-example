module.exports =
  # Shared

  '^(.*) within (.*)$': (inner, outer) ->
    return "#{@selectorFor(outer)} #{@selectorFor(inner)}"

  '^the "([^"]*)" image$': (imageUrl) ->
    return "img[src='#{imageUrl}']"

  '^the "([^"]*)" icon$': (name) ->
    return "i.icon-#{name}"

  '^"([^"]*)" linking to "([^"]*)"$': (text, url) ->
    return "a[href*='#{url}']:contains('#{text}')"

  '^"([^"]*)"$': (text) ->
    return "a:contains(#{text})"

  '^the brand menu item for brand "(.+)"$': (brand_id) ->
    return "#brand-menu li.#{brand_id}"

  # Portal-specific
  '^the (.+) plate$': (which) ->
    return ".#{which}-plate"

  '^the "([^"]*)" brand box$': (slug) ->
    return "a##{slug}.brand-box[href='/#{slug}']"

  '^the "([^"]*)" brand box header$': (slug) ->
    return "##{slug}.brand-box .brand-header"

  '^the (brands|actions) count of the (my|new) brands section$': (countType, section) ->
    return "##{section}-brands .#{countType}-count"

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

  #On Ramping Api
  'the me endpoint':                             '/api/v2/me'
  #On Ramp Modals
  '^actions?$':                             '.action'
  '^the welcome modal$':                    '#welcome-modal'
  '^the select your charity dropdown$':     'select.charity_id'
  '^the welcome modal header image$':       'img[src*="png"]'
  '^the share my email checkbox$':          '#email-share'
  '^the crowdtap can notify me checkbox$':  '#crowdtap-notify'
  '^the confirm tracking pixel$':           '.confirm-tracking-pixel'

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
    return "##{type}-actions-#{section}"

  '^the (.+) control group error$': (type) ->
    ".control-group.#{type.toUnderscore()}.error .help-block"

  # Fall through

  '^(.+)$': (selector) ->
    console.log "\n\nNo selector was found for '#{selector}'"
    console.log "Please do not commit code that uses this into master\n"
    return selector
