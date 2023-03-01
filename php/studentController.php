<?php

    require_once('studentModel.php');

    function getStudentsFromPromotionAsJson($promoYear){
        return json_encode(getStudentsFromPromotion($promoYear));
    }
    
    function getStudentAsJson($id){
        return json_encode(getStudent($id));
    }

    function getPromotionFromStudentAsJson($studentId) {
        return json_encode(getPromotionFromStudent($studentId));
    }

    function addStudentInDatabase($form) { //form is the data we got from filling the form
       
        $firstName = $form['firstName']; 
        $lastName = $form['lastName'];
        $birthDate = $form['birthDate'];
        $promotionYear = $form['year']; 

        addStudent($firstName, $lastName, $birthDate, $promotionYear);
        // return $promotionYear;        
    }

    function deleteStudentInDatabase($studentId) {
        deleteStudent($studentId); 
        return json_encode(getPromotionFromStudent($studentId));
    }

    function getDirectGodChildAsJson($idStudent)
    {
        $godChildId = getDirectGodChild($idStudent); 
        if($godChildId){
            return json_encode(getStudent($godChildId));
        }else{
            return -1;
        }
    }

    function getAllFamilyAsJson($idStudent)
    {
        $family = array();

        //put the current student in the array first
        array_push($family, getStudent($idStudent));
        
        $godChildId = getDirectGodChild($idStudent);

        $godFatherId = getDirectGodFather($idStudent);
        
        while ($godChildId)
        {
            //put the godchildren after in the array
            $directGodChild = getStudent($godChildId);
            array_push($family, $directGodChild);
            $godChildId = getDirectGodChild($godChildId); 
            //in case of multiple godchildren it will only continue the loop with the first one
        }

        while ($godFatherId)
        {
            //put the godfather before in the array
            $directGodFather = getStudent($godFatherId);
            array_unshift($family, $directGodFather);
            $godFatherId = getDirectGodFather($godFatherId);
        }

        return json_encode($family);
    }

?>