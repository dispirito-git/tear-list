from flask import Blueprint, request, jsonify, make_response
import json
from src import db


admin_blueprint = Blueprint('admin_blueprint', __name__)

# update the user with the given username and email
@admin_blueprint.route('/update_user', methods=['POST'])
def update_user():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # get the username and email from the request
    username = request.form['username']
    email = request.form['email']

    # update the user with the given username and email
    cursor.execute('update user set email = %s where username = %s', (email, username))
    db.get_db().commit()

    return 'Success!'

# Get all the users from the database
@admin_blueprint.route('/users', methods=['GET'])
def get_users():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('select * from user')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get all the communities from the database
@admin_blueprint.route('/mng_communities', methods=['GET'])
def get_communities():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('select * from community')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Update the community with new name and description
@admin_blueprint.route('/update_community', methods=['POST'])
def update_community():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # get the communityID, name and description from the request
    communityID = request.form['communityID']
    name = request.form['name']
    description = request.form['description']

    # update the community with the given communityID, name and description
    cursor.execute('update community set community_name = %s, commuinity_desc = %s where community_id = %s', (name, description, communityID))
    db.get_db().commit()

    return 'Success!'
