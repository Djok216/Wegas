import {Component, OnInit} from '@angular/core';
import {Cookie} from 'ng2-cookies/ng2-cookies';
@Component({
  selector: 'app-authenticate-section',
  templateUrl: './authenticate-section.component.html',
  styleUrls: ['./authenticate-section.component.css']
})
export class AuthenticateSectionComponent implements OnInit {

  constructor() {
  }

  ngOnInit() {
  }

  cookieExists() {
    return Cookie.get('sessionId') == null;
  }
}
