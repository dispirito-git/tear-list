###
# Main application interface
###

# import the create app function 
# that lives in src/__init__.py
from src import create_app
from flask import request
from src.admin_api.admin import admin_blueprint
from src.users_api.users import users_blueprint
from src import db



# create the app object
app = create_app()

if __name__ == '__main__':
    # we want to run in debug mode (for hot reloading) 
    # this app will be bound to port 4000. 
    # Take a look at the docker-compose.yml to see 
    # what port this might be mapped to... 
    app.run(debug = True, host = '0.0.0.0', port = 4000)