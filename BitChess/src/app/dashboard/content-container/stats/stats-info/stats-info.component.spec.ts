import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { StatsInfoComponent } from './stats-info.component';

describe('StatsInfoComponent', () => {
  let component: StatsInfoComponent;
  let fixture: ComponentFixture<StatsInfoComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ StatsInfoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(StatsInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
