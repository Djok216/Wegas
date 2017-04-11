<?php

class User extends Controller {

    public function login(... $loginData) {
        $nr = count($loginData, COUNT_RECURSIVE);
        if($nr != 2 || !strlen($loginData[0]) || !strlen($loginData[1])) {
            echo json_encode("Failed to login! Try one mode time");
            return;
        }

        echo json_encode("Succes login");
    }
    
    public function register(... $registerData) {
        $nr = count($registerData, COUNT_RECURSIVE);
        if($nr != 4) {
            echo json_encode("Failed to register! Try one more time");
            return;
        }

        foreach ($registerData as $key => $value) {
            if(!strlen($value)) {
                echo json_encode("Failed to register! Try one more time");
                return;
            }
        }
        echo json_encode("Succes register");
    }

    public function index() {
        echo json_encode("wrong site 404");
    }
}