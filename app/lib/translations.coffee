I18n.translations = { en: {} }

exports.onLoaded = (callback) ->
  $.ajax
    url: Spine.env.copycopterUrl
    cache: true
    dataType: 'jsonp'
    timeout: 400
  .always (data) ->
    I18n.translations.en = data.en || {}
    callback() if callback

module.exports = exports
