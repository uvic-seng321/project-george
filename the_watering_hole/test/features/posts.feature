@posts
Feature: [Post] Uploading and receiving posts from the backend

    Scenario: Uploading a post to the backend
        Given a post is being uploaded to the backend
        When a post with tag(s) <tag>, latitude <latitude>, longitude <longitude> and image url <url> is created
        | tag | latitude | longitude | url |
        ||||test_images/sheep.png|
        | cool sheep, cute sheep |||test_images/sheep.png|
        | sheep | 52.0 | 13.0 | test_images/sheep.png |
        | sheep, big sheep, cute sheep | 0.0 | 0.0 | test_images/sheep2.png |
        Then the post is uploaded to the backend with code 200

    Scenario: Uploading a post to the backend with an incorrect latitude
        Given a post is being uploaded to the backend
        When a post with latitude -181 and longitude -91 is created
        Then an exception is thrown with the message "A parameter has been inputted incorrectly."

    Scenario: Getting posts from the backend
        Given posts are requested from the backend
        When no filters are applied
        Then a non-zero number of posts are returned

    Scenario: Getting posts from the backend by filtering to a tag
        Given posts are requested from the backend
        When filtering to tag "sheep"
        Then all posts returned have tag "sheep"

    Scenario: Getting posts from the backend by filtering to a location
        Given posts are requested from the backend
        When filtering to location 52.0, 13.0 with a radius 1000
        Then a non-zero number of posts are returned

    Scenario: Getting posts from the backend by filtering to a location without a radius
        Given posts are requested from the backend
        When filtering to location 52.0, 13.0 without a radius
        Then an exception is thrown with the message "A parameter has been inputted incorrectly."