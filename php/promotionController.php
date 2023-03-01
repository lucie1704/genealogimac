<?php

  require_once('promotionModel.php');
  
  function getPromotionsAsTable() {
    return json_encode(getAllPromotions());
  }

  function deletePromotionInDatabase($year) { 
    deletePromotion($year); //delete promotion $year from the database table 'promotions'
		return getPromotionsAsTable(); //for debugging
  }

  function addPromotionInDatabase($form) { //form is the data we got from filling the form
    if(isset($form['year'])){// if define
      $year = $form['year']; 
      //'year' depends on what you put in label and input tag in the form, 
      //it helps you spot the specific data you want so you can store it in a new variable 
      }else{
      echo "missing data";
      } 
    addPromotion($year); //add a new promotion $form to the database table 'promotions'
		return getPromotionsAsTable(); //for debugging
	}
	
?>