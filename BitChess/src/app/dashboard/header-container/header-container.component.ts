import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-header-container',
  templateUrl: 'header-container.component.html',
  styleUrls: ['header-container.component.css']
})
export class HeaderContainerComponent implements OnInit {
  showProfile : boolean = Math.random() >= 0.5;
  showAuthentificateSection : boolean = !this.showProfile;
  constructor() { }

  ngOnInit() {
  }

}
