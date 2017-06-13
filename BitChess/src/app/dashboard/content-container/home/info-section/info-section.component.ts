import { Component, OnInit } from '@angular/core';
import {MdSnackBar} from "@angular/material";
import {Router} from "@angular/router";
import {BackendService} from "../../../../BackendService/backend.service";
import {Cookie} from 'ng2-cookies/ng2-cookies';

@Component({
  selector: 'app-info-section',
  templateUrl: 'info-section.component.html',
  styleUrls: ['info-section.component.css']
})
export class InfoSectionComponent implements OnInit {
  answer: any;

  constructor(private backendService: BackendService, private router: Router, public snackBar: MdSnackBar) {
  }

  ngOnInit() {
  }

  onFindUserClick(stringMatch: string) {
    console.log(stringMatch);
    this.backendService.getUsersByStringMatch(Cookie.get('sessionId'), stringMatch)
      .subscribe(
        data => {
          let jsonParsed = JSON.parse(JSON.stringify(data));
          this.answer = jsonParsed;
          console.log(this.answer);
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
