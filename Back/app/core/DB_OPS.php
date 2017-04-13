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

    public function registerUserPy($username, $password, $email, $wins, $loses) {
        if($this->checkIfExists($username)) {
            return 'User already exists';
        }

        $statement = "BEGIN
                        PACKAGE_USERS.INSERT_NEW_USER(:username, :email, :username, :password, :wins, :looses);
                      END;";

        $parser = oci_parse($this->connection, $statement);
        oci_bind_by_name($parser, ":username", $username);
        oci_bind_by_name($parser, ":email", $email);
        oci_bind_by_name($parser, ":password", $password);
        oci_bind_by_name($parser, ":wins", $wins);
        oci_bind_by_name($parser, ":looses", $loses);

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
        if($this->checkIfExists($username) == 0) {
            return  'Username is invalid.';
        }

        $statement = "BEGIN
                        :password := PACKAGE_USERS.GET_PASSWORD(:username);
                      END;";

        $parser = oci_parse($this->connection, $statement);

        oci_bind_by_name($parser, ":password", $dbPassword, 50);
        oci_bind_by_name($parser, ":username", $username);

        if(oci_execute($parser)) {
                if($password == $dbPassword) {
                    return 'Username and password are valid';
                }
                return 'Password is invalid.';
            }
        return 'Error when running script';
    }

    public function getAllUserTableData($number) {
        $statement = 'Select * from users where rownum <=' . $number;
        $parser = oci_parse($this->connection, $statement);
        oci_execute($parser);

        $ans = '';

        $ans = $ans . '<table>';
        while(($row =  oci_fetch_array($parser, OCI_B_ROWID)) != false) {
            $ans = $ans . "<tr><td>" . $row[0] . "</td><td>" .  $row[1] . "</td><td>" .
                $row[2] . "</td><td>" . $row[3] . "</td><td>" . $row[4] . "</td><td>" .
                $row[5] . "</td><td>" . $row[6] . "</td><td>" . $row[7] . "</td><td>" .
                $row[8] . "</td><td>" . $row[9] . "</td></tr>";
        }
        $ans = $ans . '</table>';
        return $ans;
    }
}