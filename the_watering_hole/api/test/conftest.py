from flask import Flask
import pytest
import api
import os

api.app.config.from_object('config.DevConfig')
api.db.init_app(api.app)

@pytest.fixture()
def db():
    yield api.db

@pytest.fixture()
def app():
    yield api.app

@pytest.fixture()
def client(app : Flask):
    return app.test_client()

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