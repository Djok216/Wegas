import { Component} from '@angular/core';
import {RegisterService} from "./register.service";

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
  providers: [RegisterService]
})
export class RegisterComponent {
  public username : string;
  public password : string;
  public confirm_password : string;
  public email : string;

  constructor(private _RegisterService : RegisterService) { }

  onRegisterClick() {}
}
