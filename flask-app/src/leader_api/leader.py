from flask import Blueprint, jsonify, make_response
import json
from src import db


leader_blueprint = Blueprint('com_leader', __name__)

# Get all the members of the community with the given communityID
@leader_blueprint.route('/<communityID>/members', methods=['GET'])
def get_members(communityID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from community_follower where community_id = {0}'.format(communityID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get all the posts that have been made in the community with the given communityID
@leader_blueprint.route('/<communityID>/posts', methods=['GET'])
def get_community_posts(communityID):
    cursor = db.get_db().cursor()
    cursor.execute('select * from community_post where community_id = {0}'.format(communityID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
