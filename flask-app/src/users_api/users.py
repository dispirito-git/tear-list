from flask import Blueprint, request, jsonify, make_response
import json
from src import db


users_blueprint = Blueprint('users', __name__)

# Takes in a username and password and returns the user's information if the login is successful
@users_blueprint.route('/login', methods=['POST'])
def postLoginInfo(username, password):
    users_blueprint.logger.info(request.form)
    cursor = db.get_db().cursor()
    username = request.form['username']
    password = request.form['password']
    cursor.execute('SELECT * FROM logins WHERE login_user = %s AND login_pass = %s',
     (username, password))
    res = cursor.fetchone()
    if res:
        the_response = make_response(jsonify(res))
        the_response.status_code = 200
        the_response.mimetype = 'application/json'
        return the_response

# Create a post with the given (s, a, b, c, d, e, f) tiers, title, and description
def create_a_post(s, a, b, c, d, e, f, title, description):
    cursor = db.get_db().cursor()
    cursor.execute('INSERT INTO posts (title, s, a, b, c, d, e, f, description) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)',
     (s, a, b, c, d, e, f, title, description))
    db.get_db().commit()

# Get all the followers of the user with the given userID
@users_blueprint.route('/<userID>/followers', methods=['GET'])
def get_followers(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from followers where userID = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all the users that the user with the given userID is following
@users_blueprint.route('/<userID>/following', methods=['GET'])
def get_following(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from followers where following_user_id = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all the communities that this user is a member of
@users_blueprint.route('/<userID>/communities', methods=['GET'])
def get_user_communities(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from community_follower where followed_user_id = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all the posts that this user has made
@users_blueprint.route('/<userID>/posts', methods=['GET'])
def get_user_posts(userID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from posts where user_id = {0}'.format(userID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

