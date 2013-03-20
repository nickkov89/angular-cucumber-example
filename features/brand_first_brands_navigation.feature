Feature: Member can navigate to Brands from top menu
  As a brand first member, I see the brands list in the menu and can navigate

  Scenario: Member sees a proper Brand menu list
   Given the brand menu API request returns the following:
     | id    | slug   | name   | logo                  | action_count |
     | 12345 | digits | Digits | http://digit/logo.png | 25           |
     | 1a    | alpha  | Alpha  | http://alpha/logo.png | 25           |
     | 2b    | beta   | Beta   | http://beta/logo.png  | 50           |
   When I am on the portal page
   Then I should see "Digits" within the brand menu item for brand "12345"
   And I should see "25 new" within the brand menu item for brand "12345"
   And I should see the "http://digit/logo.png" image within the brand menu item for brand "12345"
   And I should see "Digits" linking to "/digits" within the brand menu item for brand "12345"
   And I should see "Alpha" within the brand menu item for brand "1a"
   And I should see "25 new" within the brand menu item for brand "1a"
   And I should see the "http://alpha/logo.png" image within the brand menu item for brand "1a"
   And I should see "Alpha" linking to "/alpha" within the brand menu item for brand "1a"
   And I should see "Beta" within the brand menu item for brand "2b"
   And I should see "50 new" within the brand menu item for brand "2b"
   And I should see the "http://beta/logo.png" image within the brand menu item for brand "2b"
   And I should see "Beta" linking to "/beta" within the brand menu item for brand "2b"

  Scenario: Member sees total brand action count badge
   Given the brand menu API request returns the following:
     | id    | slug   | name   | logo                  | action_count |
     | 12345 | digits | Digits | http://digit/logo.png | 25           |
     | 1a    | alpha  | Alpha  | http://alpha/logo.png | 25           |
     | 2b    | beta   | Beta   | http://beta/logo.png  | 50           |
   When I am on the portal page
   Then I should see "100" within the brand menu
