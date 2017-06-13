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

  getUsersByStringMatch(token: string, stringMatch : string) {
    const header = new Headers();
    header.append('Authorization', token);

    return this.http.get('http://localhost:4500//findUsers/string_match="' + stringMatch + '"', {headers: header}).map(res => res.json());
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

  addComment(token: string, category: number, thread: number, mesaj: string) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);
    const json = JSON.stringify({
      content: mesaj
    });
    console.log(json);
    const link = 'http://localhost:4500/' + category + '/' + thread + '/addpost';
    console.log(link);
    return this.http.post(link, json, {headers: header})
      .map(res => res.json());

  }

  addThread(token: string, category: number, mesaj1: string, mesaj2: string) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);
    console.log(mesaj2);
    const json = JSON.stringify({
      name: mesaj1,
      description: mesaj2
    });

    const link = 'http://localhost:4500/' + category + '/AddThread';
    return this.http.post(link, json, {headers: header})
      .map(res => res.json());

  }
  deleteComment(token: string, category: number, thread: number, mesajId: number) {
    const header = new Headers();
    header.append('Content-Type', 'application/json');
    header.append('Authorization', token);

    const link = 'http://localhost:4500/' + category + '/' + thread + '/deletePost/' + mesajId;
    return this.http.delete(link, {headers: header})
      .map(res => res.json());
  }
}


