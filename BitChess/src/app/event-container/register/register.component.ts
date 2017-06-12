import {Component, NgModule, OnInit} from '@angular/core';
import {RegisterService} from './register.service';
import {MdSnackBar} from '@angular/material';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router';
import {sha256} from 'sha256';
import {FormGroup, FormBuilder, Validators} from '@angular/forms';
import {FacebookModule, FacebookService, InitParams, LoginResponse} from 'ngx-facebook';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
  providers: [RegisterService, FacebookService]
})

@NgModule({
  imports: [
    FacebookModule.forRoot()
  ],
})

export class RegisterComponent implements OnInit {
  registerForm: FormGroup;
  public answer: string;
  public token: string;


  constructor(private _RegisterService: RegisterService, private fb: FacebookService, public snackBar: MdSnackBar, private router: Router, form: FormBuilder) {
    this.registerForm = form.group({
      'nickname': [null, Validators.compose([Validators.required, Validators.minLength(5), Validators.maxLength(100)])],
      'password': [null, Validators.compose([Validators.required, Validators.minLength(8), Validators.maxLength(50)])],
      'confirmed_password': [null, Validators.compose([Validators.required, Validators.minLength(8), Validators.maxLength(50)])],
      'email': [null, Validators.required]
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

  onRegisterClick(username: string, pass: string, confPass: string, email: string) {
    this._RegisterService.userRegister(username, pass, confPass, email)
      .subscribe(
        data => this.answer = JSON.parse(JSON.stringify(data))['responseMessage'],
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
          .then(res => res = JSON.stringify(res))
          .then(
            res => {
              const facebookId: string = JSON.parse(res)['id'];
              const email: string = JSON.parse(res)['email'];
              const name: string = JSON.parse(res)['name'];
              this._RegisterService.sendFacebookInfo(facebookId, email, name)
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
