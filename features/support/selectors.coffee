module.exports =
  # Shared

  '^(.*) within (.*)$': (inner, outer) ->
    return "#{@selectorFor(outer)} #{@selectorFor(inner)}"

  '^the "([^"]*)" image$': (imageUrl) ->
    return "img[src='#{imageUrl}']"

  '^the "([^"]*)" icon$': (name) ->
    return "i.icon-#{name}"

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

  # Fall through

  '^(.+)$': (selector) ->
    console.log "\n\nNo selector was found for '#{selector}'"
    console.log "Please do not commit code that uses this into master\n"
    return selector
