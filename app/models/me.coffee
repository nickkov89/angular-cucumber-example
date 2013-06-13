require('../lib/date-utils')
Spine    = require('spine')
Resource = require('../lib/resource')

class Me extends Spine.Model
  @configure 'Me', 'id', 'first_name', 'last_name', 'gender', 'email', 'residence_zip_code', 'date_of_birth',
                    'charity_id', 'shipping_phone', 'residence_city', 'residence_state', 'shipping_city',
                    'shipping_state', 'shipping_address1', 'shipping_address2', 'shipping_zip_code'
                    'hide_location', 'has_linked_twitter', 'blog_url',
                    'notify_of_new_actions_and_awards', 'notify_of_new_brands'

  @extend Spine.Model.Ajax
  @extend Resource

  @url: '/api/v2/me'

  cityState: ->
    if @residence_city then "#{@residence_city}, #{@residence_state}" else ""

  validate: ->
    @errors = {}

    @residence_zip_code or= ''
    @email              or= ''
    @shipping_address1  or= ''
    @shipping_address2  or= ''
    @shipping_city      or= ''
    @shipping_state     or= ''
    @shipping_phone     or= ''
    @shipping_zip_code  or= ''

    @errors.residence_zip_code = 'Please enter a valid ZipCode (#####)'           unless @residence_zip_code.match(new RegExp(/^\d{5}$/))
    @errors.residence_zip_code = 'ZipCode is Required'                            unless @residence_zip_code
    @errors.name               = 'Your First and Last Name are Required'          unless @last_name and @first_name
    @errors.date_of_birth      = 'You must be at least 13 years old'              unless new Date(Date.parse(@date_of_birth)).isBefore(Date.today().add({years: -13}))
    @errors.date_of_birth      = 'Birthday is Required'                           unless @date_of_birth
    @errors.email              = 'Please enter a valid email (handle@domain.net)' unless @email.match(new RegExp(/[\w\d]+@[\w\d]+\.[\w\d]+/))
    @errors.email              = 'Email is Required'                              unless @email

    if @shipping_address1 != '' or @shipping_address2 != '' or @shipping_city != '' or @shipping_phone != '' or @shipping_zip_code != '' or @shipping_state != ''

      @errors.shipping_address1  = 'Address One is too long (maximum is 35 characters)' unless @shipping_address1.length < 35
      @errors.shipping_address1  = 'Address One is Required'                            unless @shipping_address1
      @errors.shipping_address2  = 'Address Two is too long (maximum is 35 characters)' unless @shipping_address2.length < 35
      @errors.shipping_zip_code  = 'Please enter a valid ZipCode (#####)'               unless @shipping_zip_code.match(new RegExp(/^\d{5}$/))
      @errors.shipping_zip_code  = 'ZipCode is Required'                                unless @shipping_zip_code
      @errors.shipping_city      = 'City is Required'                                   unless @shipping_city
      @errors.shipping_state     = 'State is Required'                                  unless @shipping_state
      @errors.shipping_phone     = 'Please enter a valid phone number (###-###-####)'   unless @shipping_phone.match(new RegExp(/^1?\W*\d{3}\W*\d{3}\W*\d{4}$/))

    @errors if !!Object.keys(@errors).length

module.exports = Me
