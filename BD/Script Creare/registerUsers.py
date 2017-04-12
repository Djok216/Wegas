import requests
from random import randint as randInt

def populate(username, password, email):
  info = username + ' ' + password + ' ' + password + ' ' + email
  r = requests.post('http://localhost:8181/public/user/register', data = info)
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
  populate(username, password, email)