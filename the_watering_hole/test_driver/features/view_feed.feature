Feature: Scrolling through the feed

    Scenario: Images show up
        Given I open the app
        When I press the "FeedView" button
        Then I should see at least 1 image

    Scenario: Scrolling down
        Given I am on the feed screen
        When I scroll down in the "Feed" component
        Then I should be able to scroll with offset -100 in the "Feed" component

    Scenario: Filtering by unused tag
        Given I am on the feed screen
        When I enter <tag> into the "SearchInput" input
        Then I should see <amount> image(s)
        Examples:
        | tag | amount |
        | unused_tag | 0 |
        | b | 1 |