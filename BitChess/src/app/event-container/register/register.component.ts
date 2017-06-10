import {Component, OnInit} from '@angular/core';
import {RegisterService} from './register.service';
import {MdSnackBar} from '@angular/material';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router';
import {sha256} from 'sha256';
import {FormGroup, FormBuilder, Validators} from '@angular/forms';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
  providers: [RegisterService]
})
export class RegisterComponent implements OnInit {
  registerForm: FormGroup;
  public answer: string;

  constructor(private _RegisterService: RegisterService, public snackBar: MdSnackBar, private router: Router, form: FormBuilder) {
    this.registerForm = form.group({
      'nickname': [null, Validators.compose([Validators.required, Validators.minLength(5), Validators.maxLength(100)])],
      'password': [null, Validators.compose([Validators.required, Validators.minLength(8), Validators.maxLength(50)])],
      'confirmed_password': [null, Validators.compose([Validators.required, Validators.minLength(8), Validators.maxLength(50)])],
      'email': [null, Validators.required]
    });
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

  facebookRegister() {
  }
}
