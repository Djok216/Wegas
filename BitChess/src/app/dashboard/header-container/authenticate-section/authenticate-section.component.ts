import {Component, OnInit} from '@angular/core';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {BackendService} from "../../../BackendService/backend.service";
import {MdSnackBar} from "@angular/material";
import {Router} from "@angular/router";
@Component({
  selector: 'app-authenticate-section',
  templateUrl: './authenticate-section.component.html',
  styleUrls: ['./authenticate-section.component.css']
})
export class AuthenticateSectionComponent implements OnInit {
  response : string;

  constructor(private backendService : BackendService, public snackBar: MdSnackBar,  private router: Router) {
  }

  ngOnInit() {
  }

  userlogout() {
    this.backendService.logoutUser(Cookie.get('sessionId'))
      .subscribe(
        data => {
          this.response =  JSON.parse(JSON.stringify(data))['responseMessage'];
          Cookie.delete('sessionId');
          this.router.navigateByUrl('login');
        },
        error => {
          let json = JSON.parse(JSON.parse(JSON.stringify(error))['_body'])["responseMessage"];
          Cookie.delete('sessionId');
          this.router.navigateByUrl('login');
          this.snackBar.open(json, "", {
            duration: 2000,
          })
        },
        () => this.snackBar.open(this.response, "", {
          duration: 2000,
        })
      );
  }

  cookieExists() {
    return Cookie.get('sessionId') == null;
  }
}
