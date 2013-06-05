Feature: Member can hide brands with no actions
  As a member, in order to see what brands I can participate in
  I can hide and show brands based on available actions

  Background:
    Given the brands API request returns the following:
      | id    | name        | slug        | logo      | header_image_url | actions_count | crowd_participant |
      | 12345 | Steak Shack | steak-shack | foo-1.jpg | bar-1.jpg        | 1             | true              |
      | 12346 | McRonalds   | mcronalds   | foo-2.jpg | bar-2.jpg        | 0             | true              |
      | 12347 | Half Foods  | half-foods  | foo-3.jpg | bar-3.jpg        | 1             | false             |
      | 12348 | Dairy King  | dairy-king  | foo-4.jpg | bar-4.jpg        | 0             | false             |
    Given the unfiltered brands API request returns the following:
      | id    | name        | slug        | logo      | header_image_url | actions_count | crowd_participant |
      | 12345 | Rolf Alot   | rolf-alot   | foo-1.jpg | bar-1.jpg        | 1             | true              |
      | 12346 | Chipolte    | chipolte    | foo-2.jpg | bar-2.jpg        | 0             | true              |
      | 12347 | Dorado      | dorado      | foo-3.jpg | bar-3.jpg        | 1             | false             |
     And I am on the portal page

  Scenario: Member sees the hide brands with no actions checkbox
    Then I should see the hide brands with no actions checkbox
    And the hide brands with no actions checkbox should be checked

  Scenario: Member toggles my brands with no available actions
    Then I should see the "steak-shack" brand box
    And I should see the "half-foods" brand box
    But I should not see the "mcronalds" brand box
    And I should not see the "dairy-king" brand box
    When I uncheck the hide brands with no actions checkbox
    Then I should see the "rolf-alot" brand box
    And I should see the "chipolte" brand box
    And I should see the "dorado" brand box
