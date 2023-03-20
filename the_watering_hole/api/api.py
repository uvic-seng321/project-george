import io
import os
import uuid

from constants import *
from flask import Flask, jsonify, request
from flask_mysqldb import MySQL
from PIL import Image

app = Flask(__name__)

db = MySQL()

@app.route('/', methods=['GET'])
def home():
    return "Welcome to The Watering Hole's api!"

def str_tags(tags : list):
    '''Convert a list of tags to the string expected by the database'''
    tags = ":".join(tags)
    # Need to have a colon before ENDLIST if there are any tags
    if tags != "":
        tags += ":"
    return tags + "ENDLIST"

def is_location_valid(longitude, latitude):
    '''Verify that the latitude and longitude are valid'''
    return (float(latitude) >= -90 and
            float(latitude) <= 90 and
            float(longitude) >= -180 and
            float(longitude) <= 180)

def jsonify_get(res):
    '''Convert the result of a get request to a nice json object'''
    return [{"id": res[0],
            "url": res[1], 
            "latitude": res[2], 
            "longitude": res[3], 
            "poster": res[4], 
            "views": res[5], 
            "date": res[6],
            "tags": res[7]} for res in res]

@app.route('/getPosts', methods=['GET'])
def get_posts():
    '''Get posts from the database by location, page number, radius, and tags'''
    
    # Grab the arguments provided in the request
    tags = request.args.getlist('tags')
    latitude = request.args.get('latitude', None)
    longitude = request.args.get('longitude', None)
    radius = request.args.get('radius', None)
    pageNum = request.args.get('pageNum', None)
    cmd_params = []

    # Verify the locational arguments are valid
    if latitude is not None and longitude is not None:
        if not is_location_valid(longitude, latitude):
            return INVALID_LOCATION, 400
        if radius is None:
            return NO_RADIUS_GIVEN, 400
        # Append the latitude, longitude, and radius to the params since they are formatted correctly
        cmd_params += [latitude, longitude, radius]
    elif radius is not None:
        return NO_LOCATION_GIVEN, 400
    else:
        # If no location is given, grab all posts (negative radius means grab everything)
        cmd_params += [0, 0, -1]
    
    tags = str_tags(tags)
    cmd_params.append(tags)

    # Get the posts from the database based on the page number (if specified, otherwise get all posts)
    cur = db.connection.cursor()
    if pageNum is None:
        pageNum = 1
    else:
        pageNum = int(pageNum)
    cmd_params.insert(0, pageNum)
    cur.callproc("george.getPosts", cmd_params)
    res = cur.fetchall()
    res = jsonify_get(res)

    # Get the tags for each post
    for r in res:
        cur.execute("SELECT Tag FROM george.Tags WHERE PostID = " + str(r["id"]) + ";")
        tags = cur.fetchall()
        r["tags"] = [tag[0] for tag in list(tags)[:-1]]
    cur.close()
    return jsonify(res), 200

@app.route('/uploadPost', methods=['POST'])
def upload_post():
    '''Upload a post to the database and store the image in the file system'''
    # Grab the arguments provided in the request
    tags = request.args.getlist('tags')
    user = request.args.get('user')
    latitude = request.args.get('latitude')
    longitude = request.args.get('longitude')

    # Ensure the latitude and longitude are specified correctly
    if not is_location_valid(longitude, latitude):
        return INVALID_LOCATION, 400
        
    # Upload image to the storage folder
    image = Image.open(io.BytesIO(request.data))
    image_path = str(uuid.uuid4()) + ".png"
    image.save(fp = os.environ["IMAGE_DIR"] + "/" + image_path, format = "png")

    # Send the post to the database using the uploadPost stored procedure
    tags = str_tags(tags)
    cmd_params = (image_path, latitude, longitude, user, tags)
    cur = db.connection.cursor()
    cur.callproc("george.uploadPost", cmd_params)
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
    app.config.from_object('config.ProdConfig')
    db.init_app(app)
    app.run(host='0.0.0.0', port=3434)