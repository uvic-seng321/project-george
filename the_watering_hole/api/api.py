import time
from flask import Flask, request, jsonify
from get_articles import *

app = Flask(__name__)

@app.route('/', methods=['GET'])
def home():
    return ""

@app.route('/getPosts', methods=['GET'])
def get_posts():
    return ""

@app.route('/uploadPost', methods=['POST'])
def upload_post():
    return ""

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
    app.run(host='0.0.0.0', port=5000)