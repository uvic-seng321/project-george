from flask import Flask
import pytest
import api
import os

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