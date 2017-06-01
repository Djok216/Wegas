import { Component, OnInit } from '@angular/core';
import { Cookie } from 'ng2-cookies/ng2-cookies';
import {Router} from "@angular/router";

declare let Chess: any;
declare let ChessBoard: any;

@Component({
  selector: 'app-live',
  templateUrl: './live.component.html',
  styleUrls: ['./live.component.css']
})
export class LiveComponent implements OnInit{
  board : any;
  constructor(private router:Router) { }

  ngOnInit() {
    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    }

    let board = null;
    let game = new Chess();

    // do not pick up pieces if the game is over
    let onDragStart = function(source, piece, position, orientation) {
      if (game.in_checkmate() === true || game.in_draw() === true ||
        piece.search(/^b/) !== -1) {
        return false;
      }
    };

    let makeRandomMove = function() {
      let possibleMoves = game.moves();

      // game over
      if (possibleMoves.length === 0) return;

      let randomIndex = Math.floor(Math.random() * possibleMoves.length);
      game.move(possibleMoves[randomIndex]);
      board.position(game.fen());
    };

    let onDrop = function(source, target) {
      // see if the move is legal
      let move = game.move({
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
    let onSnapEnd = function() {
      board.position(game.fen());
    };

    let cfg = {
      draggable: true,
      flippable: true,
      position: 'start',
      onDragStart: onDragStart,
      onDrop: onDrop,
      onSnapEnd: onSnapEnd,
      pieceTheme: "http://chessboardjs.com/img/chesspieces/wikipedia/{piece}.png"
    };

    let isLive = document.getElementById('board');
    if(isLive === null) {}
    else { this.board = new ChessBoard('board', cfg); board = this.board; }
  }

  flipBoard() {
    this.board.flip();
  }

  startNewGame() {
    location.reload();
  }
}
