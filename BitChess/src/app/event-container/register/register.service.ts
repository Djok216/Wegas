import {Injectable} from "@angular/core";
import {Http, Headers} from "@angular/http";
import 'rxjs/add/operator/map';
/**
 * Created by BlackDeathM8 on 11-Apr-17.
 */

@Injectable()
export class RegisterService {
  public answer: string;

  constructor (private _http: Http) {}

  userRegister(username: string, pass: string, confPass: string, email: string) {
    var body = username + ' ' + pass + ' ' + confPass + ' ' + email;
    var headers = new Headers();
    headers.append('Content-Type', 'application/x-www-form-urlencoded');
    return this._http.post('http://localhost:8181/public/user/register',body, {headers: headers}).map(res => res.json());
  }
}
