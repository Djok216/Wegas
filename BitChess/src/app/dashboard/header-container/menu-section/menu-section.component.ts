import { Component, OnInit } from '@angular/core';
import {Router} from "@angular/router";
@Component({
  selector: 'app-menu-section',
  templateUrl: 'menu-section.component.html',
  styleUrls: ['menu-section.component.css']
})
export class MenuSectionComponent implements OnInit {
  constructor(private router: Router) { }

  ngOnInit() {
  }

  changeRoute(name: string) {
    this.router.navigateByUrl("/" + name);
  }
}
