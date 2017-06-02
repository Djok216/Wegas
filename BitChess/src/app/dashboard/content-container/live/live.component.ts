import {Component, OnInit} from '@angular/core';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router';

declare const GameChess: any;

@Component({
  selector: 'app-live',
  templateUrl: './live.component.html',
  styleUrls: ['./live.component.css']
})

export class LiveComponent implements OnInit {

  constructor(private router: Router) {
  }

  ngOnInit() {
    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    }

    const Game = new GameChess();
  }
}
