import io
from flask import Flask
import pytest
import os
from PIL import Image

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

def test_upload_post(client: Flask, test_image, temp_dir):
    '''Test that the uploadPost endpoint successfully uploads a post and returns 200'''

    # Create a post with simple data for testing.
    url = upload_url(lat=1, long=1, radius=1, tags = ["A", "B"])
    response = client.post(url, data=test_image)

    # Check that the post was uploaded successfully
    assert response.status_code == 200, "uploadPost should return 200 signifying its success"

    assert len(os.listdir(temp_dir)) == 1, "There should only be one file uploaded"

    # Ensure the uploaded image is the same image as the one POSTed
    image_url = os.listdir(temp_dir)[0]
    image = Image.open(temp_dir + "/" + image_url)
    assert image == Image.open(io.BytesIO(test_image)), "The uploaded image in the file system should be the same as the test image POSTed"

def test_invalid_location(client: Flask, test_image):
    '''Test that the getPosts endpoint returns an error when given an invalid location'''
    # Create a post with an invalid location
    url = upload_url(lat=91, long=181, radius=1, tags = ["A", "B"])
    response = client.post(url, data=test_image)
    assert response.text == INVALID_LOCATION and response.status_code == 400, "uploadPost should return 400 when given an invalid location"

def test_no_radius(client: Flask, test_image):
    '''Test that the getPosts endpoint returns an error when given a location but no radius'''
    url = upload_url(lat=1, long=1, tags = ["A", "B"])
    response = client.post(url, data=test_image)
    assert response.text == NO_RADIUS_GIVEN and response.status_code == 400, "uploadPost should return 400 when given a location but no radius"