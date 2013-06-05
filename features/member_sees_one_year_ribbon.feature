Feature: Member sees stats plate
  As a member, I can see my profile information
  as well as my Crowdtap stats and status

  Scenario: Member sees one year ribbon
    Given I joined crowdtap over a year ago
    And I am on the portal page
    Then the one year ribbon should be visible
    When I hover over the one year ribbon
    Then I should see a tooltip containing "Thanks for being a member for a year!"

  Scenario: Member does not see one year ribbon
    Given I just joined crowdtap
    And I am on the portal page
    Then the one year ribbon should be hidden
