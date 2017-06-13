import { Component, OnInit } from '@angular/core';
import {LearnComponent} from '../learn.component';

@Component({
  selector: 'app-info-learn',
  templateUrl: './info-learn.component.html',
  styleUrls: ['./info-learn.component.css']
})
export class InfoLearnComponent implements OnInit {

  constructor(public parent1: LearnComponent) { }

  ngOnInit() {
  }

}
