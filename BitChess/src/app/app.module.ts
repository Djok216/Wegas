import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppComponent } from './app.component';
import { HeaderContainerComponent } from './header-container/header-container.component';
import { ContentContainerComponent } from './content-container/content-container.component';
import { FooterContainerComponent } from './footer-container/footer-container.component';
import { LogoSectionComponent } from './header-container/logo-section/logo-section.component';
import { ProfileSectionComponent } from './header-container/profile-section/profile-section.component';
import { MenuSectionComponent } from './header-container/menu-section/menu-section.component';
import { ContentSectionComponent } from './content-container/content-section/content-section.component';
import { InfoSectionComponent } from './content-container/info-section/info-section.component';
import { FooterSectionComponent } from './footer-container/footer-section/footer-section.component';
import { LoginComponent } from './event-container/login/login.component';
import { RegisterComponent } from './event-container/register/register.component';

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
    RegisterComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
