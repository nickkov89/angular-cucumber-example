$ = require('spine').$

module.exports =
  tooltip: (options) =>
    @$('.tooltipped').each (i, el) =>
      defaults =
        animation: true
        delay:     0
        html:      true
        placement: $(el).data('placement') || 'top'
        title:     -> $("##{ $(el).data('tooltip-id') }").html()
        trigger:   'hover'
      $(el).tooltip $.extend(defaults, options)
