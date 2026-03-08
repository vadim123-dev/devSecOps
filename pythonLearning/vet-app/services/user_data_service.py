from repositories.user_repository import UserRepository
from models import User, Pet
from werkzeug.security import generate_password_hash
from flask import jsonify
from utils import auth_utils
import uuid

class UserDataService:
    

    
    def _load_user_data(self, repo: UserRepository):
        #users = repo.get_all_users() # load from repo all users
        # after getting list of users put them into map
        self.users_dict = {
                  "vad" :  User('112233', 'vad', 'Vadim','Hasmenik', 1, 'Beit Dagan', 'vad123', '0523434834', {"123": Pet('cat','Bengal','Mitsi')}),
                  "alex": User('223344', 'alex', 'Alex', 'Cohen', 1, 'Tel Aviv', 'alexPass', '0501234567', {"234": Pet('dog', 'Labrador', 'Buddy')}),
                  "maria": User('334455', 'maria', 'Maria', 'Levi', 2, 'Haifa', 'mariaPwd', '0529876543', {"345": Pet('cat', 'Siamese', 'Luna')}),
                  "dan": User('445566', 'dan', 'Dan', 'Rosen', 1, 'Rishon LeZion', 'danSecure', '0541122334', {"456": Pet('parrot', 'African Grey', 'Kiwi')}),
                  "sarah": User('556677', 'sarah', 'Sarah', 'Goldman', 2, 'Netanya', 'sarahKey', '0534455667', {"567": Pet('dog', 'Border Collie', 'Sky')}),
                  "yossi": User('667788', 'yossi', 'Yossi', 'Ben-David', 1, 'Ashdod', 'yossi123', '0509988776', {"678": Pet('rabbit', 'Holland Lop', 'Snow')})

                  }    
        
        for user_name, user in self.users_dict.items():
            hash_ = generate_password_hash(user.password_hash)
            user.password_hash = hash_

            print(hash_)

    def get_all_users(self):
        return self.users_dict 

    def get_user(self, user_name):
        return self.users_dict[user_name]
    
    def add_user(self, user_requester, req_json) -> User:
        user_id = uuid.uuid4()
        temp_password = auth_utils.generate_strong_password(8)
        

        user_name = req_json.get("user_name")
        last_name = req_json.get("last_name")
        first_name = req_json.get("first_name")
        gender = req_json.get("gender")
        city = req_json.get("city")
        telephone = req_json.get("telephone")

        new_user = User(user_id, user_name, first_name, last_name, gender, city, temp_password, telephone)
        self.users_dict[user_name] = new_user

        return new_user


    def __init__(self):
        self.users_dict = {} # user_id vs user
        users_repo = UserRepository()
        self._load_user_data(users_repo)

    