import { Component, OnInit } from '@angular/core';

declare var Chess: any;
declare var ChessBoard: any;

@Component({
  selector: 'app-live',
  templateUrl: './live.component.html',
  styleUrls: ['./live.component.css']
})
export class LiveComponent implements OnInit{

  constructor() {
  }

  ngOnInit() {
    var board;
    var game = new Chess();

    // do not pick up pieces if the game is over
    var onDragStart = function(source, piece, position, orientation) {
      if (game.in_checkmate() === true || game.in_draw() === true ||
        piece.search(/^b/) !== -1) {
        return false;
      }
    };

    var makeRandomMove = function() {
      var possibleMoves = game.moves();

      // game over
      if (possibleMoves.length === 0) return;

      var randomIndex = Math.floor(Math.random() * possibleMoves.length);
      game.move(possibleMoves[randomIndex]);
      board.position(game.fen());
    };

    var onDrop = function(source, target) {
      // see if the move is legal
      var move = game.move({
        from: source,
        to: target,
        promotion: 'q' // NOTE: always promote to a queen for example simplicity
      });

      // illegal move
      if (move === null) return 'snapback';

      // make random legal move for black
      window.setTimeout(makeRandomMove, 250);
    };

    // update the board position after the piece snap
    // for castling, en passant, pawn promotion
    var onSnapEnd = function() {
      board.position(game.fen());
    };

    var cfg = {
      draggable: true,
      position: 'start',
      onDragStart: onDragStart,
      onDrop: onDrop,
      onSnapEnd: onSnapEnd,
      pieceTheme: "http://chessboardjs.com/img/chesspieces/wikipedia/{piece}.png"
    };

    var isLive = document.getElementById('board');
    if(isLive === null) {}
    else { board = new ChessBoard('board', cfg); }
  }
}
