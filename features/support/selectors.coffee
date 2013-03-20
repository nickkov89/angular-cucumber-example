module.exports =
  # Elements

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

  '^the? global header$':                        '#brandfirst-header'
  '^the stats section$':                         '.stats'
  '^the brands section$':                        '#brands'
  '^the My Brands section$':                     '#my-brands'
  '^the New Brands section$':                    '#new-brands'
  '^the hide brands with no actions checkbox$':  '#hide-empty-brands'

  # Fall through

  '^(.+)$': (selector) ->
    console.log "\n\nNo selector was found for '#{selector}'"
    console.log "Please do not commit code that uses this into master\n"
    return selector
