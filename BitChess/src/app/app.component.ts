import {Component, OnDestroy, HostListener, OnInit} from '@angular/core';
import { Cookie } from 'ng2-cookies/ng2-cookies';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit{
  title = 'BitChess!';

  ngOnInit() {
    var token = Cookie.get('sessionId');
    if(token != null) {
      Cookie.delete('sessionId');
      Cookie.set('sessionId', token);
    }
  }

  @HostListener('window:beforeunload', [ '$event' ])
   beforeUnloadHander(event) {
    var token = Cookie.get('sessionId');
    if(token != null) {
      Cookie.delete('sessionId');
      Cookie.set('sessionId', token, 0.00138889);
    }
  }
}
