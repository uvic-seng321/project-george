from flask import Flask
import pytest

from constants import *

@pytest.fixture()
def test_image():
    '''Read peacock.png from test_images'''
    with open('test/test_images/peacock.png', 'rb') as f:
        image = f.read()
    yield image

def upload_url(user : int = 1, 
               lat : float = None, 
               long : float = None, 
               radius : float = None, 
               tags = []):
    '''Create a url for the uploadPost endpoint'''

    req = "/uploadPost?"
    req += "user=" + str(user) 
    if lat is not None:
        req += "&latitude=" + str(lat)
    if long is not None:
        req += "&longitude=" + str(long)
    if radius is not None:
        req += "&radius=" + str(radius)
    req += "".join(["&tags=" + tag for tag in tags])
    return req

def test_upload_post(client: Flask, test_image):
    '''Test that the uploadPost endpoint successfully uploads a post and returns 200'''

    # Create a post with simple data for testing.
    url = upload_url(lat=91, long=181, tags = ["A", "B"])
    response = client.post(url, data = test_image)

    # Check that the post was uploaded successfully
    assert response.status_code == 200

def test_invalid_location(client: Flask, test_image):
    '''Test that the getPosts endpoint returns an error when given an invalid location'''
    # Create a post with an invalid location
    url = upload_url(lat=91, long=181, tags = ["A", "B"])
    response = client.post(url, data = test_image)
    assert response.text == INVALID_LOCATION and response.status_code == 400

def test_no_radius(client: Flask):
    '''Test that the getPosts endpoint returns an error when given a location but no radius'''
    response = client.post()
    assert response.text == NO_RADIUS_GIVEN and response.status_code == 400