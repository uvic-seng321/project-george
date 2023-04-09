Feature: Uploading a post

    Scenario: Uploading a picture
        Given I am on the camera page
        When I press the "UploadImage" button
        Then the screen for uploading images should pop up

    Scenario: Entering location
        Given I am on the upload page
        When I enter <Longitude> in the "LongitudeInput" field
        When I enter <Latitude> in the "LatitudeInput" field
        Then the "LongitudeInput" field should contain <Longitude> 
        Then the "LatitudeInput" field should contain <Latitude>
        Examples:
            | Longitude | Latitude |
            | 0         | 0        |
            | 1         | 1        |
    
    Scenario: Entering tags
        Given I am on the upload page
        When I enter <Tag> in the "TagInput" field
        Then the "TagInput" field should contain <Tag>
        Examples:
            | Tag |
            | a   |
            | b   |