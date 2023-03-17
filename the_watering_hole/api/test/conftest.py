from flask import Flask
import testing.mysqld
import pytest
from api import app as flask_app

@pytest.fixture()
def app():
    flask_app.testing = True
    flask_app.config.from_object('config.DevConfig')
    yield flask_app

@pytest.fixture()
def client(app : Flask):
    return app.test_client()

@pytest.fixture()
def db():
    # TODO yield database
    return

@pytest.fixture()
def runner(app : Flask):
    return app.test_cli_runner()

# TODO database