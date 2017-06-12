/**
 * Created by BlackDeathM8 on 02-Jun-17.
 */
import {Injectable} from '@angular/core';
import {Http, Headers} from '@angular/http';

@Injectable()
export class BackendService {
  private username: string;

  constructor(private http: Http) {
  }

  setUsername(username: string) {
    this.username = username;
  }

  getUsername() {
    return this.username;
  }

  logoutUser(token: string) {
    const header = new Headers();
    header.append('Authorization', token);

    const json = JSON.stringify({});
    return this.http.post('http://localhost:4500/user/logout', json, {headers: header}).map(res => res.json());
  }

  getClubStatisticGeneral(token: string) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/clubs/statistics/general', {headers: header}).map(res => res.json());
  }

  getThreadsName(token: string) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/AllThreads', {headers: header}).map(res => res.json());
  }

  registerUserToClub(token: string, club_name: string, user_name: string) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    const json = JSON.stringify({memberName: user_name});
    return this.http.post('http://localhost:4500/clubs/' + club_name + '/addMember', json, {headers: header}).map(res => res.json());
  }

  getUserInfo(token: string) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/profile', {headers: header}).map(res => res.json());
  }

  getThreadsByCategory(token: string) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/stats/categoriesstats', {headers: header}).map(res => res.json());
  }

  getTopActive(token: string) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/stats/topactive', {headers: header}).map(res => res.json());
  }

  getTopDiscussed(token: string) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/stats/topdiscussed', {headers: header}).map(res => res.json());
  }

  getNrUsers(token: string) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/stats/nrofusers', {headers: header}).map(res => res.json());
  }

  getGamesToday(token: string) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/stats/1', {headers: header}).map(res => res.json());
  }

  getGamesWeek(token: string) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/stats/7', {headers: header}).map(res => res.json());

  }


  getThreadsNameByCategory(token: string, categoryId: number) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/getThreadByCategory/' + categoryId, {headers: header}).map(res => res.json());
  }

  getAllCategories(token: string) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/Allcategory', {headers: header}).map(res => res.json());
  }

  getComments(token: string, categoryId: number, threadId: number) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500/' + categoryId + '/' + threadId + '/getPostByThread', {headers: header}).map(res => res.json());
  }
}


