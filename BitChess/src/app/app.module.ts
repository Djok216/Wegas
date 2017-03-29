import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppComponent } from './app.component';
import { HeaderContainerComponent } from './dashboard/header-container/header-container.component';
import { ContentContainerComponent } from './dashboard/content-container/content-container.component';
import { FooterContainerComponent } from './dashboard/footer-container/footer-container.component';
import { LogoSectionComponent } from './dashboard/header-container/logo-section/logo-section.component';
import { ProfileSectionComponent } from './dashboard/header-container/profile-section/profile-section.component';
import { MenuSectionComponent } from './dashboard/header-container/menu-section/menu-section.component';
import { ContentSectionComponent } from './dashboard/content-container/content-section/content-section.component';
import { InfoSectionComponent } from './dashboard/content-container/info-section/info-section.component';
import { FooterSectionComponent } from './dashboard/footer-container/footer-section/footer-section.component';
import { LoginComponent } from './event-container/login/login.component';
import { RegisterComponent } from './event-container/register/register.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import {routes} from "./app-router";

@NgModule({
  declarations: [
    AppComponent,
    HeaderContainerComponent,
    ContentContainerComponent,
    FooterContainerComponent,
    LogoSectionComponent,
    ProfileSectionComponent,
    MenuSectionComponent,
    ContentSectionComponent,
    InfoSectionComponent,
    FooterSectionComponent,
    LoginComponent,
    RegisterComponent,
    DashboardComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    routes
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
