import os
from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from services.animal_data_service import AnimalDataService
from routes.user_routes import users_bp
from routes.pet_routes import pets_bp
from config import Config
from db_config import DBConfig, create_db_engine
from db.repo import get_user_with_pets
from dotenv import load_dotenv

jwt = JWTManager()
load_dotenv()
# AnimalDataService()

def _create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    jwt.init_app(app) #TODO: what is done here?

    app.register_blueprint(users_bp)
    app.register_blueprint(pets_bp)

    cfg = DBConfig.from_env()
    engine = create_db_engine(cfg)

    data = get_user_with_pets(engine, "vadim37")
    print(data)

    origins_env = os.getenv("CORS_ORIGINS", "")
    allowed_origins = [o.strip() for o in origins_env.split(",") if o.strip()]
    # If empty, you can choose to deny all by default (recommended)
    CORS(app, origins=allowed_origins)

    return app

app = _create_app()

if __name__ == "__main__":
    app.run()
