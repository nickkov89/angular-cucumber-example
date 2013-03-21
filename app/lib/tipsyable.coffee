$ = require('lib/setup').Spine.$

module.exports =
  tipsy: (options) =>
    @$('.tipsyable').each (i, el) =>
      defaults =
        fade:    true,
        opacity: 1
        html:    true
        gravity: $(el).data('gravity')
        title:   -> $("##{ $(el).data('tooltip-id') }").html()
      $(el).tipsy $.extend(defaults, options)
