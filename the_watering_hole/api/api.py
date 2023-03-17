from flask import Flask, request, jsonify
from flask_mysqldb import MySQL

from constants import *

app = Flask(__name__)
app.config.from_object('config.ProdConfig')

db = MySQL(app)

@app.route('/', methods=['GET'])
def home():
    return "Welcome to The Watering Hole's api!"

@app.route('/getPosts', methods=['GET'])
def get_posts():
    # TODO implement this
    return "", 400

# Syntax for uploadPost is:
# CALL `george`.`uploadPost`('URL', LONG (float), LAT (float), USER (int), 'TAGS:SEPARATED:BY:COLONS:ENDING:IN:ENDLIST');")
@app.route('/uploadPost', methods=['POST'])
def upload_post():
    # TODO implement this
    return "", 400

@app.route('/removePost', methods=['DELETE'])
def remove_post():
    return ""

@app.route('/viewPost', methods=['PATCH'])
def view_post():
    return ""

@app.route('/updatePost', methods=['PATCH'])
def update_post():
    return ""

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3434)