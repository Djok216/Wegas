import {Component, OnInit} from '@angular/core';
import {LoginService} from "./login.service";
import {MdSnackBar} from '@angular/material';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router'

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
  providers: [LoginService]
})
export class LoginComponent implements OnInit {
  answer: string;
  username: string;
  password: string;
  token: string;

  constructor(private _loginService: LoginService, public snackBar: MdSnackBar, private router: Router) {
  }

  ngOnInit() {
    if (Cookie.get('sessionId') != null)
      this.router.navigateByUrl('');
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
          this.token =  JSON.parse(JSON.stringify(data))['token'];
          if (this.token != null) {
            console.log(this.token);
            this.answer = "Login success!";
            localStorage.setItem('currentUser', this.token);
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
