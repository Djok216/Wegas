/**
 * Created by BlackDeathM8 on 02-Jun-17.
 */
import { Injectable } from "@angular/core";
import { Http, Headers } from "@angular/http";

@Injectable()
export class BackendService {
  constructor(private http : Http) {}

  getClubStatisticGeneral(token: string){
    let header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/clubs/statistics/general', { headers: header }).map(res => res.json());
  }

}
