module.exports =
  # Elements

  # Shared

  '^(.*) within (.*)$': (inner, outer) ->
    return "#{@selectorFor(outer)} #{@selectorFor(inner)}"

  '^the "([^"]*)" image$': (imageUrl) ->
    return "img[src='#{imageUrl}']"

  '^the "([^"]*)" icon$': (name) ->
    return "i.icon-#{name}"

  '^"([^"]*)" linking to "([^"]*)"$': (text, url) ->
    return "a[href*='#{url}']:contains('#{text}')"

  '^the brand menu item for brand "(.+)"$': (brand_id) ->
    return "#brand-menu li.#{brand_id}"

  # Portal-specific

  '^the (.+) plate$': (which) ->
    return ".#{which}-plate"

  '^the "([^"]*)" brand box$': (slug) ->
    return "a##{slug}.brand-box[href='/#{slug}']"

  '^the (brands|actions) count of the (my|new) brands section$': (countType, section) ->
    return "##{section}-brands .#{countType}-count"

  '^the? global header$':                        '#brandfirst-header'
  '^the stats section$':                         '.stats'
  '^the brands section$':                        '#brands'
  '^the My Brands section$':                     '#my-brands'
  '^the New Brands section$':                    '#new-brands'
  '^the hide brands with no actions checkbox$':  '#hide-empty-brands'
  '^the intro zero state$':                      '#my-brands-zero-state'
  '^the no actions zero state$':                 '#no-actions-zero-state'
  '^the my brands zero state$':                  '#my-brands-zero-actions'
  '^the new brands zero state$':                 '#new-brands-zero-actions'
  '^the brand menu$':                            '#brand-menu'
  '^the footer$':                                'footer'

  # Fall through

  '^(.+)$': (selector) ->
    console.log "\n\nNo selector was found for '#{selector}'"
    console.log "Please do not commit code that uses this into master\n"
    return selector
