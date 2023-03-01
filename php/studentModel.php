<?php

require_once('connection.php');

function addStudent($firstName, $lastName, $birthDate, $promotionYear){
    $cnx = connection();

    $yearId = $cnx->query("SELECT id FROM promotions WHERE year=$promotionYear")->fetch();   
    $yearId = json_encode($yearId); 
    $yearId = json_decode($yearId); 
    $statement = $cnx->prepare('insert into students (id, firstName, lastName, birthDate, promotionId, godFatherId, isVisible) VALUES (?, ?, ?, ?, ?, ?, ?)');
    $statement->execute([NULL, $firstName, $lastName, $birthDate, $yearId->id, NULL, '1']);
}

function deleteStudent($id){
    $cnx = connection(); 
    $cnx->query("UPDATE students SET isVisible=0 WHERE id=$id");
  }

function getStudent($id){ 
  $cnx = connection();
  // to change date format and join the student's promo year
  $infoStudent=$cnx->query("SELECT students.id, students.firstName, UPPER(students.lastName) AS lastName, DATE_FORMAT(birthDate, \"%d/%m/%Y\") AS birthDate, students.promotionId, students.godFatherId, students.isVisible, promotions.year FROM students INNER JOIN promotions ON students.promotionId = promotions.id WHERE students.id=$id");

  return $infoStudent->fetchAll(PDO::FETCH_ASSOC);
}

function getStudentsFromPromotion($promoYear) {
  $cnx = connection();

  //the following lines help to automatically get the right promotionId(between 1 and 5) from a promotion name (2020, 2021, 2022 ...)
  $yearId = $cnx->query("SELECT id FROM promotions WHERE year=$promoYear")->fetch();   
  //output from localhost/genealogimac/php/router.php/students/2022
  //Array ( [id] => 3 [0] => 3 )
  $yearId = json_encode($yearId); //{"id":"3","0":"3"}
  $yearId = json_decode($yearId); // gives me an object from which I can extract data
  //print_r($yearId->id); //this will return what is in the 'id' row so 3 in this exemple
  $StudentsFromPromotion = $cnx->query("SELECT id, firstName, UPPER(lastName) AS lastName FROM students WHERE promotionId=$yearId->id AND isVisible=1 ORDER BY lastName, firstName ASC"); //get the students who have promotionId=3 in this specific case but works for all promotions
  return $StudentsFromPromotion->fetchAll();
}

function getDirectGodFather($idStudent) {
  $cnx = connection();
  $godFather = $cnx->query("SELECT parrain.id FROM students as filleul join students as parrain on filleul.godFatherId=parrain.id where filleul.id=$idStudent");

  if($godFather == false)
  {
    echo "pas de réponse de la table pour cette requête";
  }
  else
  {
    $godFatherId = $godFather->fetchColumn(0);
    return $godFatherId;
  }
}


function getDirectGodChild($idStudent)
{
    $cnx = connection();
    $godChild = $cnx->query("SELECT id FROM students WHERE godFatherId = $idStudent");

    if ($godChild == false)
    {
      echo "pas de réponse de la table pour cette requête";
    }
    else
    {
      $godChildId = $godChild->fetchColumn(0);
      return $godChildId;
    }
    
}

function getPromotionFromStudent($id){
  $cnx = connection();
  $promoYear = $cnx->query("SELECT year FROM students INNER JOIN promotions ON promotions.id = students.promotionId where students.id=$id");  
  return $promoYear->fetchAll();
}


?>
