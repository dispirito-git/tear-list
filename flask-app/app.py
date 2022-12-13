###
# Main application interface
###

# import the create app function 
# that lives in src/__init__.py
from src import create_app
from src.admin import admin
from src.users import users
from flask import request

# create the app object
app = create_app()

app.register_blueprint(admin)
app.register_blueprint(users)

@app.route('/login', methods=['POST'])
def login():
    app.logget.info(request.form)
    return 'login'
if __name__ == '__main__':
    # we want to run in debug mode (for hot reloading) 
    # this app will be bound to port 4000. 
    # Take a look at the docker-compose.yml to see 
    # what port this might be mapped to... 
    app.run(debug = True, host = '0.0.0.0', port = 4000)