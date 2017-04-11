import { Component } from '@angular/core';
import {LoginService} from "./login.service";

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
  providers: [LoginService]
})
export class LoginComponent{
  getData : string;
  username : string;
  password : string;

  constructor(private _loginService : LoginService) { }

  updateUsername(username : string) {
    this.username = username;
  }

  updatePassword(password : string) {
    this.password = password;
  }

  onLoginClick(current_username : string, current_password : string) {
    this._loginService.sendLogin(current_username, current_password)
      .subscribe(
        data => this.getData = JSON.stringify(data),
        error => alert(error),
        () => console.log("Finished")
      )
  }
}
