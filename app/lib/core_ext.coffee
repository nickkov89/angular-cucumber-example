String.prototype.commaFormatted = ->
  regex  = /^(\d+)(\d{3})/
  number = @
  number = number.replace(regex, '$1,$2') while regex.test(number)
  number + ''

String.prototype.toUnderscore = ->
  return @replace(/([a-z\d])([A-Z]+)/g, '$1_$2')
           .replace(/[-\?\s]+/g, '_')
           .replace(/[^a-zA-Z0-9_]/g, '')
           .toLowerCase()

String.prototype.dasherize = ->
  return @toUnderscore().replace(/_/g, '-')

Number.prototype.commaFormatted = ->
  @toString().commaFormatted()
