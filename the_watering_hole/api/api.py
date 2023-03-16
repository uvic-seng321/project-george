from flask import Flask, request, jsonify
from flask_mysqldb import MySQL

app = Flask(__name__)
app.config.from_object('config.Config')

db = MySQL(app)

@app.route('/', methods=['GET'])
def home():
    return "Welcome to The Watering Hole's api!"

@app.route('/getPosts', methods=['GET'])
def get_posts():
    # TODO this is just a test to see if this works. implement this
    args = request.args
    if "latitude" in args and "longitude" in args and "radius" not in args:
        return "ERROR: radius not specified given a longitude and latitude", 400
    cursor = db.connection.cursor()
    cursor.execute("SELECT * FROM Posts;")
    posts = cursor.fetchall()
    db.connection.commit()
    cursor.close()
    return jsonify(posts)

@app.route('/uploadPost', methods=['POST'])
def upload_post():
    # TODO implement this. this is the syntax for calling a stored procedure for uploading the post to the database
    # cursor = db.connection.cursor()
    # cursor.execute("CALL `george`.`uploadPost`('test URL', -1, -1, -1, 'EX:GEEB:THREE:ENDLIST');")
    # db.connection.commit()
    # cursor.close()
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