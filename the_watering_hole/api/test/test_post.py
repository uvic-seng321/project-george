import io
from flask import Flask
import os
from PIL import Image
from test.test_helpers import upload_url, upload_form
from constants import *

class TestPost:

    def test_upload_post(self, client: Flask, test_image):
        '''Test that the uploadPost endpoint successfully uploads a post and returns 200'''

        # Create a post with simple data for testing.
        data = upload_form(test_image, tags = ["A", "B"])
        response = client.post(upload_url(), data=data, content_type='multipart/form-data', buffered=True)

        # Check that the post was uploaded successfully
        assert response.status_code == 200, "uploadPost should return 200 signifying its success"

        # Ensure the uploaded image is the same image as the one POSTed
        image_url = os.listdir(os.getenv("IMAGE_DIR"))[0]
        image = Image.open(os.getenv("IMAGE_DIR") + "/" + image_url)
        assert image == Image.open(io.BytesIO(test_image)), "The uploaded image in the file system should be the same as the test image POSTed"

    def test_invalid_location(self, client: Flask, test_image):
        '''Test that the getPosts endpoint returns an error when given an invalid location'''

        # Create a post with an invalid location
        data = upload_form(test_image, lat=91, long=181, tags = ["A", "B"])
        response = client.post(upload_url(), data=data, content_type='multipart/form-data', buffered=True)
        assert response.text == INVALID_LOCATION and response.status_code == 400, "uploadPost should return 400 when given an invalid location"