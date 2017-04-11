import { Component} from '@angular/core';
import {RegisterService} from "./register.service";

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
  providers: [RegisterService]
})
export class RegisterComponent {
  public answer : string;

  constructor(private _RegisterService : RegisterService) { }

  onRegisterClick(username: string, pass: string, confPass: string, email: string) {
    this._RegisterService.userRegister(username, pass, confPass, email)
      .subscribe(
        data => this.answer = JSON.stringify(data).replace(/\"/g, ""),
        error => alert(error),
        () => console.log("Finished")
      )
  }
}
