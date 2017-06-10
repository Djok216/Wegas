import { Component, OnInit } from '@angular/core';
import { Cookie } from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router';
import {BackendService} from '../../../BackendService/backend.service';
import {MdSnackBar} from '@angular/material';

@Component({
  selector: 'app-forum',
  templateUrl: './forum.component.html',
  styleUrls: ['./forum.component.css']
})
export class ForumComponent implements OnInit {
  wtfThread: any = [];
  selectedCategory = false;
  constructor(private backendService: BackendService, private router: Router, public snackBar: MdSnackBar) { }

  ngOnInit() {
    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    } else {
      this.backendService.getThreadsName(Cookie.get('sessionId'))
        .subscribe(
          data => this.wtfThread = JSON.parse(JSON.stringify(data['thread'])),
          error => console.log('Error FORUM.')
        );
    }
  }

  public onCategoryClicked(categoryId: number) {

    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    } else {
      this.backendService.getThreadsNameByCategory(Cookie.get('sessionId'), categoryId)
        .subscribe(
          data => this.wtfThread = JSON.parse(JSON.stringify(data['thread'])),
          error => console.log('Error FORUM.')
        );
      this.selectedCategory = true;
    }
  }

  public hahahahha() {
    return 'afsasf';
  }

}

