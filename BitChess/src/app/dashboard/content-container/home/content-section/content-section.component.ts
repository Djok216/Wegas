import {Component, OnInit} from '@angular/core';
import './liveChess.js';

declare const LiveChess: any;

@Component({
  selector: 'app-content-section',
  templateUrl: 'content-section.component.html',
  styleUrls: ['content-section.component.css']
})

export class ContentSectionComponent implements OnInit {
  constructor() {
  }

  ngOnInit() {
    const game = new LiveChess();
  }
}
