<?php
/**
 * Created by PhpStorm.
 * User: BlackDeathM8
 * Date: 11-Apr-17
 * Time: 11:29
 */

class Home extends Controller {
    public function index($name = '') {
        $user = $this->model('User');
        $user->name = $name;

        $this->view('home/index', ['name' => $user->name]);
    }
}