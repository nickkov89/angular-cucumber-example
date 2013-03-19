Feature: Member sees stats plate
  As a member, I can see my profile information
  as well as my Crowdtap stats and status

  Scenario: Member sees all stats sections
    Given I am on the portal page
    Then I should see the me plate

  Scenario: Member sees profile information in me plate
    Given my name is "Bruce Wayne"
    And I live in "Williamsburg, NY"
    And I am supporting the "Red Cross" charity
    And I am on the portal page
    And I have set my avatar to "/url/profile.jpg"
    And I am on the portal page
    Then I should see "Bruce W." within the me plate
    And I should see "Williamsburg, NY" within the me plate
    And I should see "Red Cross" within the me plate
    And I should see the "/url/profile.jpg" image within the me plate
