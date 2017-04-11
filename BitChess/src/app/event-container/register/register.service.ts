import {Injectable} from "@angular/core";
import {Http} from "@angular/http";
import 'rxjs/add/operator/map';
/**
 * Created by BlackDeathM8 on 11-Apr-17.
 */

@Injectable()
export class RegisterService {
  constructor (private _http: Http) {}

  userRegister() {
    return this._http.get('http://date.jsontest.com').map(res => res.json());
  }

}
