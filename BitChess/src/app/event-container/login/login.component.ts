import {Component, NgModule, OnInit} from '@angular/core';
import {LoginService} from './login.service';
import {MdSnackBar} from '@angular/material';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router';
import {FormGroup, FormBuilder, Validators} from '@angular/forms';
import {FacebookModule, FacebookService, InitParams, LoginResponse} from 'ngx-facebook';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
  providers: [LoginService, FacebookService]
})

@NgModule({
  imports: [
    FacebookModule.forRoot()
  ],
})

export class LoginComponent implements OnInit {
  loginForm: FormGroup;
  answer: string;
  token: string;

  constructor(private _loginService: LoginService, private fb: FacebookService, public snackBar: MdSnackBar, private router: Router, form: FormBuilder) {
    this.loginForm = form.group({
      'nickname': [null, Validators.required],
      'password': [null, Validators.required]
    });

    const initParams: InitParams = {
      appId: '432359763790011',
      xfbml: true,
      version: 'v2.9'
    };

    fb.init(initParams);
  }

  ngOnInit() {
    if (Cookie.get('sessionId') != null) {
      this.router.navigateByUrl('');
    }
  }

  onLoginClick(current_username: string, current_password: string) {
    this._loginService.sendLogin(current_username, current_password)
      .subscribe(
        data => {
          this.token = JSON.parse(JSON.stringify(data))['token'];
          if (this.token != null) {
            this.answer = 'Login success!';
            Cookie.set('sessionId', this.token);
            this.router.navigateByUrl('');
          } else {
            this.answer = 'Login failed!';
          }
        },
        error => alert(error),
        () => this.snackBar.open(this.answer, '', {
          duration: 2000,
        })
      );
  }

  facebookLoginButt() {
    this.fb.login()
      .then((response: LoginResponse) => {
        this.fb.api('/me?fields=id,name,email,permissions')
          .then(
            res => {
              let facebookId : string = res.id;
              let email : string = res.email;
              let name : string = res.name;
              this._loginService.sendFacebookInfo(facebookId, email, name)
                .subscribe(
                  data => {
                    this.token = JSON.parse(JSON.stringify(data))['token'];
                    if (this.token != null) {
                      this.answer = 'Login success!';
                      Cookie.set('sessionId', this.token);
                      this.router.navigateByUrl('');
                    } else {
                      this.answer = 'Login failed!';
                    }
                  },
                  error => alert(error),
                  () => this.snackBar.open(this.answer, '', {
                    duration: 2000,
                  })
                );
            }
          )
          .catch(e => console.error(e));
      })
      .catch((error: any) => console.error(error));
  }
}
