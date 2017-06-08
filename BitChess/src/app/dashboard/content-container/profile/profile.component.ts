import {Component, OnInit, AfterContentChecked, AfterViewInit} from '@angular/core';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router'
import {BackendService} from "../../../BackendService/backend.service";

@Component({
  selector: 'app-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css']
})
export class ProfileComponent implements OnInit, AfterViewInit {
  userInfo : any = JSON.parse(JSON.stringify({
    "email": "default",
    "nickname": "default",
    "name": "default",
    "createdAt": "default",
    "status": "default",
    "clubName": "default",
    "wins": 0,
    "loses": 0,
    "draws": 0
  }));
  constructor(private router: Router, private backendSerivice: BackendService) { }

  ngOnInit() {
    if (Cookie.get('sessionId') == null)
      this.router.navigateByUrl('');
  }

  ngAfterViewInit() {
    this.backendSerivice.getUserInfo(Cookie.get('sessionId'))
      .subscribe(
        data => {
          this.userInfo =  JSON.parse(JSON.stringify(data));
        }
      );
  }

  capitalize(value:any) {
    if (value) {
      return value.charAt(0).toUpperCase() + value.slice(1);
    }
    return value;
  }
}
