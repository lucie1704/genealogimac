<?php

function connection() {
    $cnx = new PDO('mysql:host=localhost;dbname=genealogimac', 'root',''); //server, batabase name, user, password

    if(!$cnx) {
        die('Connection failed');
    }
    return $cnx;
    
}

?>

