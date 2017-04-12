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

	if(!$this->validUsernameFormat($username)){
		return 'Username format not valid';
	}

	if(!$this->validEmailFormat($email)){
		return 'Email format not valid';
	}	

        if($this->checkIfExists($username)) {
            return 'User already exists';
        }

        $statement = "BEGIN
                        PACKAGE_USERS.INSERT_NEW_USER(:username, :email, :username, :password);
                      END;";
        $parser = oci_parse($this->connection, $statement);

	if(!$parser){
		$err = oci_error();
		return 'Oracle error: '.$e['message'];
	}

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

	if(!$parser){
		$err = oci_error();
		return 'Oracle error: '.$e['message'];
	}

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

	if((!$parser) and ($usernameStatus == 1)){
		$err = oci_error();
		return 'Oracle error: '.$e['message'];
	}

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

<<<<<<< HEAD
    public function validUsernameFormat($username){
	if (preg_match('/[^A-Za-z0-9]/', $username)){
  		return 0;
	}
	return 1;
    }

    public function validEmailFormat($email){
	if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    		return 0;
	}
	return 1;
=======
    public function getAllUserTableData() {
        $statement = 'SELECT * FROM USERS';
        $parser = oci_parse($this->connection, $statement);

        oci_execute($parser);

        echo '<table>';
        while($row =  oci_fetch_array($parser, OCI_B_ROWID)) {
            echo "<tr><td>" . $row[0] . "</td><td>" .  $row[1] . "</td><td>" .
                $row[2] . "</td><td>" . $row[3] . "</td><td>" . $row[4] . "</td><td>" .
                $row[5] . "</td><td>" . $row[6] . "</td><td>" . $row[7] . "</td><td>" .
                $row[8] . "</td><td>" . $row[9] . "</td></tr>";
        }
        echo '</table>';
        return;
>>>>>>> 9059be481c8d8e20e93ce08ad06a11960c9d2f12
    }
}