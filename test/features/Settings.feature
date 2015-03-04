Feature: Settings

Scenario: Accessing while not logged in
  Given I am on the settings page
  Then I should be on the landing page
  And I should see "Hey! You should create an account to do that."

@javascript
Scenario: Accessing from dropdown
  Given I am on the landing page
  And I follow "Connect to Get Started" within ".landing-connect"
  When I authorize with Trello
  Then I should not see "Connecting..."
  And I should not see "Redirecting..."
  And I should be on the boards page
  When I click my avatar
  And I follow "Settings"
  Then I should be on the settings page

@javascript @test_user
Scenario: Updating email
  When the test user is logged in
  And I go to the settings page
  And the email field contains the test email address
  When I fill in "email" with "ollertapp@gmail.co.uk"
  And I press "Update Email"
  Then I should see "Your new email is ollertapp@gmail.co.uk. Use this to log in."
  And the test user "email" should be "ollertapp@gmail.co.uk"

@javascript
Scenario: Connecting to a different Trello account
  Given I am on the landing page
  And I follow "Connect to Get Started" within ".landing-connect"
  When I authorize with Trello
  Then I should not see "Connecting..."
  And I should not see "Redirecting..."
  And I should be on the boards page
  When I go to the settings page
  Then I am able to connect to an alternative Trello account

@javascript
Scenario: Connecting to Trello with previously-used Trello account
  Given I am on the landing page
  And I follow "Connect to Get Started" within ".landing-connect"
  When I authorize with Trello
  Then I should not see "Connecting..."
  And I should not see "Redirecting..."
  And I should be on the boards page
  Given I go to the settings page
  And there is a copycat user in the system
  When I follow "Connect to a Different Trello Account"
  And I authorize with Trello
  Then I should see "User already exists using that account. Log out to connect with that account."

@javascript @test_user
Scenario: Deny connecting to Trello
  When the test user is logged in
  And I go to the settings page
  When I follow "Connect to a Different Trello Account"
  And I press "Deny" on the Trello popup
  Then I should see "Connect to a Different Trello Account"

@javascript @test_user
Scenario: Delete account
  When the test user is logged in
  And I go to the settings page
  When I check "This box verifies that you would like to delete your account when clicking the link below."
  And I press "Delete Account"
  Then I should not see "Account deleted. Redirecting..."
  And I should see "Connect to Get Started"
  And I should be on the landing page
  And there should be 0 users in the system

@javascript @test_user
Scenario: Delete account without checking box
  When the test user is logged in
  And I go to the settings page
  When I press "Delete Account"
  Then I should see "Delete failed: Check the 'I am sure' checkbox to confirm deletion."
