Spine = require('spine')

class Charity extends Spine.Model
  @configure 'Charity', 'name', 'description','website_url', 'logo_url', 'default'
  @extend Spine.Model.Ajax
  @url: '/api/v2/charities'

module.exports = Charity
