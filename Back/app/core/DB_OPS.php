<?php
/**
 * Created by PhpStorm.
 * User: BlackDeathM8
 * Date: 11-Apr-17
 * Time: 13:52
 */

header("Access-Control-Allow-Origin: *");

final class DB_OPS {
    private $connection = null;

    private function __construct() {
        $this->connection = oci_connect('user_chess','user_chess','localhost/xe')
            or die ("Failed to connect" . oci_error());
    }

    public static function getInstance() {
        static $instance = null;
        if($instance == null)  {
             $instance = new DB_OPS();
        }
        return $instance;
    }

    public function registerUser($username, $password, $email) {
        if($this->checkIfExists($username)) {
            return 'User already exists';
        }

        $statement = "BEGIN
                        PACKAGE_USERS.INSERT_NEW_USER(:username, :email, :username, :password);
                      END;";
        $parser = oci_parse($this->connection, $statement);
        oci_bind_by_name($parser, ":username", $username);
        oci_bind_by_name($parser, ":email", $email);
        oci_bind_by_name($parser, ":password", $password);

        if(oci_execute($parser, OCI_COMMIT_ON_SUCCESS)) {
            return 'Register success';
        }
        return 'Error when register new user.';
    }

    public function checkIfExists($username) {
        $statement = "BEGIN
                        :nicknameStatus := PACKAGE_USERS.EXISTS_USER(:username);
                      END;";

        $parser = oci_parse($this->connection, $statement);

        oci_bind_by_name($parser, ":nicknameStatus", $usernameStatus);
        oci_bind_by_name($parser, ":username", $username);

        if(oci_execute($parser)) {
            return $usernameStatus;
        }
        return 0;
    }

    public function checkUser($username, $password) {
        $statement = "BEGIN
                        :nicknameStatus := PACKAGE_USERS.EXISTS_USER(:username);
                        :password := PACKAGE_USERS.GET_PASSWORD(:username);
                      END;";

        $parser = oci_parse($this->connection, $statement);

        oci_bind_by_name($parser, ":nicknameStatus", $usernameStatus);
        oci_bind_by_name($parser, ":password", $dbPassword, 50);
        oci_bind_by_name($parser, ":username", $username);

        if(oci_execute($parser)) {
            if($usernameStatus == 1) {
                if($password == $dbPassword) {
                    return 'Username and password are valid';
                }
                return 'Password is invalid.';
            }
            return 'Username is invalid.';
        }
        return 'Error when running script';
    }
}