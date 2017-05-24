# populate_users.py

import requests
import json


def populate_users(username, password, email):
    data = {'username': username, 'password': password, "email": email}
    headers = {'Content-Type': 'application/json'}
    r = requests.post('http://localhost:4500/user/register', data=json.dumps(data), headers=headers)
    print(r.status_code, r.reason, r.text)


with open("data/user_names.txt", "r") as f:
    content = f.readlines()
content = [x.strip() for x in content]

for user in content:
    user_data = user.split('\t')
    populate_users(user_data[0] + user_data[1], user_data[0] + user_data[1], user_data[2])
