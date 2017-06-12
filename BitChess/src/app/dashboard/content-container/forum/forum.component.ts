import {Component, OnInit} from '@angular/core';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router';
import {BackendService} from '../../../BackendService/backend.service';
import {MdSnackBar} from '@angular/material';

@Component({
  selector: 'app-forum',
  templateUrl: './forum.component.html',
  styleUrls: ['./forum.component.css']
})
export class ForumComponent implements OnInit {
  currentThreadId: number;
  currentCategoryId: number;
  currentThread: any;
  comments: any = [];
  selectedCategory = false;
  wtfThread: any = [];

  constructor(private backendService: BackendService, private router: Router, public snackBar: MdSnackBar) {
  }

  ngOnInit() {
    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    }
  }

  public onCategoryClicked(categoryId: number) {
    this.selectedCategory = true;
    this.currentCategoryId = categoryId;
    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    } else {
      this.backendService.getThreadsNameByCategory(Cookie.get('sessionId'), categoryId)
        .subscribe(
          data => this.wtfThread = JSON.parse(JSON.stringify(data['thread'])),
          error => console.log('Error FORUM.')
        );
    }
  }

  public onThreadClicked(thread: any) {
    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    } else {
      this.currentThreadId = thread.id;
      this.currentThread = thread;
      this.backendService.getComments(Cookie.get('sessionId'), this.currentCategoryId, this.currentThreadId)
        .subscribe(
          data => this.comments = JSON.parse(JSON.stringify(data['posts'])),
          error => console.log('Error FORUM.')
        );
    }
  }


  public hahahahha() {
    return 'afsasf';
  }

}

