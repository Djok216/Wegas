import { Component, OnInit } from '@angular/core';
import {LearnComponent} from '../learn.component';


@Component({
  selector: 'app-content-learn',
  templateUrl: './content-learn.component.html',
  styleUrls: ['./content-learn.component.css']
})
export class ContentLearnComponent implements OnInit {

  constructor(public parent1: LearnComponent) {

  }

  ngOnInit() {
  }

}
