import {Component, OnInit, Injectable} from '@angular/core';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from "@angular/router";
import {BackendService} from "../../../BackendService/backend.service";
import {MdSnackBar} from "@angular/material";


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
    }
    else {
      this.backendService.getClubStatisticGeneral(Cookie.get('sessionId'))
        .subscribe(
          data => {
            let jsonParsed = JSON.parse(JSON.stringify(data));
            this.generalStatistic = jsonParsed;
            console.log(this.generalStatistic);
          },
          error => console.log('Error at getClubsStatisticGeneral.')
        )
    }
  }
}
