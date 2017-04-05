import {Routes, RouterModule} from "@angular/router";
import {LoginComponent} from "./event-container/login/login.component";
import {RegisterComponent} from "./event-container/register/register.component";
import {DashboardComponent} from "./dashboard/dashboard.component";
import {ModuleWithProviders} from "@angular/core";
import {HelpComponent} from "./dashboard/content-container/help/help.component";
import {ForumComponent} from "./dashboard/content-container/forum/forum.component";
import {PlayComponent} from "./dashboard/content-container/play/play.component";
import {LiveComponent} from "./dashboard/content-container/live/live.component";
import {ClubsComponent} from "./dashboard/content-container/clubs/clubs.component";
import {LearnComponent} from "./dashboard/content-container/learn/learn.component";
import {StatsComponent} from "./dashboard/content-container/stats/stats.component";
import {HomeComponent} from "./dashboard/content-container/home/home.component";

/**
 * Created by BlackDeathM8 on 29-Mar-17.
 */

// mare router
export const router : Routes = [
  {path:'', component: DashboardComponent, children: [
    {path:'home', component: HomeComponent},
    {path:'play', component: PlayComponent},
    {path:'live', component: LiveComponent},
    {path:'clubs', component: ClubsComponent},
    {path:'learn', component: LearnComponent},
    {path:'forum', component: ForumComponent},
    {path:'stats', component: StatsComponent},
    {path:'help', component: HelpComponent}
  ]},
  {path: 'login', component: LoginComponent},
  {path: 'register', component: RegisterComponent}
];

// mare exporter
export const routes: ModuleWithProviders = RouterModule.forRoot(router);
