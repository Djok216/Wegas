import {Component, OnInit, Injectable} from '@angular/core';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router';
import {BackendService} from '../../../BackendService/backend.service';
import {MdSnackBar} from '@angular/material';
import {applySourceSpanToStatementIfNeeded} from "@angular/compiler/src/output/output_ast";

@Component({
  selector: 'app-clubs',
  templateUrl: './clubs.component.html',
  styleUrls: ['./clubs.component.css']
})
export class ClubsComponent implements OnInit {
  generalStatistic: any = [];

  constructor(private backendService: BackendService, private router: Router, public snackBar: MdSnackBar) {
  }

  ngOnInit() {
    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    } else {
      this.backendService.getClubStatisticGeneral(Cookie.get('sessionId'))
        .subscribe(
          data => this.generalStatistic = JSON.parse(JSON.stringify(data)),
          error => console.log('Error at getClubsStatisticGeneral.')
        );
    }
  }
}


