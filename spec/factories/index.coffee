{ Factory } = require 'forgery'

# Define Factories bellow this line

Factory.define 'Me',
  id:                 1234
  first_name:         'Richard'
  last_name:          'Branson'
  email:              'sir.richard@example.com'
  charity:            'American National Red Cross'
  charity_id:         3
  flags_count:        0
  profile_photo_url:  'http://dummyimage.com/50x50/000/fff.jpg&text=me'
  stars_count:        200
  residence_city:     'Brooklyn'
  residence_state:    'NY'
  top_awards_count:   45
  top_finish_count:   12
