# TODO database stuff from https://tedboy.github.io/flask/flask_doc.testing.html
import pytest
from api import app
import unittest

def test_home():
    cnt = app.get('/')
    assert cnt == "Welcome to The Watering Hole's api!"

def test_empty_posts():
    cnt = app.get('/getPosts')
    assert cnt == ""

# class TestPost(unittest.TestCase):
#     def test_empty_posts(self):
#         cnt = self.get('/getPosts').data
#         assert cnt == ""

#     @pytest.fixture()
#     def app():
#         app = api.app
#         app.config.update({
#             "TESTING": True,
#         })

#         # other setup can go here

#         yield app

#         # clean up / reset resources here

# if __name__ == '__main__':
#     unittest.main()