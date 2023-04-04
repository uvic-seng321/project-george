Feature: Upload post
    @uploadPost
    Scenario: Post sends successfully when the required info is filled out
        Given I am on the "UploadPost" page
        When a post with tag(s) <tag> are entered into "tagInput"
         And latitude <latitude> is entered into "latitudeInput"
         And longitude <longitude> is entered into "longitudeInput"
         And image from url <url> is added from the "addImage" button
         And I press the "uploadPost" button 
        Then I should see "Post uploaded successfully"
        Examples:
          | tag                          | latitude | longitude | url                    |
          |                              |          |           | test_images/sheep.png  |
          | cool sheep, cute sheep       |          |           | test_images/sheep.png  |
          | sheep                        | 52.0     | 13.0      | test_images/sheep.png  |
          | sheep, big sheep, cute sheep | 0.0      | 0.0       | test_images/sheep2.png |

