import { Component } from '@angular/core';
import {LoginService} from "./login.service";

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
  providers: [LoginService]
})
export class LoginComponent{
  answer : string;
  psgbd : string;
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
        data => this.answer = JSON.stringify(data).replace(/\"/g, ""),
        error => alert(error),
        () => console.log("Finished")
      )
  }

  onShitClick(number: string) {
    this._loginService.sendNumber(number)
      .subscribe(
        data => this.psgbd = JSON.stringify(data).replace(/\"/g, ""),
        error => alert(error),
        () => console.log("Finished")
      )
  }
}
