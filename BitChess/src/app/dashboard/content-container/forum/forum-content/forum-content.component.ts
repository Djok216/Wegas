import { Component, OnInit } from '@angular/core';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router';
import {MdSnackBar} from '@angular/material';
import {BackendService} from '../../../../BackendService/backend.service';
import {ForumComponent} from '../forum.component';


@Component({
  selector: 'app-forum-content',
  templateUrl: './forum-content.component.html',
  styleUrls: ['./forum-content.component.css']
})

export class ForumContentComponent implements OnInit {

  constructor(private backendService: BackendService, private router: Router, public snackBar: MdSnackBar,
              public parent1: ForumComponent) { }

  ngOnInit() {
    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    }
  }
}
