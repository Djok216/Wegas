import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-header-container',
  templateUrl: 'header-container.component.html',
  styleUrls: ['header-container.component.css']
})
export class HeaderContainerComponent implements OnInit {
  showHuiova : boolean = Math.random() >= 0.5;
  showHuiovaReloaded : boolean = !this.showHuiova;
  constructor() { }

  ngOnInit() {
  }

}
