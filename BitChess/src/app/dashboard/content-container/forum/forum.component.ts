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
  currentThreadDescription: string;
  currentThreadName: string;
  comments: any = [];
  selectedCategory = false;
  wtfThread: any = [];
  currentThreadUser: string;

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
      this.currentThreadDescription = thread.description;
      this.currentThreadName = thread.name;
      this.currentThread = thread;
      this.currentThreadUser = thread.userName;
      this.backendService.getComments(Cookie.get('sessionId'), this.currentCategoryId, this.currentThreadId)
        .subscribe(
          data => this.comments = JSON.parse(JSON.stringify(data['posts'])),
          error => console.log('Error FORUM.')
        );
    }
  }

  public onAddComentClick(mesaj: string) {
    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    } else {
      this.backendService.addComment(Cookie.get('sessionId'), this.currentCategoryId, this.currentThreadId, mesaj).subscribe(
        error => console.log('Érroororo')
      );
    }
  }


  public hahahahha() {
    return 'afsasf';
  }

}

