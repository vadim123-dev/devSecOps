from flask import Blueprint, request, jsonify
from services.auth_service import AuthService
from models import User
from services.user_data_service import UserDataService
from flask_jwt_extended import (
    jwt_required,
    get_jwt_identity
)

users_bp = Blueprint("users", __name__, url_prefix="/users")
# Apply CORS to all /users/* routes
# CORS(users_bp, resources={r"/*": {"origins": "http://localhost:5173"}})



auth_service = AuthService()
user_data_service = UserDataService()


@users_bp.route("/authenticate", methods=['POST','OPTIONS'])
def authenticate():
    if request.method == "OPTIONS":
        return "", 204  # ✅ preflight OK
    
    print("METHOD:", request.method)
    print("DATA:", request.data)

    data = request.get_json(silent=True) or {} # silent returns None if not valid json
    return auth_service.login_user(data)


@users_bp.get("/current")
@jwt_required()
def get_user_data():
    return jsonify(user_data_service.get_user(get_jwt_identity()).to_dict()), 200

@users_bp.get("/all")
@jwt_required()
def get_all_users_data(): # TODO: add role validation before calling get methods 
    all_users_dict = user_data_service.get_all_users()
    users_lst = [user.to_dict() for user in all_users_dict.values()]
    return jsonify(users_lst), 200


@users_bp.post("/add")
@jwt_required()
def add_user():
    data = request.get_json(silent=True) or {}
    return jsonify(user_data_service.add_user(get_jwt_identity(), data).to_dict()), 201 # passing user that asks to crete another user
                                                                # for role validation

