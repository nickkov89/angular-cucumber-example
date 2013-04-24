Feature: Member sees various zero states
  As a member, depending on what actions are available to me
  I see appropriate zero states on the portal page

  Scenario: New member sees intro zero state
    Given the brands API request returns the following:
      | id    | name       | slug       | logo      | header_image_url | actions_count | crowd_participant |
      | 12345 | Dairy King | dairy-king | foo-1.jpg | bar-1.jpg        | 0             | false             |
      | 12346 | Tres Toros | tres-toros | foo-2.jpg | bar-2.jpg        | 0             | false             |
    And I am on the portal page and have seen the welcome modal
    Then I should see the my brands zero state within the My Brands section
    Then I should not see the no actions zero state

  Scenario: Member sees my brands zero actions state
    Given the brands API request returns the following:
      | id    | name       | slug       | logo      | header_image_url | actions_count | crowd_participant |
      | 12345 | Dairy King | dairy-king | foo-1.jpg | bar-1.jpg        | 0             | true              |
      | 12346 | Tres Toros | tres-toros | foo-2.jpg | bar-2.jpg        | 1             | false             |
    And I am on the portal page and have seen the welcome modal
    Then I should see the my brands zero actions state within the My Brands section
    And I should not see the "dairy-king" brand box within the My Brands section
    But I should see the "tres-toros" brand box within the New Brands section

  Scenario: Member sees new brands zero state
    Given the brands API request returns the following:
      | id    | name       | slug       | logo      | header_image_url | actions_count | crowd_participant |
      | 12345 | Dairy King | dairy-king | foo-1.jpg | bar-1.jpg        | 1             | true              |
      | 12346 | Tres Toros | tres-toros | foo-2.jpg | bar-2.jpg        | 0             | true              |
    And I am on the portal page and have seen the welcome modal
    Then I should see the new brands zero state within the New Brands section
    And I should not see the "tres-toros" brand box within the My Brands section
    But I should see the "dairy-king" brand box within the My Brands section

  Scenario: Member sees zero state when brands exist with no actions available
    Given the brands API request returns the following:
      | id    | name       | slug       | logo      | header_image_url | actions_count | crowd_participant |
      | 12345 | Dairy King | dairy-king | foo-1.jpg | bar-1.jpg        | 0             | true              |
      | 12346 | Tres Toros | tres-toros | foo-2.jpg | bar-2.jpg        | 0             | false             |
    And I am on the portal page and have seen the welcome modal
    Then I should see the no actions zero state
    And I should see the "dairy-king" brand box within the My Brands section
    And I should see the "tres-toros" brand box within the New Brands section
    And the hide brands with no actions checkbox should not be checked
    And the hide brands with no actions checkbox should be disabled
