from services.user_data_service import UserDataService
from flask import jsonify
from models.user import User
from flask_jwt_extended import (
    create_access_token,
    create_refresh_token
)
from werkzeug.security import check_password_hash

class AuthService:

    userd_service = UserDataService()

    def login_user(self, req_json: dict):
        user_name = req_json.get("user_name")
        password = req_json.get("password")

        if not user_name or not password:
            return jsonify(error="username and password are required"), 400

        users_dict = self.userd_service.get_all_users()
        user = users_dict[user_name]

        if not user:
            return jsonify(error="Invalid credentials"), 401

        if not check_password_hash(user.password_hash, password):
            return jsonify(error="Invalid credentials"), 401
        
        access_token = create_access_token(identity=user_name)
        refresh_token = create_refresh_token(identity=user_name) #TODO: check why we need refresh token and how it works

        return jsonify(
            access_token = access_token,
            refresh_token = refresh_token,
            token_type = "Bearer"
        ), 200

