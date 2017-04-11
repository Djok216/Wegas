<?php
/**
 * Created by PhpStorm.
 * User: BlackDeathM8
 * Date: 11-Apr-17
 * Time: 13:52
 */

header("Access-Control-Allow-Origin: *");

class DB_OPS {
    private $connection;

    public function __construct() {
        $this->connection = oci_connect('user_chess','user_chess','localhost/xe')
            or die ("Failed to connect" . oci_error());
    }

    public function getConnection() {
        return $this->connection;
    }
}