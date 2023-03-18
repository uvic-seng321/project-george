import io
import os
import uuid

from constants import *
from flask import Flask, request
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
    return "Unimplemented", 400

@app.route('/uploadPost', methods=['POST'])
def upload_post():
    '''Upload a post to the database and store the image in the file system'''
    # Grab the arguments provided in the request
    tags = request.args.getlist('tags')
    user = request.args.get('user')
    latitude = request.args.get('latitude')
    longitude = request.args.get('longitude')

    # Ensure the latitude and longitude are specified correctly
    if (float(latitude) < -90 or
        float(latitude) > 90 or
        float(longitude) < -180 or
            float(longitude) > 180):
        return INVALID_LOCATION, 400
        
    # Upload image to the storage folder
    image = Image.open(io.BytesIO(request.data))
    image_path = str(uuid.uuid4()) + ".png"
    image.save(fp = os.environ["IMAGE_DIR"] + "/" + image_path, format = "png")

    # Send the post to the database using the uploadPost stored procedure
    tags = ":".join(tags) + ":ENDLIST"
    cmd_params = (image_path, latitude, longitude, user, tags)
    cur = db.connection.cursor()
    cur.callproc("uploadPost", cmd_params)
    cur.fetchall()
    cur.close()
    db.connection.commit()
    return "", 200

@app.route('/removePost', methods=['DELETE'])
def remove_post():
    return "Unimplemented", 400

@app.route('/viewPost', methods=['PATCH'])
def view_post():
    return "Unimplemented", 400

@app.route('/updatePost', methods=['PATCH'])
def update_post():
    return "Unimplemented", 400

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=3434)