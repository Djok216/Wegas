import {Component, OnInit, Injectable, NgModule} from '@angular/core';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router';
import {BackendService} from '../../../BackendService/backend.service';
import {MdSnackBar} from '@angular/material';
import {JwtHelper } from 'angular2-jwt';

import 'rxjs/add/operator/map';
import { PagerService } from './_service/index';


@Component({
  selector: 'app-clubs',
  templateUrl: './clubs.component.html',
  styleUrls: ['./clubs.component.css']
})

export class ClubsComponent implements OnInit {
  generalStatistic: any = [];
  answer : string;
  jwtHelper: JwtHelper = new JwtHelper();
  // pager object
  pager: any = {};
  // paged items
  pagedItems: any[];

  constructor(private backendService: BackendService, private router: Router, public snackBar: MdSnackBar, private pagerService: PagerService) {
  }

  setPage(page: number) {
    if (page < 1 || page > this.pager.totalPages) {
      return;
    }

    // get pager object from service
    this.pager = this.pagerService.getPager(this.generalStatistic.length, page);

    // get current page of items
    this.pagedItems = this.generalStatistic.slice(this.pager.startIndex, this.pager.endIndex + 1);
  }

  ngOnInit() {
    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    } else {
      this.backendService.getClubStatisticGeneral(Cookie.get('sessionId'))
        .subscribe(
          data => {
            this.generalStatistic = JSON.parse(JSON.stringify(data));
            this.setPage(1);
          },
          error => {
            let json = JSON.parse(JSON.stringify(error))['_body'];
            this.snackBar.open(json, "", {
              duration: 2000,
            })
          }
        );
    }
  }

  onSubscribeClick(club_name: string, user_name: string) {
    this.backendService.registerUserToClub(Cookie.get('sessionId'), club_name, this.jwtHelper.decodeToken(Cookie.get('sessionId')).username)
      .subscribe(
        data => {
          let jsonParsed = JSON.parse(JSON.stringify(data));
          this.answer = jsonParsed['responseMessage'];
        },
        error => {
          let json = JSON.parse(JSON.stringify(error))['_body'];
          this.snackBar.open(json, "", {
            duration: 2000,
          })
        },
        () => this.snackBar.open(this.answer, "", {
          duration: 2000,
        })
      )
  }
}


