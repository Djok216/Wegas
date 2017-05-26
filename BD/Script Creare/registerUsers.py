import requests
from random import randint as randInt

def populate(username, password, email, wins, loses):
  info = username + ' ' + password + ' ' + password + ' ' + email + ' ' + wins + ' ' + loses
  r = requests.post('http://localhost:4500/public/user/registerPy', data = info)
  print (r.status_code, r.reason)

fin = open("name.txt", "r")
name = fin.readlines()
fin.close()

for i in range(0, len(name)):
  name[i] = name[i].strip()

for nr in range(0, 227):
  i = randInt(0, len(name) - 1)
  j = randInt(0, len(name) - 1)
  username = name[i] + name[j]
  password = name[j] + name[i] + str(randInt(0, 10**9))
  email = name[i] + name[j] + str(nr) + "@gmail.com"
  wins = str(randInt(0, 300))
  loses = str(randInt(0, 300))
  populate(username, password, email, wins, loses)