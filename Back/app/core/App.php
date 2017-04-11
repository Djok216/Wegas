<?php

/**
 * Created by PhpStorm.
 * User: BlackDeathM8
 * Date: 11-Apr-17
 * Time: 11:24
 */
header('Access-Control-Allow-Origin: *');
class App {
    protected $controller = 'home';
    protected $method = 'index';

    protected $params = [];

    public function __construct() {
        $url = $this->parseUrl();
        
        // check if controller exists
        if(file_exists('../app/controllers/'. $url[0] . '.php')) {
            $this->controller = $url[0];
            unset($url[0]);
        }

        require_once '../app/controllers/'. $this->controller . '.php';
        $this->controller = new $this->controller;

        // check if requested method
        if(isset($url[1])) {
            if(method_exists($this->controller, $url[1])) {
                $this->method = $url[1];
                unset($url[1]);
            }
        }

        // set params
        $this->params = explode(' ', file_get_contents('php://input'));

        call_user_func_array([$this->controller, $this->method], $this->params);
    }

    public function parseUrl() {
        // first is controller, second is method, rest are parameters
        if (isset($_GET['url'])) {
            $url = explode('/', filter_var(rtrim($_GET['url'], '/'), FILTER_SANITIZE_URL));
            return $url;
        }

        return null;
    }
}