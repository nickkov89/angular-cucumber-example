module.exports =
  # Elements

  '^(.*) within (.*)$': (inner, outer) ->
    return "#{@selectorFor(outer)} #{@selectorFor(inner)}"

  '^the "([^"]*)" image$': (imageUrl) ->
    return "img[src='#{imageUrl}']"

  '^the (.+) plate$': (which) ->
    return ".#{which}-plate"

  '^the? global header$':  '#brandfirst-header'
  '^the stats section$':   '.stats'

  # Fall through

  '^(.+)$': (selector) ->
    console.log "\n\nNo selector was found for '#{selector}'"
    console.log "Please do not commit code that uses this into master\n"
    return selector
