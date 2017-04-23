import {Injectable} from "@angular/core";
import {Http, Headers} from "@angular/http";
import 'rxjs/add/operator/map';
/**
 * Created by BlackDeathM8 on 11-Apr-17.
 */

@Injectable()
export class LoginService {
  constructor(private _http: Http) {
  }

  sendLogin(username: string, password: string) {
    console.debug(username, password);
    var body = username + ' ' + password;
    //var body2 = { username: 'morena', pass: 'sticulta'};
    var headers = new Headers();
    headers.append('Content-Type', 'application/x-www-form-urlencoded');
    return this._http.post('http://localhost:8181/public/user/login',body,{headers: headers})
      .map(res => res.json());
  }
}
