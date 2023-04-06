from flask import Flask
import pytest
import os

from api.app import create_app

@pytest.fixture()
def app():
    app = create_app(testing=True)
    yield app

@pytest.fixture()
def client(app : Flask):
    yield app.test_client()

@pytest.fixture(scope="session")
def temp_dir(tmp_path_factory):
    dir = str(tmp_path_factory.mktemp("image_files"))
    # Set the image directory to a temp dir, used in the uploadPost endpoint
    os.environ["IMAGE_DIR"] = dir
    return dir

@pytest.fixture()
def test_image():
    '''Read peacock.png from test_images'''
    with open('test/test_images/peacock.png', 'rb') as f:
        image = f.read()
    yield image