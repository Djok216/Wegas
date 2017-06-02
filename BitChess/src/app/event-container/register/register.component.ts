import {Component, OnInit} from '@angular/core';
import {RegisterService} from "./register.service";
import {MdSnackBar} from '@angular/material';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from "@angular/router";

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
  providers: [RegisterService]
})
export class RegisterComponent implements OnInit {
  public answer: string;

  constructor(private _RegisterService: RegisterService, public snackBar: MdSnackBar, private router: Router) {
  }

  ngOnInit() {
    if (Cookie.get('sessionId') != null) {
      this.router.navigateByUrl('');
    }
  }

  onRegisterClick(username: string, pass: string, confPass: string, email: string) {
    this._RegisterService.userRegister(username, pass, confPass, email)
      .subscribe(
        data => this.answer = JSON.stringify(data).replace(/\"/g, ''),
        error => alert(error),
        () => this.snackBar.open(this.answer, '', {
          duration: 2000,
        })
      );
  }

  facebookRegister() {
  }
}
