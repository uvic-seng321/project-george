import io
from flask import Flask
import os
from PIL import Image
from test.test_helpers import upload_url, get_url
from constants import *

class TestPostIntegration:
    '''Test the integration of the API's endpoints'''

    def test_new_tag(self, client : Flask, test_image):
        '''Test a post with a new tag is created when a post is uploaded with the new tag'''

        # Create a post with a new tag
        url = upload_url(tags = ["Unique Tag", "A", "B"])
        response = client.post(url, data=test_image)

        # Check that the post was uploaded successfully
        assert response.status_code == 200, "uploadPost should be successful"

        # Check that the post with a new tag is accessible via getPosts
        url = get_url(tags = ["Unique Tag"])
        response = client.get(url)

        assert response.status_code == 200, "getPosts should be successful"
        assert "Unique Tag" in response.json[0]["tags"], "getPosts should return the post with the new tag"

    def test_correct_image(self, client : Flask, test_image):
        '''Test that the getPosts endpoint successfully returns the url of the image uploaded by the uploadPost endpoint'''

        url = upload_url(tags = ["Image Test"])
        response = client.post(url, data=test_image)

        # Check that the post was uploaded successfully
        assert response.status_code == 200, "getPosts should be successful"

        # Check that the image returned by getPosts is the same as the image uploaded
        url = get_url(tags = ["Image Test"])
        response = client.get(url)
        image_path = os.environ["IMAGE_DIR"] + "/" + response.json[0]["url"]
        assert Image.open(image_path) == Image.open(io.BytesIO(test_image)), "getPosts should return an image url that exists and is the same as the image expected"

    def test_by_location(self, client : Flask, test_image):
        '''Test that the getPosts endpoint successfully returns all posts uploaded given a large radius'''

        # Upload two posts with locations far from eachother
        first_loc = upload_url(lat=-89, long=-179, tags = ["Location Test 1"])
        second_loc = upload_url(lat=89, long=179, tags = ["Location Test 2"])

        first_response = client.post(first_loc, data=test_image)
        second_response = client.post(second_loc, data=test_image)

        # Check that the posts were uploaded successfully
        assert first_response.status_code == 200 and second_response.status_code == 200, "both locations uploaded should be successful"

        # Check that both posts are returned when given a large radius
        url = get_url(lat=0, long=0, radius=1000000)
        response = client.get(url)

        assert response.status_code == 200, "getPosts should be successful"

        # Check if the tags of the posts are anywhere in the response
        loc_1_exists = False
        loc_2_exists = False
        for post in response.json:
            if post["latitude"] == -89 and post["longitude"] == -179:
                loc_1_exists = True
            if post["latitude"] == 89 and post["longitude"] == 179:
                loc_2_exists = True

        assert loc_1_exists and loc_2_exists, "Both locations should be returned when given a large radius"