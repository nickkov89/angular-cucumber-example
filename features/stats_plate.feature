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
    Then I should see a tooltip containing "You have 0 flags. You receive flags for inappropriate submissions for Crowdtap actions."

  Scenario: Member has been flagged once
    Given I have been flagged 1 time
    And I am on the portal page
    Then I should see "In good standing" within the status plate
    And I should see the "warning-sign" icon within the status plate
    And I should see the status help icon
    When I hover over the status help icon
    Then I should see a tooltip containing "You have 1 flag. Try to avoid receiving more flags to remain in good standing."

  Scenario: Member has been flagged twice
    Given I have been flagged 2 time
    And I am on the portal page
    Then I should see "In good standing" within the status plate
    And I should see the "warning-sign" icon within the status plate
    And I should see the status help icon
    When I hover over the status help icon
    Then I should see a tooltip containing "You have 2 flags. If you receive any more, you will be banned from the system."

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

  Scenario: Nameplate updates when the 'member:saved' event is triggered
    Given my name is "Banana Hammock"
    When I am on the portal page
    Then I should see "Banana H." within the me plate
    When I change my first name in my profile to "Maulin"
    And the "member:saved" event is triggred
    Then I should see "Maulin H" within the me plate

  Scenario: Charity name updates in nameplate when member:saved event is triggered
    Given I am supporting the "World Vision International" charity
    When I am on the portal page
    Then I should see "World Vision International" within the me plate
    When I change my charity information to "Memberlandia Jet Ski Fund"
    And the "member:saved" event is triggred
    Then I should see "Memberlandia Jet Ski Fund" within the me plate
