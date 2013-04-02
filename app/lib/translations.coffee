I18n.translations = { en: {} }

translations = ->
  loaded    = false
  loading   = false
  callbacks = []

  load = ->
    xhr = $.ajax
      url:        Spine.env.copycopterUrl
      cache:      true
      dataType:   'jsonp'
      beforeSend: -> loading = true

    xhr.always (data) -> I18n.translations.en = data.en || {}
    xhr.always        -> loaded = true
    xhr.always        -> callback() while callback = callbacks.shift()

  queue = (callback) ->
    if callback
      if loaded then callback() else callbacks.push callback
    load() unless loading

  return onLoaded: queue

module.exports = translations()
