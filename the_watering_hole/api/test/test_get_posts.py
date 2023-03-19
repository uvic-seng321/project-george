import io
from flask import Flask
import pytest
from PIL import Image
from test.test_helpers import reset_db, upload_url, get_url

from constants import NO_LOCATION_GIVEN, NO_RADIUS_GIVEN

@pytest.fixture(scope="class")
def setup_db(client: Flask, test_image):
    '''Create three posts for testing'''

    # Create three posts for testing
    tag_array = [["A", "B"], ["A", "C"], ["B", "C"]]
    for tags in tag_array:
        url = upload_url(tags = tags)
        client.post(url, data=test_image)
    yield
    reset_db()

class TestGetPosts:
    def test_empty_get(self, client: Flask):
        '''Test that the getPosts endpoint returns all posts when given no parameters'''
        response = client.get("/getPosts")
        assert response.status_code == 200, "getPosts should be successful given no parameters"
        
        # Ensure the response contains every post (three posts are created prior to this)
        assert len(response) == 3, "getPosts should return all posts when given no parameters"

    def test_no_location(self, client: Flask):
        '''Test that the getPosts endpoint returns an error when given no location and a radius'''
        response = client.get(get_url(radius = 1))
        assert response.text == NO_LOCATION_GIVEN and response.status_code == 400, "getPosts should return an error when given no location and a radius"

    def test_no_radius(self, client: Flask):
        '''Test that the getPosts endpoint returns an error when given no radius and a location'''
        response = client.get(get_url(long = 1, lat = 1))
        assert response.text == NO_RADIUS_GIVEN and response.status_code == 400, "getPosts should return an error when given no radius and a location"

    def test_get_posts(self, client: Flask):
        '''Test that the getPosts endpoint successfully returns posts and returns 200'''

        # Get all posts with the tag "A"
        url = get_url(tags = ["A"])
        response = client.get(url)

        # Check that the post was uploaded successfully
        assert response.status_code == 200, "getPosts should return 200 when given only a tag"

        # Check that the post we just created is in the response
        assert (response.json.length == 2 and 
                "A" in response.json[0]["tags"] and
                "A" in response.json[1]["tags"]), "getPosts should return the posts with tags expected"

    def test_post_image_exist(self, client: Flask, test_image, temp_dir):
        '''Test that the getPosts endpoint successfully returns the url of an image that exists'''

        url = get_url(tags = ["A", "B"])
        response = client.get(url)

        # Check that the post was uploaded successfully
        assert response.status_code == 200, "getPosts should return 200 when given only a tag"

        # Check that the image url is valid in the response
        image_path = temp_dir + "/" + response.json[0]["image"]
        assert Image.open(image_path) == Image.open(io.BytesIO(test_image)), "getPosts should return an image url that exists and is the same as the image expected"
