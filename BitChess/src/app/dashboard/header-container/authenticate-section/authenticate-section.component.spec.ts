import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AuthenticateSectionComponent } from './authenticate-section.component';

describe('AuthenticateSectionComponent', () => {
  let component: AuthenticateSectionComponent;
  let fixture: ComponentFixture<AuthenticateSectionComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AuthenticateSectionComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AuthenticateSectionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
