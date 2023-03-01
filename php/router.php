<?php

require_once('promotionController.php');
require_once('studentController.php');


$request = explode('/',$_SERVER['REQUEST_URI']);
// converts URL into a list of all the elements forming the URL  seaprated by '/' starting from 0 which is localhost/
$method = $_SERVER['REQUEST_METHOD'];
// return the method : GET / POST / DELETE

//Dispatch actions depending on URL
// got to localhost/genealogimac/php/router.php/promotions to check if your routing works
// what is displayed is what you echo here in router.php

switch($request[4]) {
	case 'promotions' : 
		switch($method) {
			case 'GET' : 
				echo getPromotionsAsTable();
				break;
			case 'POST' :
				addPromotionInDatabase($_POST);

				//to redirect to main page so the promotions are updated
				$referer = $_SERVER['HTTP_REFERER'];
				header("Location: $referer");
				break;
			case 'DELETE' : //function 'removePromo' in the request.js brings us here (promotions and method DELETE)
				echo deletePromotionInDatabase($request[5]); //echo = display what 'deletePromotionInDatabase' returns. can only put one echo in 'case'
				// $request[5] -> 6th element of the link 'localhost/genealogimac/php/router.php/promotions/+promo' -> it's promo's value
				break;
			default:
				http_response_code('404');
				echo 'OOPS';
		}
		break;

	case 'students' : 
		switch($method) {
			case 'GET' :
				echo getStudentsFromPromotionAsJson($request[5]);
				break;
			case 'POST' :
				addStudentInDatabase($_POST);
				break;
				
			case 'DELETE' :
				echo deleteStudentInDatabase($request[5]);
				break;
			default:
				http_response_code('404');
				echo 'OOPS';
		}
		break;

	case 'student' : 
		switch($method) {
			case 'GET' :
				echo getStudentAsJson($request[5]);
				break;
			case 'POST' :
				//not implemented yet
				echo addGodFather();
				break;
			case 'DELETE' :
				//not implemented yet
				echo deleteGodFather();
				break;
			default:
				http_response_code('404');
				echo 'OOPS';
				break;
		}
		break;
	case 'year' : 
		switch($method) {
			case 'GET' :
				echo getPromotionFromStudentAsJson($request[5]);
				break;
			default:
				http_response_code('404');
				echo 'OOPS';
				break;
		}
		break;
	case 'godChild':
		switch($method) {
			case 'GET' :
				echo getDirectGodChildAsJson($request[5]);
				break;

			default:
				http_response_code('404');
				echo 'OOPS';
				break;				
		}
		break;

	case 'family' :
		switch($method){
			case 'GET' :
				echo getAllFamilyAsJson($request[5]);
				break;

			default:
				http_response_code('404');
				echo 'OOPS';
				break;	
		}
		break;
	default:
		http_response_code('404');
		echo 'OOPS';
		break;

		
}

?>