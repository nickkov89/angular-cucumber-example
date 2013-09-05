portal.filter 'firstLetter', ->
  (input) -> "#{input[0]}." if input
