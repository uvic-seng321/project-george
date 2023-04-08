from flask import Flask
from test.test_helpers import get_url

from constants import NO_LOCATION_GIVEN, NO_RADIUS_GIVEN

class TestGetPosts:
    def test_no_page_num(self, client: Flask):
        '''Test that the getPosts endpoint returns all posts with a specified tag given no page number'''
        response = client.get("/posts/getPosts?tags=A")
        assert response.status_code == 200, "getPosts should be successful when given no page number"
        # Ensure the response contains posts
        assert len(response.json) > 0, "getPosts should return posts when given no page number"

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