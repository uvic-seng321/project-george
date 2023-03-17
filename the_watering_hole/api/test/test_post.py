from flask import Flask
import pytest

from constants import *

@pytest.fixture()
def test_image():
    '''Read peacock.png from test_images'''
    with open('test/test_images/peacock.png', 'rb') as f:
        image = f.read()
    yield image

def default_upload_json():
    return {'latitude': -1, 'longitude': -1, 'user': 1, 'tags': ["A", "B"]}

def test_upload_post(client: Flask, test_image):
    '''Test that the uploadPost endpoint successfully uploads a post and returns 200'''

    # Create a post with simple data for testing.
    request_json = {'latitude': -1, 'longitude': -1, 'user': 1, 'tags': ["A", "B"]}
    response = client.post('/uploadPost', data = dict(image = test_image, json = request_json))

    # Check that the post was uploaded successfully
    assert response.status_code == 200

def test_invalid_location(client: Flask, test_image):
    '''Test that the getPosts endpoint returns an error when given an invalid location'''
    # Create a post with an invalid location
    failing_json = default_upload_json()
    failing_json['latitude'] = 91
    failing_json['longitude'] = 181
    response = client.post('/uploadPost', data = dict(image = test_image, json = failing_json))
    assert response.text == INVALID_LOCATION and response.status_code == 400

def test_no_radius(client: Flask):
    '''Test that the getPosts endpoint returns an error when given a location but no radius'''
    response = client.post()
    assert response.text == NO_RADIUS_GIVEN and response.status_code == 400