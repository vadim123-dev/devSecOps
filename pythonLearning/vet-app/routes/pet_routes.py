from flask import request
from flask import Blueprint, jsonify

pets_bp = Blueprint("pets", __name__)