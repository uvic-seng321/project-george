Feature: Camera feature opens and is able to capture and save an image
  Scenario: When app is opened camera is launched 
    Given "camera_page" is on screen 
    When I tap the "capture_button" an image is captured
    Then the image is saved locally to the device
