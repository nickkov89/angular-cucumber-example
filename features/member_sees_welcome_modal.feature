Feature: Member sees welcome modal
  As a member, I see a welcome modal that explains why I am here

  Background:
    Given I have the following attributes:
    """
    {
      "id":                               1,
      "first_name":                       "Steve",
      "last_name":                        "McQueen",
      "gender":                           "Male",
      "email":                            "steve@mcqueen.com",
      "date_of_birth":                    "March 24, 1930",
      "charity_id":                       2,
      "residence_city":                   "Brooklyn",
      "residence_state":                  "New York",
      "residence_zip_code":               "",
      "shipping_city":                    "New York",
      "shipping_state":                   "New York",
      "shipping_address1":                "101 rails ave.",
      "shipping_address2":                "Apt #5",
      "shipping_zip_code":                "10225",
      "shipping_phone":                   "212-867-5309",
      "hide_location":                    false,
      "has_linked_twitter":               false,
      "blog_url":                         "blog.example.com",
      "notify_of_new_actions_and_awards": true,
      "can_be_contacted_by_crowdtap":     true
    }
    """
    And the API returns the following charities:
      | id | name  | default |
      | 1  | Kevin | false   |
      | 2  | Bacon | false   |
      | 3  | Bits  | true    |

  Scenario: Member sees the welcome modal
    Given the API returns a successful response for PUT requests to "/api/v2/me"
    And I have not seen the welcome modal
    When I am on the portal page
    Then I should see the welcome modal
    And I should not see the confirm tracking pixel
    And the confirmation pane within the welcome modal should be active
    And I should see "Almost there! We just need you to confirm some of your information!" within the welcome modal
    And I should see the first name input with the value "Steve"
    And I should see the last name input with the value "McQueen"
    And I should see the gender input with the selected value "Male"
    And I should see the email input with the value "steve@mcqueen.com"
    And I should see the date of birth input with the value "March 24, 1930"
    And I enter "12345" in the residence zip code input within the welcome modal
    When I click "Confirm" within the welcome modal
    Then the confirmation pane within the welcome modal should not be active
    And I should see the confirm tracking pixel
    But the carousel pane within the welcome modal should be active
    And the welcome item within the carousel pane should be active
    And I should see "Thanks for joining Crowdtap" within the welcome modal
    And I should see the welcome modal header image within the carousel pane
    When I click "Continue" within the welcome item
    Then the welcome item within the carousel pane should not be active
    But the actions item within the carousel pane should be active
    And I should see "Inform Decisions" within the carousel pane
    And I should see the welcome modal header image within the carousel pane
    When I click "Continue" within the actions item
    Then the actions item within the carousel pane should not be active
    But the prizes item within the carousel pane should be active
    And I should see "Participating with brands will give you the opportunity to get cool perks" within the carousel pane
    And I should see the welcome modal header image within the carousel pane
    And I should see "Be recognized by brands and gain increased access to exclusive opportunities, samples and prizes." within the carousel pane
    And I should see "Plus everything you do on Crowdtap helps donate money to your selected charity" within the carousel pane
    And I should see the select your charity dropdown within the prizes item within the welcome modal
    And I should see the charity id input with the selected value "3"
    When I select "2" from the select your charity dropdown within the welcome modal
    And I click "Get Started!" within the prizes item
    Then the welcome modal should be hidden
    And I should have made a PUT request to "/api/v2/me" with:
      """
        {
          "first_name":                        "Steve",
          "last_name":                         "McQueen",
          "gender":                            "Male",
          "email":                             "steve@mcqueen.com",
          "residence_zip_code":                "12345",
          "date_of_birth":                     "March 24, 1930",
          "charity_id":                        2,
          "residence_city":                    "Brooklyn",
          "residence_state":                   "New York",
          "residence_zip_code":                "12345",
          "shipping_city":                     "New York",
          "shipping_state":                    "New York",
          "shipping_address1":                 "101 rails ave.",
          "shipping_address2":                 "Apt #5",
          "shipping_zip_code":                 "10225",
          "shipping_phone":                    "212-867-5309",
          "hide_location":                     false,
          "has_linked_twitter":                false,
          "blog_url":                          "blog.example.com",
          "notify_of_new_actions_and_awards":  true,
          "can_be_contacted_by_crowdtap":      true
        }
      """

  Scenario: Member confirms their information
    Given the API returns a successful response for PUT requests to "/api/v2/me"
    And I have not seen the welcome modal
    When I am on the portal page
    Then I should see the welcome modal
    And I should see the first name input with the value "Steve"
    When I enter "Steven" in the first name input within the welcome modal
    And I enter "steven.mcqueen@gmail.com" in the email input within the welcome modal
    And I enter "12345" in the residence zip code input within the welcome modal
    And I enter "12-11-1982" in the date of birth input within the welcome modal
    When I click "Confirm" within the welcome modal
    Then I should have made a PUT request to "/api/v2/me" with:
      """
        {
          "first_name":                        "Steven",
          "last_name":                         "McQueen",
          "gender":                            "Male",
          "email":                             "steven.mcqueen@gmail.com",
          "date_of_birth":                     "12-11-1982",
          "charity_id":                        2,
          "residence_city":                    "Brooklyn",
          "residence_state":                   "New York",
          "residence_zip_code":                "12345",
          "shipping_city":                     "New York",
          "shipping_state":                    "New York",
          "shipping_address1":                 "101 rails ave.",
          "shipping_address2":                 "Apt #5",
          "shipping_zip_code":                 "10225",
          "shipping_phone":                    "212-867-5309",
          "hide_location":                     false,
          "has_linked_twitter":                false,
          "blog_url":                          "blog.example.com",
          "notify_of_new_actions_and_awards":  true,
          "can_be_contacted_by_crowdtap":      true
        }
      """
    And the confirmation pane within the welcome modal should not be active
    But the carousel pane within the welcome modal should be active

  Scenario: Member sees errors when confirming their information with local validation
    Given the API returns a successful response for PUT requests to "/api/v2/me"
    And I have not seen the welcome modal
    When I am on the portal page
    And I enter "steven.mcqueen@gmail" in the email input within the welcome modal
    And I enter "March 24, 2030" in the date of birth input within the welcome modal
    And I click "Confirm" within the confirmation pane within the welcome modal
    Then the confirmation pane within the welcome modal should be active
    And the carousel pane within the welcome modal should not be active
    And I should see "ZipCode is Required" within the residence_zip_code control group error within the welcome modal
    And I should see "You must be at least 13 years old" within the date of birth control group error within the welcome modal
    And I should see "Please enter a valid email (handle@domain.net)" within the email control group error within the welcome modal
    When I enter "steven.mcqueen@example.com" in the email input within the welcome modal
    And I click "Confirm" within the confirmation pane within the welcome modal
    Then I should see "ZipCode is Required" within the residence_zip_code control group error within the welcome modal
    But I should not see "Please enter a valid email (handle@domain.net)" within the email control group error within the welcome modal
    When I enter "12345" in the residence zip code input within the welcome modal
    And I enter "March 24, 1930" in the date of birth input within the welcome modal
    And I click "Confirm" within the confirmation pane within the welcome modal
    Then the confirmation pane within the welcome modal should not be active
    And the carousel pane within the welcome modal should be active

  Scenario: Member sees errors when confirming their information with local validation
    Given the API returns a 406 for PUT requests to "/api/v2/me" with:
      """
        {
          "first_name":                        "Steven",
          "last_name":                         "McQueen",
          "gender":                            "Male",
          "email":                             "bad@email",
          "residence_zip_code":                "01010",
          "date_of_birth":                     "12-11-1982",
          "errors":{
           "email": "Please enter a valid email"
          }
        }
      """
    Given the API returns a successful response for PUT requests to "/api/v2/me"
    And I have not seen the welcome modal
    When I am on the portal page
    And I enter "12345" in the residence zip code input within the welcome modal
    # Even though the form is correct, the API is stubbed to return errors
    And I click "Confirm" within the confirmation pane within the welcome modal
    Then I should see "Please enter a valid email" within the email control group error within the welcome modal
    When I enter "good@example.com" in the email input within the welcome modal
    And I click "Confirm" within the confirmation pane within the welcome modal
    Then the confirmation pane within the welcome modal should not be active
    And the carousel pane within the welcome modal should be active
