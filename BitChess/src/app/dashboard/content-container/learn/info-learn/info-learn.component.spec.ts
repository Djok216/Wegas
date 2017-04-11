import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { InfoLearnComponent } from './info-learn.component';

describe('InfoLearnComponent', () => {
  let component: InfoLearnComponent;
  let fixture: ComponentFixture<InfoLearnComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ InfoLearnComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InfoLearnComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
