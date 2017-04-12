<?php

class User extends Controller {
    public function login(... $loginData) {
        $nr = count($loginData, COUNT_RECURSIVE);
        if($nr != 2 || !strlen($loginData[0]) || !strlen($loginData[1])) {
            echo json_encode("Failed to login! Try one mode time");
            return;
        }
        require_once '../app/core/DB_OPS.php';
        echo json_encode(DB_OPS::getInstance()->checkUser($loginData[0], $loginData[1]));
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
        if($registerData[1] != $registerData[2]) {
            echo json_encode("Failed to register! Password don't match.");
            return;
        }
        require_once '../app/core/DB_OPS.php';
        echo json_encode(DB_OPS::getInstance()->registerUser($registerData[0], $registerData[1], $registerData[3]));
    }

    public function getAllData() {
        require_once '../app/core/DB_OPS.php';
        echo json_encode(DB_OPS::getInstance()->getAllUserTableData());
    }

    public function index() {
        echo json_encode("wrong site 404");
    }
}