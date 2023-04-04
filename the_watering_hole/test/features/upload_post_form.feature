@uploadPostForm
Feature: [Post] Entering data into the "upload post" form and submitting it

    Scenario: Upload image in post form
        Given the user is on the upload page
        When the user presses the "addImage" button and selects an image with URL "test_images/sheep.png"
        Then the user is able to upload an image which is "stored in local memory"

    Scenario: Input location in post form
        Given the user has entered all other required fields
        When the user has entered nothing in the "latitudeInput" and "longitudeInput" fields
        Then the user is not able to press the "uploadPost" button

    Scenario: Input location with invalid input
        Given the user presses the "upload post" button
        When latitude <latitude> and longitude <longitude> are inputted in the "latitudeInput" and "longitudeInput" fields
        Then an error message of "Invalid location" is displayed in the "errorBox"
        | latitude | longitude |
        | 91 | 181 |
        | -91 | -181 |

    Scenario: Upload post given tags
        Given the user is creating a post on the upload page and all required fields are filled
        When tag(s) <tag> are submitted to the "tagInput" field
        Then the widget "errorBox" does not exist and the post is uploaded with status code 200
        Examples:
            | tag |
            | |
            | sheep |
            | sheep, big sheep |
            | sheep, fluffy sheep, cartoon sheep |

    Scenario: Upload post to the backend no image
        Given the user is creating a post on the upload page
        When the user fills in all required fields but enters no image
        Then clicking "uploadPost" flashes an error in the "errorBox" widget of "Image not found"