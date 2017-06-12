

import {Component, OnInit} from '@angular/core';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router';
import {BackendService} from '../../../BackendService/backend.service';
import {MdSnackBar} from '@angular/material';

@Component({
  selector: 'app-stats',
  templateUrl: './stats.component.html',
  styleUrls: ['./stats.component.css']
})
export class StatsComponent implements OnInit {

  categories: any = [];
  topactive: any = [];
  topdiscussed: any = [];
  nrmembers: string;
  gamestoday: string;
  gamesweek: string;

  constructor(private backendService: BackendService, private router: Router, public snackBar: MdSnackBar) {}

  ngOnInit() {
    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    } else {
      this.backendService.getThreadsByCategory(Cookie.get('sessionId'))
        .subscribe(
          data => this.categories = JSON.parse(JSON.stringify(data['lista'])),
          error => console.log('Error FORUM.')
        );
      this.backendService.getTopActive(Cookie.get('sessionId'))
        .subscribe(
          data => this.topactive = JSON.parse(JSON.stringify(data['lista'])),
          error => console.log('Error FORUM.')
        );
      this.backendService.getTopDiscussed(Cookie.get('sessionId'))
        .subscribe(
          data => this.topdiscussed = JSON.parse(JSON.stringify(data['lista'])),
          error => console.log('Error FORUM.')
        );
      this.backendService.getNrUsers(Cookie.get('sessionId'))
        .subscribe(
          data => this.nrmembers = JSON.parse(JSON.stringify(data)),
          error => console.log('Error FORUM.')
        );
      this.backendService.getGamesToday(Cookie.get('sessionId'))
        .subscribe(
          data => this.gamestoday = JSON.parse(JSON.stringify(data)),
          error => console.log('Error FORUM.')
        );
      this.backendService.getGamesWeek(Cookie.get('sessionId'))
        .subscribe(
          data => this.gamesweek = JSON.parse(JSON.stringify(data)),
          error => console.log('Error FORUM.')
        );
    }
  }
}
