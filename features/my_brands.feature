Feature: Member sees My Brands section
  As a member, in order to navigate to my brands
  I can view a list of brands I'm currently participating in

  Scenario: Member sees my brands grid
    Given I am participating with the following brands:
      | id    | name        | slug        | logo      | header_image_url | action_count |
      | 12345 | Steak Shack | steak-shack | foo-1.jpg | bar-1.jpg        | 15           |
      | 12346 | McRonalds   | mcronalds   | foo-2.jpg | bar-2.jpg        | 20           |
    And I am on the portal page
    Then I should see the "steak-shack" brand box within the My Brands section
    And the "steak-shack" brand box should have a background image of "bar-1.jpg"
    And I should see "Steak Shack" within the "steak-shack" brand box
    And I should see the "foo-1.jpg" image within the "steak-shack" brand box
    And I should see "15" within the "steak-shack" brand box
    And I should see the "mcronalds" brand box within the My Brands section
    And the "mcronalds" brand box should have a background image of "bar-2.jpg"
    And I should see "McRonalds" within the "mcronalds" brand box
    And I should see the "foo-2.jpg" image within the "mcronalds" brand box
    And I should see "20" within the "mcronalds" brand box

  Scenario: Member sees my brands counts
    Given the brands API request returns the following:
      | id    | name        | slug        | logo      | header_image_url | action_count | crowd_participant |
      | 12345 | Steak Shack | steak-shack | foo-1.jpg | bar-1.jpg        | 15           | true              |
      | 12346 | McRonalds   | mcronalds   | foo-2.jpg | bar-2.jpg        | 10           | false             |
    And I am on the portal page
    Then I should see "1" within the brands count of the my brands section
    And I should see "15" within the actions count of the my brands section
