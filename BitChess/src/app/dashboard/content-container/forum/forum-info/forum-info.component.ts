import { Component, OnInit } from '@angular/core';
import {BackendService} from '../../../../BackendService/backend.service';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {MdSnackBar} from '@angular/material';
import {ForumComponent} from '../forum.component';
import {Router} from '@angular/router';

@Component({
  selector: 'app-forum-info',
  templateUrl: './forum-info.component.html',
  styleUrls: ['./forum-info.component.css']
})
export class ForumInfoComponent implements OnInit {
  categories: any = [];
  constructor(private backendService: BackendService, private router: Router, public snackBar: MdSnackBar,
              public parent2: ForumComponent) {
  }

  ngOnInit() {
    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    } else {
      this.backendService.getAllCategories(Cookie.get('sessionId'))
        .subscribe(
          data => {
            console.log(data);
            console.log(JSON.parse(JSON.stringify(data))['category']);
            this.categories = JSON.parse(JSON.stringify(data))['category'];
          },
          error => console.log('Error FORUM.')
        );
    }
  }

}
