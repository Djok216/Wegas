import {Injectable} from '@angular/core';
import {Http, Headers} from '@angular/http';
import {sha256} from 'sha256';
import 'rxjs/add/operator/map';
/**
 * Created by BlackDeathM8 on 11-Apr-17.
 */

@Injectable()
export class LoginService {
  constructor(private _http: Http) {
  }

  sendLogin(username: string, password: string) {
    password = sha256(password);
    console.log(username, password);
    const body = { username: username, password: password};
    const headers = new Headers();
    headers.append('Content-Type', 'application/json');
    return this._http.post('http://localhost:4500/user/login' , JSON.stringify(body), {headers: headers})
      .map(res => res.json());
  }
}
