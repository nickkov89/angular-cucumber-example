Feature: change name

  Scenario: change name
    Given the brands API request returns the following:
      | name        | slug        | logo      | header_image_url | actions_count | crowd_participant |
      | Steak Shack | steak-shack | foo-1.jpg | bar-1.jpg        | 15            | true              |
      | McRonalds   | mcronalds   | foo-2.jpg | bar-2.jpg        | 10            | false             |
    And I am logged in as:
      | first_name | last_name | email           |
      | nick       | kov       | nickk@asada.com |
    When I am on the homepage
    And I click the input box "hide-empty-brands"
    Then I should see "Steak Shack" brands
