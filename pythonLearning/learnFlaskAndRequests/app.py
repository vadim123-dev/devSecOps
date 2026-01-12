from flask import Flask
from flask_jwt_extended import JWTManager
from services.animal_data_service import AnimalDataService
from routes.user_routes import users_bp
from routes.pet_routes import pets_bp
from config import Config


jwt = JWTManager()
AnimalDataService()

def _create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    jwt.init_app(app) #TODO: what is done here?

    app.register_blueprint(users_bp)
    app.register_blueprint(pets_bp)

    return app

app = _create_app()

if __name__ == "__main__":
    app.run()
