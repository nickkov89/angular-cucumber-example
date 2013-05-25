$ = require('spine').$

module.exports =
  tipsy: (options) =>
    @$('.tipsyable').each (i, el) =>
      defaults =
        fade:    true,
        opacity: 1
        html:    true
        gravity: $(el).data('gravity') || 's'
        title:   -> $("##{ $(el).data('tooltip-id') }").html()
      $(el).tipsy $.extend(defaults, options)
