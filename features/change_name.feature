Feature: change name

  Scenario: change name
    When I change my name to "Dan"
    Then I should see my name as "Dan"
