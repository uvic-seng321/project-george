Feature: Scrolling through the feed

    Scenario: Images show up
        Given I am on the home page
        When I press the "FeedViewButton" button
        Then I should see at least 1 image(s)

    Scenario: Scrolling down
        Given I am on the feed screen
        When I am focussed on the "Feed" component
        Then I should be able to scroll with offset -100 in the "Feed" component

    Scenario: Filtering by unused tag
        Given I am on the feed screen
        When I enter "test" into the search input
        Then I should see at least 1 image(s)