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

Factory.define 'Brand',
  id:                 12345
  name:               'Bexpedia'
  slug:               'bexpedia'
  description:        'The dreams of yesterday are the hopes of today and the reality of tomorrow.'
  header_image_url:   'http://static.movember.com/uploads/images/2012/Homepage%20tiles/thanks.jpg'
  logo:               'http://dummyimage.com/33x33/333/fff.jpg&text=logo'
  action_count:       12
  crowd_participant:  true
