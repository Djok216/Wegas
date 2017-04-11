<?php
/**
 * Created by PhpStorm.
 * User: BlackDeathM8
 * Date: 11-Apr-17
 * Time: 11:26
 */

class Controller {
    public function model($model) {
        // file check
        require_once '../app/models/' . $model .'.php';
        return new $model();
    }

    public function view($view, $data = []) {
        require_once '../app/views/' . $view . '.php';
    }
}