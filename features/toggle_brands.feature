Feature: Member can hide brands with no actions
  As a member, in order to see what brands I can participate in
  I can hide and show brands based on available actions

  Background:
    Given I am participating with the following brands:
      | id    | name        | slug        | logo      | header_image_url | action_count |
      | 12345 | Steak Shack | steak-shack | foo-1.jpg | bar-1.jpg        | 15           |
      | 12346 | McRonalds   | mcronalds   | foo-2.jpg | bar-2.jpg        | 0            |
    And I am on the portal page

  Scenario: Member sees the hide brands with no actions checkbox
    Then I should see the hide brands with no actions checkbox
    And the hide brands with no actions checkbox should be checked

  Scenario: Member toggles brands with no available actions
    Then the "steak-shack" brand box should be visible
    But the "mcronalds" brand box should be hidden
    When I uncheck the hide brands with no actions checkbox
    Then the "steak-shack" brand box should be visible
    And the "mcronalds" brand box should be visible
