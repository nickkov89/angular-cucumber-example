{ Spine } = require('lib/setup')
Me        = require 'models/me'

class ConfirmController extends Spine.Controller
  className: 'confirmation-pane controller'

  elements:
    '.datepicker': 'datePicker'
    'form':        'form'

  events:
    'click a.info-confirm': 'save'

  constructor: ->
    super
    Me.bind 'error save', (me) => @render(me)

    Me.one 'refresh', (mes) =>
      me = mes[0]
      @render(me)
      me.bind 'ajaxSuccess', =>
        @navigate('welcome-carousel', shim: true)
        @append require('views/welcome_modal/tracking')
        Spine.trigger('member:saved')
      me.bind 'ajaxError', (_, xhr) => @render( JSON.parse(xhr.responseText) )

  save: (e) =>
    e.preventDefault()
    Me.first().fromForm(@form).save()

  render: (me) =>
    @html require('views/welcome_modal/confirm')(me)
    @datePicker.datepicker({
      format:    'MM d, yyyy',
      endDate:   Date.today().add({years: -13})
      startDate: Date.today().add({years: -113})
    })

module.exports = ConfirmController
