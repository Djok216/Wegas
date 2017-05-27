# pgn_parser.py


# download and install chess.pgn
# pip install python-chess[uci,gaviota]
import chess.pgn
import chess.syzygy

with open("data/Adams.pgn", "r") as f:
    game = chess.pgn.read_game(f)
    moves = game.main_line()
    print(game.board().variation_san(moves))

with open("data/Akobian.pgn", "r") as f:
    game = chess.pgn.read_game(f)
    moves = game.main_line()
    print(game.board().variation_san(moves))

with open("data/Akopian.pgn", "r") as f:
    game = chess.pgn.read_game(f)
    moves = game.main_line()
    print(game.board().variation_san(moves))