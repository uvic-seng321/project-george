import io
from flask import Flask
import os
from PIL import Image
from test.test_helpers import upload_url, reset_db
from constants import *

class TestPost:

    def test_upload_post(self, client: Flask, test_image, temp_dir):
        '''Test that the uploadPost endpoint successfully uploads a post and returns 200'''

        # Create a post with simple data for testing.
        url = upload_url(tags = ["A", "B"])
        response = client.post(url, data=test_image)

        # Check that the post was uploaded successfully
        assert response.status_code == 200, "uploadPost should return 200 signifying its success"

        assert len(os.listdir(temp_dir)) == 1, "There should only be one file uploaded"

        # Ensure the uploaded image is the same image as the one POSTed
        image_url = os.listdir(temp_dir)[0]
        image = Image.open(temp_dir + "/" + image_url)
        assert image == Image.open(io.BytesIO(test_image)), "The uploaded image in the file system should be the same as the test image POSTed"

    def test_invalid_location(self, client: Flask, test_image):
        '''Test that the getPosts endpoint returns an error when given an invalid location'''

        # Create a post with an invalid location
        url = upload_url(lat=91, long=181, tags = ["A", "B"])
        response = client.post(url, data=test_image)
        assert response.text == INVALID_LOCATION and response.status_code == 400, "uploadPost should return 400 when given an invalid location"