
import {Component, OnInit} from '@angular/core';
import {Cookie} from 'ng2-cookies/ng2-cookies';
import {Router} from '@angular/router';
import {BackendService} from '../../../BackendService/backend.service';
import {MdSnackBar} from '@angular/material';

@Component({
  selector: 'app-stats',
  templateUrl: './stats.component.html',
  styleUrls: ['./stats.component.css']
})
export class StatsComponent implements OnInit {

  categories: any = [];

  constructor(private backendService: BackendService, private router: Router, public snackBar: MdSnackBar) {}

  ngOnInit() {
    if (Cookie.get('sessionId') == null) {
      this.router.navigateByUrl('/login');
    } else {
      this.backendService.getThreadsByCategory(Cookie.get('sessionId'))
        .subscribe(
          data => this.categories = JSON.parse(JSON.stringify(data['lista'])),
          error => console.log('Error FORUM.')
        );
    }
  }
}
