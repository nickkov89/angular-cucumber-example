Feature: Member sees New Brands section
  As a member, in order to discover new brands
  I can view a list of brands I'm not currently participating in

  Scenario: Member sees new brands grid
    Given I am not participating with the following brands:
      | id    | name       | slug       | logo      | header_image_url | action_count |
      | 12345 | Tres Toros | tres-toros | foo-1.jpg | bar-1.jpg        | 15           |
      | 12346 | Half Foods | half-foods | foo-2.jpg | bar-2.jpg        | 20           |
    And I am on the portal page
    Then I should see the "tres-toros" brand box within the New Brands section
    And the "tres-toros" brand box should have a background image of "bar-1.jpg"
    And I should see "Tres Toros" within the "tres-toros" brand box
    And I should see the "foo-1.jpg" image within the "tres-toros" brand box
    And I should see "15" within the "tres-toros" brand box
    And I should see the "half-foods" brand box within the New Brands section
    And the "half-foods" brand box should have a background image of "bar-2.jpg"
    And I should see "Half Foods" within the "half-foods" brand box
    And I should see the "foo-2.jpg" image within the "half-foods" brand box
    And I should see "20" within the "half-foods" brand box

  Scenario: Member sees new brands counts
    Given the brands API request returns the following:
      | id    | name        | slug        | logo      | header_image_url | action_count | crowd_participant |
      | 12345 | Steak Shack | steak-shack | foo-1.jpg | bar-1.jpg        | 15           | true              |
      | 12346 | McRonalds   | mcronalds   | foo-2.jpg | bar-2.jpg        | 10           | false             |
    And I am on the portal page
    Then I should see "1" within the brands count of the new brands section
    And I should see "10" within the actions count of the new brands section
