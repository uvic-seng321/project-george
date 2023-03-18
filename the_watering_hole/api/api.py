import io
import os
import uuid

from constants import *
from flask import Flask, jsonify, request
from flask_mysqldb import MySQL
from PIL import Image

app = Flask(__name__)
db = MySQL(app)
app.config.from_object('config.ProdConfig')

@app.route('/', methods=['GET'])
def home():
    return "Welcome to The Watering Hole's api!"

@app.route('/getPosts', methods=['GET'])
def get_posts():
    # TODO implement this
    return "", 400

@app.route('/uploadPost', methods=['POST'])
def upload_post():
    '''
    Upload a post to the database

    Syntax for uploadPost is:

    CALL `database_name`.`uploadPost`('URL', LONG (float), LAT (float), USER (int), 'TAGS:SEPARATED:BY:COLONS:ENDING:IN:ENDLIST');")
    '''
    # Grab the arguments provided in the request
    tags = request.args.getlist('tags')
    user = request.args.get('user')
    latitude = request.args.get('latitude', None)
    longitude = request.args.get('longitude', None)
    radius = request.args.get('radius', None)

    # Ensure the latitude, longitude, and radius are specified correctly
    if latitude is not None and longitude is not None:
        if (float(latitude) < -90 or
            float(latitude) > 90 or
            float(longitude) < -180 or
                float(longitude) > 180):
            return INVALID_LOCATION, 400
        if radius is None:
            return NO_RADIUS_GIVEN, 400
        
    # Upload image to the storage folder
    image = Image.open(io.BytesIO(request.data))
    image_path = str(uuid.uuid4()) + ".png"
    # TODO use a constant or environment variable for the storage folder
    image.save(fp = os.environ["IMAGE_DIR"] + "/" + image_path, format = "png")
    # Send the post to the database using the uploadPost stored procedure
    tags = ":".join(tags) + ":ENDLIST"
    cur = db.connection.cursor()
    db_name = app.config.get("MYSQL_DB")
    # TODO use db_name
    cmd = f"CALL `george`.`uploadPost`('{image_path}', {longitude}, {latitude}, {user}, '{tags}');"
    cur.execute(cmd)
    cur.close()
    return "", 200


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