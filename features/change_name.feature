Feature: change name

  Scenario: change name
    Given I am on the homepage
    Then I should see my name as "DK"
    When I change my name to "Dan"
    Then I should see my name as "Dan"
