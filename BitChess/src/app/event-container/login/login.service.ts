import {Injectable} from '@angular/core';
import {Http, Headers} from '@angular/http';
import {hex_sha1} from 'crypto/sha1.js';
import 'rxjs/add/operator/map';
/**
 * Created by BlackDeathM8 on 11-Apr-17.
 */

@Injectable()
export class LoginService {
  constructor(private _http: Http) {
  }

  sendLogin(username: string, password: string) {
    password = hex_sha1(password);
    const body = { username: username, password: password};
    const headers = new Headers();
    headers.append('Content-Type', 'application/json');
    return this._http.post('http://localhost:4500/user/login' , JSON.stringify(body), {headers: headers})
      .map(res => res.json());
  }

  sendFacebookInfo(facebookId: string, email: string, name: string) {
    const body = {facebookId: facebookId, email: email, name: name};
    const headers = new Headers();
    headers.append('Content-Type', 'application/json');
    return this._http.post('http://localhost:4500/user/loginFB', JSON.stringify(body), {headers: headers}).map(res => res.json());
  }
}
