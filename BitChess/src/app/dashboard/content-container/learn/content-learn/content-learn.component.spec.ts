import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ContentLearnComponent } from './content-learn.component';

describe('ContentLearnComponent', () => {
  let component: ContentLearnComponent;
  let fixture: ComponentFixture<ContentLearnComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ContentLearnComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ContentLearnComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
