import {Component, OnInit} from '@angular/core';
import {LoginService} from "./login.service";
import {MdSnackBar} from '@angular/material';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router'
import {FormGroup, FormBuilder, Validators} from '@angular/forms';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
  providers: [LoginService]
})
export class LoginComponent implements OnInit {
  loginForm : FormGroup;
  answer: string;
  token: string;

  constructor(private _loginService: LoginService, public snackBar: MdSnackBar, private router: Router, form: FormBuilder) {
    this.loginForm = form.group({
      'nickname' : [null, Validators.required],
      'password' : [null, Validators.required]
    })
  }

  ngOnInit() {
    if (Cookie.get('sessionId') != null)
      this.router.navigateByUrl('');
  }

  onLoginClick(current_username: string, current_password: string) {
    this._loginService.sendLogin(current_username, current_password)
      .subscribe(
        data => {
          this.token =  JSON.parse(JSON.stringify(data))['token'];
          if (this.token != null) {
            this.answer = "Login success!";
            Cookie.set('sessionId', this.token);
            this.router.navigateByUrl('');
          }
          else this.answer = "Login failed!";
        },
        error => alert(error),
        () => this.snackBar.open(this.answer, "", {
          duration: 2000,
        })
      );
  }
}
