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
    var body = { username: username, password: pass, email : email};
    var headers = new Headers();
    headers.append('Content-Type', 'application/json');
    return this._http.post('http://localhost:4500/user/register',JSON.stringify(body), {headers: headers}).map(res => res.json());
  }

}
