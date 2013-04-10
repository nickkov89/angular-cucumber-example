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
  profile_photo_url:  'http://dummyimage.com/75x75/000/fff.jpg&text=me'
  stars_count:        200
  residence_city:     'Brooklyn'
  residence_state:    'NY'
  top_awards_count:   45
  top_finish_count:   12
  date_of_birth:      '8/12/1985'
  residence_zip_code: '11201'

Factory.define 'Brand',
  id:                  12345
  name:                'Bexpedia'
  slug:                'bexpedia'
  description:         'The dreams of yesterday are the hopes of today and the reality of tomorrow.'
  header_image_url:    'http://dummyimage.com/300x128/000/fff.jpg&text=header'
  logo:                'http://dummyimage.com/33x33/333/fff.jpg&text=logo'
  action_count:        12
  actions_new:         3
  actions_expiring:    2
  actions_in_progress: 1
  crowd_participant:   true
  me:
    id: "2007"
    first_name: "Rooner"
    last_name: "Moop"
    profile_photo_url: "http://dummyimage.com/75x75/000/fff.png&text=face"
    tiny_profile_photo_url: "http://dummyimage.com/24x24/000/fff.png&text=face"
    member_profile_path: "This is a path"
    points: "25040"
    entries: "2500"
    lifetime_points: "4000"
    points_to_top_drawing: "3000"
    level: 3
    rank: 2000
    max_rank: 4000
    current_level_threshold: 2000
    next_level_threshold: 6000
    charity: "Mens Health"

Factory.define 'Charity',
  id:           '51000e076d741fb2dd000040'
  name:         'Bacon Trust'
  description:  'Trust in Bacon'
  website_url:  'http://www.trustinbacon.com'
  logo_url:     'http://www.sixdegrees.org/sites/all/themes/sixdegrees/images/logo-six-degrees.png'
  default:      false
