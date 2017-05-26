import {Component, OnInit} from '@angular/core';
import {LoginService} from "./login.service";
import {MdSnackBar} from '@angular/material';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
  providers: [LoginService]
})
export class LoginComponent {
  answer: string;
  username: string;
  password: string;
  token: string;

  constructor(private _loginService: LoginService, public snackBar: MdSnackBar) {
  }

  updateUsername(username: string) {
    this.username = username;
  }

  updatePassword(password: string) {
    this.password = password;
  }

  onLoginClick(current_username: string, current_password: string) {
    this._loginService.sendLogin(current_username, current_password)
      .subscribe(
        data => {
          this.answer = JSON.stringify(data['responseMessage']).replace(/\"/g, "");
          this.token = JSON.stringify(data['token']);
          localStorage.setItem('currentUser', this.token);
        },
        error => alert(error),
        () => this.snackBar.open(this.answer, "", {
          duration: 2000,
        })
      );
  }
}
