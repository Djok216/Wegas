import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ClubContentComponent } from './club-content.component';

describe('ClubContentComponent', () => {
  let component: ClubContentComponent;
  let fixture: ComponentFixture<ClubContentComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ClubContentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ClubContentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
