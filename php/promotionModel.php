<?php

require_once('connection.php');

function getAllPromotions() {
    $cnx = connection();
    $result = $cnx->query('select * from promotions'); 
    return $result->fetchall(); 
}

function addPromotion($year){
    $cnx = connection();

    //these lines are used to insert after all the elements
    $id = $cnx->query("SELECT id FROM promotions ORDER BY id DESC LIMIT 1")->fetchAll();
    $id = json_encode($id);
    $id = json_decode($id, true);
    $lastId = $id[0]['id']+1;

    $insert = $cnx->prepare('insert into promotions (id, year) values( ?, ? )');
    $insert->execute([$lastId, $year]);
}

function deletePromotion($year){
    $cnx = connection(); 
    $cnx->query("DELETE FROM promotions Where year=$year");
}

?>