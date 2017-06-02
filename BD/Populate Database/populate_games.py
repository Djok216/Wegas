# populate_games.py

# download and install chess.pgn
# pip install python-chess[uci,gaviota]

import chess.pgn
import chess.syzygy
import requests
import json
from random import randint

with open("data/token.txt", "r") as f:
    tokens = f.readlines()
token = tokens[0]


def add_game_started():
    first_player_id = randint(1, 3999)
    second_player_id = randint(1, 3999)
    data = {'firstPlayerId': first_player_id, 'secondPlayerId': second_player_id}
    headers = {'Content-Type': 'application/json',
               'Authorization': token}
    r = requests.post('http://localhost:4500/games/addGameStarted', data=json.dumps(data), headers=headers)
    print(r.status_code, r.reason, r.text)
    return json.loads(r.text)["gameId"]


def add_game_ended(game_id, movements, game_result):
    data = {'gameId': game_id, 'movements': movements, 'gameResult': game_result}
    headers = {'Content-Type': 'application/json',
               'Authorization': token}
    r = requests.put('http://localhost:4500/games/addGameEnded', data=json.dumps(data), headers=headers)
    print(r.status_code, r.reason, r.text)


with open("data/Akobian.pgn", "r") as f:
    while True:
        game = chess.pgn.read_game(f)
        if not game: break
        moves = game.main_line()
        string = game.board().variation_san(moves)
        game_id = add_game_started()
        movements = string[:1998]
        game_result_string = game.headers["Result"]
        game_result = {'1-0': 1,
                       '0-1': 2,
                       '1/2-1/2': 0}[game_result_string]
        add_game_ended(game_id, movements, game_result)
