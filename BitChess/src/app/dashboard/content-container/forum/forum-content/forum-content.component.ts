import { Component, OnInit } from '@angular/core';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router';
import {MdSnackBar} from '@angular/material';
import {BackendService} from '../../../../BackendService/backend.service';


@Component({
  selector: 'app-forum-content',
  templateUrl: './forum-content.component.html',
  styleUrls: ['./forum-content.component.css']
})

export class ForumContentComponent implements OnInit {
  wtfThread: any = [];
  private Cookie: any;

  constructor(private backendService: BackendService, private router: Router, public snackBar: MdSnackBar) { }

  ngOnInit() {
    if (this.Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    } else {
      this.backendService.getThreadsName(Cookie.get('sessionId'))
        .subscribe(
          data => this.wtfThread = JSON.parse(JSON.stringify(data['thread'])),
          error => console.log('Error FORUM.')
        );
    }
  }
}
