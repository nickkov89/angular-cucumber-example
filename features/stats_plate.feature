Feature: Member sees stats plate
  As a member, I can see my profile information
  as well as my Crowdtap stats and status

  Scenario: Member sees all stats sections
    Given I am on the portal page
    Then I should see the me plate
    And I should see the status plate
    And I should see the stars plate
    And I should see the awards plate
    And I should see the finishes plate

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

  Scenario: Member sees good current status with Crowdtap
    Given I have been flagged 0 times
    And I am on the portal page
    Then I should see "In good standing" within the status plate
    And I should see the "ok-circle" icon within the status plate
    And I should see the status help icon
    When I hover over the status help icon
    Then I should see a tipsy tooltip containing "You have no flags."

  Scenario: Member sees warning current status with Crowdtap
    Given I have been flagged 1 time
    And I am on the portal page
    Then I should see "In good standing" within the status plate
    And I should see the "warning-sign" icon within the status plate
    And I should see the status help icon
    When I hover over the status help icon
    Then I should see a tipsy tooltip containing "You've been flagged 1 time."

  Scenario: Member sees stars count
    Given I have earned 100 stars
    And I am on the portal page
    Then I should see "100" within the stars plate

  Scenario: Member sees top awards count
    Given I have earned 20 top awards
    And I am on the portal page
    Then I should see "20" within the awards plate

  Scenario: Member sees top finishes count
    Given I have 30 top 100 finishes
    And I am on the portal page
    Then I should see "30" within the finishes plate
