import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppComponent } from './app.component';
import { HeaderContainerComponent } from './dashboard/header-container/header-container.component';
import { ContentContainerComponent } from './dashboard/content-container/content-container.component';
import { FooterContainerComponent } from './dashboard/footer-container/footer-container.component';
import { LogoSectionComponent } from './dashboard/header-container/logo-section/logo-section.component';
import { MenuSectionComponent } from './dashboard/header-container/menu-section/menu-section.component';
import { ContentSectionComponent } from './dashboard/content-container/home/content-section/content-section.component';
import { InfoSectionComponent } from './dashboard/content-container/home/info-section/info-section.component';
import { FooterSectionComponent } from './dashboard/footer-container/footer-section/footer-section.component';
import { LoginComponent } from './event-container/login/login.component';
import { RegisterComponent } from './event-container/register/register.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import {routes} from "./app-router";
import {ProfileSectionComponent} from "./dashboard/header-container/profile-section/profile-section.component";
import {AuthenticateSectionComponent} from "./dashboard/header-container/authenticate-section/authenticate-section.component";
import { HomeComponent } from './dashboard/content-container/home/home.component';
import { PlayComponent } from './dashboard/content-container/play/play.component';
import { LiveComponent } from './dashboard/content-container/live/live.component';
import { ClubsComponent } from './dashboard/content-container/clubs/clubs.component';
import { ForumComponent } from './dashboard/content-container/forum/forum.component';
import { StatsComponent } from './dashboard/content-container/stats/stats.component';
import { HelpComponent } from './dashboard/content-container/help/help.component';
import { LearnComponent } from './dashboard/content-container/learn/learn.component';
import { ForumInfoComponent } from './dashboard/content-container/forum/forum-info/forum-info.component';
import { ForumContentComponent } from './dashboard/content-container/forum/forum-content/forum-content.component';
import { InfoLearnComponent } from './dashboard/content-container/learn/info-learn/info-learn.component';
import { ContentLearnComponent } from './dashboard/content-container/learn/content-learn/content-learn.component';
import { ClubContentComponent } from './dashboard/content-container/clubs/club-content/club-content.component';
import { ClubInfoComponent } from './dashboard/content-container/clubs/club-info/club-info.component';
import { StatsContentComponent } from './dashboard/content-container/stats/stats-content/stats-content.component';
import { StatsInfoComponent } from './dashboard/content-container/stats/stats-info/stats-info.component';

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
    DashboardComponent,
    AuthenticateSectionComponent,
    HomeComponent,
    PlayComponent,
    LiveComponent,
    ClubsComponent,
    ForumComponent,
    StatsComponent,
    HelpComponent,
    LearnComponent,
    ForumInfoComponent,
    ForumContentComponent,
    InfoLearnComponent,
    ContentLearnComponent,
    ClubContentComponent,
    ClubInfoComponent,
    StatsContentComponent,
    StatsInfoComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpModule,
    routes
  ],
  providers: [HttpModule],
  bootstrap: [AppComponent]
})
export class AppModule { }
