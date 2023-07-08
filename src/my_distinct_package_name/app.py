# # Import OS to get the port environment variable from the Procfile
# import os

# # Import the flask module
# from flask import Flask

# # Create a Flask constructor. It takes name of the current module as the argument
# _app = Flask(__name__)


# @_app.route("/")
# def hello_world():
#     statement = "Hello World!"
#     return statement


# # Create the main driver function


# def app():
#     port = int(os.environ.get("PORT", 5015))
#     return _app.run(host="0.0.0.0", port=port)

from flask import Flask
import os

app = Flask(__name__)


@app.route("/")
def hello():
    return "Hello, World!"


if __name__ == "__main__":
    # app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
    app.run(host="0.0.0.0")
