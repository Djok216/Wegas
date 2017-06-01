import {Component, OnDestroy, HostListener, OnInit} from '@angular/core';
import {Cookie} from 'ng2-cookies/ng2-cookies';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  title = 'BitChess!';

  ngOnInit() {
    let token = Cookie.get('sessionId');
    if (token != null) {
      Cookie.delete('sessionId');
      Cookie.set('sessionId', token);
    }
  }

  @HostListener('window:beforeunload', ['$event'])
  beforeUnloadHander(event) {
    let token = Cookie.get('sessionId');
    if (token != null) {
      Cookie.delete('sessionId');
      // o zi o impart la 24 de ore si imi da o ora, si apoi impart la 2 si da jumatate de ora.
      Cookie.set('sessionId', token, 1 / 24 / 60);
    }
  }
}
