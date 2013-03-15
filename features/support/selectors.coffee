module.exports =
  # Elements

  '^the? global header$':   '#brandfirst-header'

  # Fall through

  '^(.+)$': (selector) ->
    console.log "\n\nNo selector was found for '#{selector}'"
    console.log "Please do not commit code that uses this into master\n"
    return selector
