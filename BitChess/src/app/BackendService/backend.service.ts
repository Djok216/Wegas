/**
 * Created by BlackDeathM8 on 02-Jun-17.
 */
import {Injectable} from "@angular/core";
import {Http, Headers} from "@angular/http";

@Injectable()
export class BackendService {
  private username : string;

  constructor(private http: Http) {
  }

  setUsername(username : string){
    this.username = username;
  }

  getUsername() {
    return this.username;
  }

  getClubStatisticGeneral(token: string) {
    let header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/clubs/statistics/general', {headers: header}).map(res => res.json());
  }
  
  getThreadsName(token: string){
    let header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/AllThreads', { headers: header }).map(res => res.json());
  }

  registerUserToClub(token: string, club_name: string, user_name: string) {
    let header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    let json = JSON.stringify({ memberName: user_name });
    return this.http.post('http://localhost:4500/clubs/' + club_name + '/addMember', json, { headers: header }).map(res => res.json());
  }

  getUserInfo(token: string) {
    let header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/profile', { headers: header }).map(res => res.json());
  }
}


