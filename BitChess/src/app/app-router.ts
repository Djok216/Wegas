import {Routes, RouterModule} from "@angular/router";
import {LoginComponent} from "./event-container/login/login.component";
import {RegisterComponent} from "./event-container/register/register.component";
import {DashboardComponent} from "./dashboard/dashboard.component";
import {ModuleWithProviders} from "@angular/core";

/**
 * Created by BlackDeathM8 on 29-Mar-17.
 */

// mare router
export const router : Routes = [
  {path:'', component: DashboardComponent},
  {path: 'login', component: LoginComponent},
  {path: 'register', component: RegisterComponent}
];

// mare exporter
export const routes: ModuleWithProviders = RouterModule.forRoot(router);
