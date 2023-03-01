/*

In this file we will write the functions that will make the bridge with our router 
so we can get our data, for this we use async function and here is a model on how to use it

async function myFunction(){
    const response = await fetch ('./php/router.php/endPoint/'); // route path that will call the router.php
    const endPoint = await response.json(); //only continue if we get the promised response
    console.log(endPoint); //check if it works
    return endPoint; //return the data as an object thanks to the routing process (router>controller>model>controller>router>here)
}

*/

async function getAllPromotions(){
    const response = await fetch ('./php/router.php/promotions/');
    const promotions = await response.json();
    console.log("got promotions");
    return promotions;
}


async function getAllStudents(promoYear){
    console.log("promo year : "+ promoYear);
    const response = await fetch ('./php/router.php/students/'+promoYear);
    const students = await response.json();
    console.log(students);
    return students;
}


async function removePromo(promo) {
	const response = await fetch ('./php/router.php/promotions/'+promo, { method: 'DELETE'});
    const promotions = await response.json();
    console.log("year "+ promo+ " was removed" );
    console.log(promotions);
    return promotions;
}
// we define an asynchrone function 
//fetch calls the route to go to the router, in promotions, with the method 'DELETE' then get what is received
// '+promo' -> concatenate promo's value to the link
// fetch take in argument the link and has for default method 'GET' (to load page). if we want another method we need to add it in the second argument, here with { method: 'DELETE'}
// console.log is to see if function works just fine


async function getStudentInfos(studentId){
    const response = await fetch ('./php/router.php/student/'+studentId);
    const infos = await response.json();
    // console.log(infos);
    return infos;
}

async function getStudentYear(studentId){
    const response = await fetch ('./php/router.php/year/'+studentId);
    const year = await response.json();
    var promo;
    year.forEach(y => { promo = y.year});
    return promo;
}

async function removeStudent(studentId){
    const response = await fetch ('./php/router.php/students/'+studentId, { method: 'DELETE'});
    const array = await response.json();
    var year = array[0]['year'];
    console.log(year);

    //update student from this promo
    const response2 = await fetch ('./php/router.php/students/'+year); 
    const students = await response2.json();
    displayStudentsFromPromo(students, year);
    return getAllStudents(year); //returns the students list updated
}


async function getGodChild(studentId)
{
    const response = await fetch('./php/router.php/godChild/' +studentId);
    const godChild = await response.json();
    return godChild;
}


async function getAllFamily(studentId)
{
    const response = await fetch('./php/router.php/family/' + studentId);
    const members = await response.json();
    console.log(members)
    return members;
}
