{ Spine } = require 'lib/setup'

class HeaderController extends Spine.Controller
  className: 'brandfirst-header'
  attributes: { 'id': 'header-bar' }

  constructor: ->
    super
    @html require('views/header')

module.exports = HeaderController
