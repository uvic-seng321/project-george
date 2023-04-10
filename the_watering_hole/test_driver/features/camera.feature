Feature: Camera Page

    Scenario: On the camera page
        Given I am on the camera page
        When I look at the screen
        Then I should see a "CameraPreview" component

    Scenario: Taking a picture
        Given I am on the camera page
        When the component "CameraPreview" is shown 
        Then I should be able to click the "TakePicture" button
