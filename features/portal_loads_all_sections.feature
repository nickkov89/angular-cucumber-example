Feature: Member sees all sections of the Portal
  As a member, I can interact with the portal page

  Scenario: Member sees Portal sections
    Given I am on the portal page
    Then I should see the global header
    And I should see the stats section
