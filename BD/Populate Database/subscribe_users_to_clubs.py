# subscribe_users_to_clubs.py
import requests
import json
from random import randint


def subscribe_users(username, clubname):
    data = {'memberName': username}
    headers = {'Content-Type': 'application/json'}
    r = requests.post('http://localhost:4500/clubs/' + clubname + '/addMember', data=json.dumps(data), headers=headers)
    print(r.status_code, r.reason, r.text)


with open("data/club_names.txt", "r") as f:
    club_names = f.readlines()
club_names = [x.strip() for x in club_names]

with open("data/user_names.txt", "r") as f:
    users_data = f.readlines()
users_data = [x.strip() for x in users_data]

for x in range(0, 1500):
    usr_id = randint(1, 3999)
    club_id = randint(1, 999)
    current_user = users_data[usr_id].split('\t')
    subscribe_users(current_user[0] + current_user[1], club_names[club_id])
