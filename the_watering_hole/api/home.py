from flask import Blueprint

home_api = Blueprint('home_api', __name__)

@home_api.route('/', methods=['GET'])
def home():
    return "Welcome to The Watering Hole's api!"
