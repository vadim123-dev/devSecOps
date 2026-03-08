from flask import Flask
from flask import request
from flask import jsonify
from user import User
import uuid

app = Flask(__name__)

users_dict = {}

@app.route("/getAllUsers")
def get_all_users():
    return users_dict

@app.route("/getSingleUser", methods = ['GET'])
def get_single_user():
    data = request.get_json()
    user_id = data.get("id")
    user_name = users_dict[user_id]
    return jsonify({"id" : user_name, "name" : user_name})

@app.route("/upsertUser", methods = ['POST', 'PUT'])
def add_user():
    user = extract_user_data(request)
    users_dict[user.id] = user.name
    return f"Upserted user {user.name} to users dictionary"

@app.route("/removeUser", methods = ['DEL'])
def remove_user():
    data = request.get_json()
    user_id = data.get("id")
    users_dict.pop(user_id, None)
    return f"Removed user with id {user_id} "


def extract_user_data(request):
    user_uuid = uuid.uuid4() #change to using this uuid when creating new User
    data=request.get_json()
    print(f"got user upsert request {data}")

    user_id=data.get("id")
    user_name=data.get("name")
    return User(user_id, user_name)


app.run(host="0.0.0.0", port=5000)

