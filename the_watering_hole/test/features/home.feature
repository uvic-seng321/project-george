Feature: Home Page
    @home
    Scenario: Entering the home page
        Given I am on the home page
        When I look at the screen
        Then I should see a camera preview