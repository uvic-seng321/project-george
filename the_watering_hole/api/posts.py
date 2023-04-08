import base64
import io
import json
import os
import uuid

from h3 import point_dist
from flask import Blueprint, request, jsonify
from constants import INVALID_LOCATION, NO_LOCATION_GIVEN, NO_RADIUS_GIVEN
from utils import send_get_posts, send_upload_post, send_query
from PIL import Image

posts_api = Blueprint('posts_api', __name__)

IMAGE_DIR = os.environ["IMAGE_DIR"] + "/"

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
    return [{"id": result[0],
            "latitude": result[2], 
            "longitude": result[3], 
            "poster": result[4], 
            "views": result[5], 
            "date": result[6],
            "tags": result[7]} for result in res]

def filter_location(json_results, latitude, longitude, radius):
    '''Filter the results of a get request by location'''
    filtered_results = []
    for result in json_results:
        if point_dist((latitude, longitude), (result["latitude"], result["longitude"])) <= radius:
            filtered_results.append(result)
    return filtered_results

@posts_api.route('/getTags', methods=['GET'])
def get_tags():
    '''Get a list of tags from the server by id'''
    id = request.args.get('id', None)
    if id is None:
        return "No id provided", 400
    tags = send_query("SELECT Tag FROM Tags WHERE PostID = %s", [id])
    tags = [tag[0] for tag in tags if tag[0] != "ENDLIST"]
    return jsonify(tags), 200

@posts_api.route('/getImage', methods=['GET'])
def get_image():
    '''Get an image from the server by id'''
    id = request.args.get('id', None)
    if id is None:
        return "No id provided", 400
    
    try:
        url = send_query("SELECT ImageURL FROM Posts WHERE PostID = %s", [id])[0][0]
        image = base64.b64encode(open(IMAGE_DIR + url, 'rb').read())
        return image, 200
    except:
        return "Something went wrong...", 400

@posts_api.route('/getPosts', methods=['GET'])
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
    if pageNum is None:
        pageNum = 1
    else:
        pageNum = int(pageNum)
    cmd_params.insert(0, pageNum)
    res = send_get_posts(cmd_params)
    res = jsonify_get(res)
    res = filter_location(res, float(latitude), float(longitude), float(radius)) if radius is not None else res

    return jsonify(res), 200

@posts_api.route('/uploadPost', methods=['POST'])
def upload_post():
    '''Upload a post to the database and store the image in the file system'''
    # Grab the arguments provided in the request
    tags = request.form.getlist('tags[]')
    if tags is [] and request.form.get('tags', None) is not None:
        tags = json.loads(request.form.get('tags'))
        
    user = request.form.get('user')
    latitude = request.form.get('latitude')
    longitude = request.form.get('longitude')

    # Ensure the latitude and longitude are specified correctly
    if not is_location_valid(longitude, latitude):
        return INVALID_LOCATION, 400

    # Upload image to the storage folder
    if request.files.get('image') is not None:
        image_bytes = request.files.get('image').read()
    else:
        image_bytes = base64.b64decode(request.form.get('image'))

    if image_bytes is None:
        return "No image provided", 400

    image_path = str(uuid.uuid4()) + ".png"
    with open(IMAGE_DIR + image_path, 'wb') as f:
        f.write(image_bytes)

    # Send the post to the database using the uploadPost stored procedure
    tags = str_tags(tags)
    cmd_params = [image_path, latitude, longitude, user, tags]
    send_upload_post(cmd_params)
    return "", 200

# @posts_api.route('/removePost', methods=['DELETE'])
# def remove_post():
#     return "Unimplemented", 400

# @posts_api.route('/viewPost', methods=['PATCH'])
# def view_post():
#     return "Unimplemented", 400

# @posts_api.route('/updatePost', methods=['PATCH'])
# def update_post():
#     return "Unimplemented", 400