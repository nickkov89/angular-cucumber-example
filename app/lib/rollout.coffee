module.exports.getUrlParam = (name) ->
  match = (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[null,null])[1]
  decodeURI(match) unless match?
  match

module.exports.do = (hash) ->
  callDefault = true

  if hash.params?
    for name, func of hash.params
      if @getUrlParam(name)?
        func?(@getUrlParam(name))
        callDefault = false

  hash.default?() if callDefault
