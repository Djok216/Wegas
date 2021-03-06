# populate_clubs.py

import requests
import json

with open("data/token.txt", "r") as f:
    tokens = f.readlines()
token = tokens[0]


def populate_clubs(club_name):
    data = {'clubName': club_name}
    headers = {'Content-Type': 'application/json',
               'Authorization': token}
    r = requests.post('http://localhost:4500/clubs/addClub', data=json.dumps(data), headers=headers)
    print(r.status_code, r.reason, r.text)


with open("data/club_names.txt", "r") as f:
    content = f.readlines()
content = [x.strip() for x in content]

for name in content:
    populate_clubs(name)
