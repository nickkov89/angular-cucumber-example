nock = require 'nock'
nock.recorder.rec(true)

RegExp.escape = (text) ->
  return text.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&")

recorder =
  all_requests: ->
    nock.recorder.play()

  requests: (requestType, path) ->
    regex = ///\.#{requestType}\('#{RegExp.escape(path)}'///m
    requests = []
    for request in nock.recorder.play()
      requests.push(request) if regex.test(request)

    return requests

  formatRequest: (request) ->
    requestTypeRegex    = /\.(post|get|put)\(/m
    pathRegex           = /\.(?:get|post|put)\('(.+)'.+/m
    paramsRegex         = /\.(?:get|post|put).+"({.+})".+/m
    responseStatusRegex = /\.reply\((\d{3})/m
    responseBodyRegex   = /\.reply\(.+"(.*)"/m

    if match = paramsRegex.exec(request)
      params = JSON.parse(match[1].replace(/\\/g,''))
    else
      params = {}

    return {
      requestType:  requestTypeRegex.exec(request)[1]
      path:         pathRegex.exec(request)[1]
      params:       params
      status:       parseInt(responseStatusRegex.exec(request)[1])
      body:         responseBodyRegex.exec(request)[1]
    }

for verb in ['Get', 'Post', 'Put']
  do (verb) ->
    lowercase = verb.toLowerCase()
    plural    = lowercase + 's'

    recorder[plural]              = (path) -> @requests(lowercase, path)
    recorder["all#{verb}sByPath"] = (path) -> @formatRequest(request) for request in @[plural](path)
    recorder["last#{verb}ByPath"] = (path) -> @["all#{verb}sByPath"](path).pop() || false

module.exports = recorder
