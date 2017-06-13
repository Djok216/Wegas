import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-learn',
  templateUrl: './learn.component.html',
  styleUrls: ['./learn.component.css']
})
export class LearnComponent implements OnInit {

  text: string;
  textheader: string;

  constructor() { }

  ngOnInit() {
    this.text = '';
    this.textheader = '';
  }


  changeText( n: number) {
    if (n === 1) {
      this.textheader = 'Step 1. How to Setup the Chessboard';
      this.text = 'At the beginning of the game the chessboard is laid out so that each player has the white (or light) color square in the bottom right-hand side. The chess pieces are then arranged the same way each time. The second row (or rank) is filled with pawns. The rooks go in the corners, then the knights next to them, followed by the bishops, and finally the queen, who always goes on her own matching color (white queen on white, black queen on black), and the king on the remaining square.';
    }else if (n === 2) {
      this.textheader = "Step 2. How the Chess Pieces Move";
      this.text = "Each of the 6 different kinds of pieces moves differently. Pieces cannot move through other pieces (though the knight can jump over other pieces), and can never move onto a square with one of their own pieces. However, they can be moved to take the place of an opponent\'s piece which is then captured. Pieces are generally moved into positions where they can capture other pieces (by landing on their square and then replacing them), defend their own pieces in case of capture, or control important squares in the game. \r\n \
      How to Move the King in Chess\n \
      The king is the most important piece, but is one of the weakest. The king can only move one square in any direction - up, down, to the sides, and diagonally. The king may never move himself into check (where he could be captured). When the king is attacked by another piece this is called \"check\".\n\n How to Move the Queen in Chess \n \
      The queen is the most powerful piece. She can move in any one straight direction - forward, backward, sideways, or diagonally - as far as possible as long as she does not move through any of her own pieces. And, like with all pieces, if the queen captures an opponent\'s piece her move is over. Notice how the white queen captures the black queen and then the black king is forced to move.\n\n \
      How to Move the Rook in Chess\n \
      The rook may move as far as it wants, but only forward, backward, and to the sides. The rooks are particularly powerful pieces when they are protecting each other and working together!\n\n \
      How to Move the Bishop in Chess\n \
      The bishop may move as far as it wants, but only diagonally. Each bishop starts on one color (light or dark) and must always stay on that color. Bishops work well together because they cover up each other\'s weaknesses.\n\n \
      How to Move the Knight in Chess\n \
      Knights move in a very different way from the other pieces – going two squares in one direction, and then one more move at a 90 degree angle, just like the shape of an “L”. Knights are also the only pieces that can move over other pieces.\n\n \
      How to Move the Pawn in Chess\n \
      Pawns are unusual because they move and capture in different ways: they move forward, but capture diagonally. Pawns can only move forward one square at a time, except for their very first move where they can move forward two squares. Pawns can only capture one square diagonally in front of them. They can never move or capture backwards. If there is another piece directly in front of a pawn he cannot move past or capture that piece.";
    }else if (n === 3) {
      this.textheader = 'Step 3. Discover the Special Rules of Chess';
      this.text = 'There are a few special rules in chess that may not seem logical at first. They were created to make the game more fun and interesting.\n\n \
      How to Promote a Pawn in Chess: \n \
      Pawns have another special ability and that is that if a pawn reaches the other side of the board it can become any other chess piece (called promotion). A pawn may be promoted to any piece. A common misconception is that pawns may only be exchanged for a piece that has been captured. That is NOT true. A pawn is usually promoted to a queen. Only pawns may be promoted.\n\n \
      How to do "en passant" in Chess:\n \
      The last rule about pawns is called “en passant,” which is French for “in passing”. If a pawn moves out two squares on its first move, and by doing so lands to the side of an opponent\'s pawn (effectively jumping past the other pawn\'s ability to capture it), that other pawn has the option of capturing the first pawn as it passes by. This special move must be done immediately after the first pawn has moved past, otherwise the option to capture it is no longer available. Click through the example below to better understand this odd, but important rule.\n\n \
      How to Castle in Chess:\n \
      One other special chess rule is called castling. This move allows you to do two important things all in one move: get your king to safety (hopefully), and get your rook out of the corner and into the game. On a player\'s turn he may move his king two squares over to one side and then move the rook from that side\'s corner to right next to the king on the opposite side. (See the example below.) However, in order to castle, the following conditions must be met:\n \
      it must be that king\'s very first move;\n \
      it must be that rook\'s very first move; \n \
      there cannot be any pieces between the king and rook to move; \n \
      the king may not be in check or pass through check. \n \
      Notice that when you castle one direction the king is closer to the side of the board. That is called castling &quot;kingside&quot;. Castling to the other side, through where the queen sat, is called castling &quot;queenside&quot;. Regardless of which side, the king always moves only two squares when castling.\n\n \
      ';
    }else if (n === 4) {
      this.textheader = 'Step 4. Find out Who Makes the First Move in Chess';
      this.text = 'The player with the white pieces always moves first. Therefore, players generally decide who will get to be white by chance or luck such as flipping a coin or having one player guess the color of the hidden pawn in the other player\'s hand. White then makes a move, followed by black, then white again, then black and so on until the end of the game. Being able to move first is a tiny advantage which gives the white player an opportunity to attack right away.';
    }else if (n === 5) {
      this.textheader = 'Step 5. Review the Rules of How to Win a Game of Chess';
      this.text = 'There are two ways to end a game of chess: by checkmate, or with a draw.\n\n \
      How to Checkmate in Chess:\n \
      The purpose of the game is to checkmate the opponent\'s king. This happens when the king is put into check and cannot get out of check. There are only three ways a king can get out of check: move out of the way (though he cannot castle!), block the check with another piece, or capture the piece threatening the king. If a king cannot escape checkmate then the game is over. Customarily the king is not captured or removed from the board, the game is simply declared over.\n\n \
      How to Draw a Chess Game:\n \
      Occasionally chess games do not end with a winner, but with a draw. There are 5 reasons why a chess game may end in a draw:\n \
      The position reaches a stalemate where it is one player\'s turn to move, but his king is NOT in check and yet he does not have another legal move\n \
      The players may simply agree to a draw and stop playing\n \
      There are not enough pieces on the board to force a checkmate (example: a king and a bishop vs.a king)\n \
      A player declares a draw if the same exact position is repeated three times (though not necessarily three times in a row)\n \
      Fifty consecutive moves have been played where neither player has moved a pawn or captured a piece\n ';
    }else if (n === 6) {
      this.textheader = 'Step 6. Study Basic Chess Strategies';
      this.text = 'There are four simple things that every chess player should know:\n \
      Protect your King: \n \
      Get your king to the corner of the board where he is usually safer. Don\'t put off castling. You should usually castle as quickly as possible. Remember, it doesn\'t matter how close you are to checkmating your opponent if your own king is checkmated first!\n\n \
      Control the Center of the Chessboard:\n \
      You should try and control the center of the board with your pieces and pawns. If you control the center, you will have more room to move your pieces and will make it harder for your opponent to find good squares for his pieces. In the example above white makes good moves to control the center while black plays bad moves.\n\n \
      Use All of your Chess Pieces:\n \
      In the example above white got all of his pieces in the game! Your pieces don\'t do any good when they are sitting back on the first row. Try and develop all of your pieces so that you have more to use when you attack the king. Using one or two pieces to attack will not work against any decent opponent.\n\n \
      ';
    }else if (n === 7) {
      this.textheader = 'Step 7. Practice by Playing Lots of Games';
      this.text = 'The most important thing you can do to get better at chess is to play lots of chess! It doesn\'t matter if you play at home with friends or family, or play online, you have to play the game a lot to improve. These days it\'s easy to find a game of chess online!\n\n \
      How to Play Chess Variants:\n \
      While most people play standard chess rules, some people like to play chess with changes to the rules. These are called "chess variants". Each variant has its own rules.\n\n \
      How to Play Chess960: \n \
      Chess960 follows all the rules of standard chess, except for the starting position of pieces on the back rank, which are placed randomly in one of 960 possible positions. Castling is done just like in standard chess, with the King and Rook landing on their normal castled squares (g1 and f1, or c1 and d1). 960 plays just like standard chess, but with more variety in the opening.\n\n \
      How to Play with Chess Tournament Rules: \n \
      Many tournaments follow a set of common, similar rules. These rules do not necessarily apply to play at home or online, but you may want to practice with them anyway.\n\n \
      Touch-move: - If a player touches one of their own pieces they must move that piece as long as it is a legal move. If a player touches an opponent\'s piece, they must capture that piece. A player who wishes to touch a piece only to adjust it on the board must first announce the intention, usually by saying “adjust”.\n \
      Clocks and Timers: - Most tournaments use timers to regulate the time spent on each game, not on each move. Each player gets the same amount of time to use for their entire game and can decide how to spend that time. Once a player makes a move they then touch a button or hit a lever to start the opponent\'s clock. If a player runs out of time and the opponent calls the time, then the player who ran out of time loses the game (unless the opponent does not have enough pieces to checkmate, in which case it is a draw).';
    }else if (n === 8) {
      this.textheader = 'Frequently Asked Chess Questions (FAQs)';
      this.text = 'How do I get better at chess?\n \n \
      Knowing the rules and basic strategies is only the beginning - there is so much to learn in chess that you can never learn it all in a lifetime! To improve you need to do three things:\n \
      Play lots of chess — Just keep playing! Play as much as possible. You should learn from each game – those you win and those you lose.\n \
      Study with chess lessons — If you really want to improve quickly then you should do some online chess lessons. You can find online chess lessons here.\n\n \
      Have fun — Don\'t get discouraged if you don\'t win all of your games right away. Everyone loses – even world champions. As long as you continue to have fun and learn from the games you lose then you can enjoy chess forever!\n\n \
      What is the best first move in chess?\n\n \
      While there is no one agreed-upon best move in chess, it\'s important to try to control the center right away. This usually results in most players playing one of their central pawns (in front of king or queen) forward two squares with either 1. d4 or 1. e4. Some other players prefer 1. c4 or 1. Nf3. Most other moves are not as good. Bobby Fischer believed that moving the king-pawn 1. e4 was best.\n\n \
      Which color starts in chess? \n \
      The player with the white pieces always moves first.\n\n \
      Can a pawn move backwards?\n \
      Pawns cannot move backwards. However, when a pawn gets to the other side of the board you must promote it to another piece (such as a queen). Then it moves just like that piece, and can move backwards.\n \
      Can you move more than one piece at a time in chess?\n \
      You can only move one chess piece at a time when it is your turn to move - with one exception! When you castle, you move both the king and the rook in one move.\n\n \
      Which is the most important chess piece?\n \
      The king is the most important chess piece. If you lose the king, you lose the game. But the queen is the most powerful chess piece.\n\n \
      When was chess invented?\n \
      The origins of chess are not exactly clear, though most believe it evolved from earlier chess-like games played in India almost two thousand years ago.The game of chess we know today has been around since the 15th century where it became popular in Europe.\n \
      What is the goal of chess?\n \
      Chess is a game played between two opponents on opposite sides of a board containing 64 squares of alternating colors. Each player has 16 pieces: 1 king, 1 queen, 2 rooks, 2 bishops, 2 knights, and 8 pawns. The goal of the game is to checkmate the other king. Checkmate happens when the king is in a position to be captured (in check) and cannot escape from capture.';
    }
  }
}
