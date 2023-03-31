
@post
Feature: [Post] Uploading and receiving posts

    Scenario: Upload image in post form
        Given the user presses the "add image" button and selects an image with URL "test_images/sheep.png"
        When the user is on the upload page
        Then the user is able to upload an image which is "stored in local memory"

    Scenario: Input location in post form
        Given the user has entered nothing in the "latitudeInput" and "longitudeInput" fields
        When the user has entered all other required fields
        Then the user is not able to press the "uploadPost" button

    Scenario: Input location with invalid input
        Given latitude <latitude> and longitude <longitude> are inputted in the "latitudeInput" and "longitudeInput" fields
        When the user presses the "upload post" button
        Then an error message of "Invalid location" is displayed in the "errorBox"
        | latitude | longitude |
        | 91 | 181 |
        | -91 | -181 |

    Scenario: Upload post given tags
        Given tag(s) <tag> are submitted to the "tagInput" field
        When the user is creating a post on the upload page and all required fields are filled
        Then the widget "errorBox" does not exist and the post is uploaded with status code 200
        Examples:
            | tag |
            | |
            | sheep |
            | sheep, big sheep |
            | sheep, fluffy sheep, cartoon sheep |

    Scenario: Upload post to the backend with a non-existant URL
        Given the user clicks the "addImage" button and uses the image at URL "test_images/non_existant_sheep.png"
        When the user is creating a post on the upload page
        Then clicking "uploadPost" flashes an error in the "errorBox" widget of "Image not found"