Feature: Member sees stats plate
  As a member, I can see my profile information
  as well as my Crowdtap stats and status

  Background:
    Given the brands API request returns the following:
      | id    | name        | slug        | logo      | header_image_url | action_count | crowd_participant |
      | 12345 | Steak Shack | steak-shack | foo-1.jpg | bar-1.jpg        | 15           | true              |

  Scenario: Member sees one year ribbon
    Given I joined crowdtap over a year ago
    And I am on the portal page
    Then the one year ribbon should be visible
    When I hover over the one year ribbon
    Then I should see a tipsy tooltip containing "Thanks for being a member for a year!"

  Scenario: Member does not see one year ribbon
    Given I just joined crowdtap
    And I am on the portal page
    Then the one year ribbon should be hidden
