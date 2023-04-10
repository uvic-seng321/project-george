Feature: Uploading a post

    Scenario: Uploading a picture
        Given I am on the camera page
        When I press the "UploadImage" button
        Then the screen for uploading images should pop up

    Scenario: Entering location
        Given I am on the upload page
        When I enter "1" in the "LongitudeInput" field
        When I enter "0" in the "LatitudeInput" field
        Then the "LongitudeInput" field should contain "1"
        Then the "LatitudeInput" field should contain "0"
    
    Scenario: Entering tags
        Given I am on the upload page
        When I enter "a" in the "TagInput" field
        Then the "TagInput" field should contain "a"