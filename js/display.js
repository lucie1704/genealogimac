/*this file is used for display, you can use it based on this exemple 

function displayFunction(data) {
    var content = "<table><tr><td>Table Name</td></tr>"; // your html to display
    data.forEach(function (element) { //go through the data and for each element do the following
        content += '<tr><td>' + element.attribute + "</td></tr>"; 
        //attribute is the name of the column you want to get, it needs to be the same as in the dataset
    });
    content += "</table>";
    //content += is to accumulate html code in one variable so you can write html more clearly on separate lines 
    document.getElementById('here').innerHTML = content;
    // document.getElementById('here') gets the tag where you put id="here" in the index.html
    // for this you need to create a new empty div in the index.html like
    // <div id="yourId"></div>
    // innerHTML = content is to insert the all the HTML you wrote in the var content in the tag you chose
}
*/


function displayPromotions(promotions) { //we're gonna put in 'content' what we want to be put in the div
    var content = "<h3>Promotions</h3><table>"; //to open the table
    promotions.forEach(function (promotion) { //we get every single elements of 'promotions' and respectively name them 'promotion'
        content += '<tr class="promo"><td><a href="#">' + promotion.year + '</a></td><td>\
        <a href="#" title=\'Supprimer la promo\'>X</a> \
        </td></tr>'; // 'content +=' to complete the html line (in content), we add row for each element. in each row we got 2 elements(columns) 'promo' and 'X'. '\' is for diplay purpose so we can write clearer content on different lines eventhough it's interpreted as a single line once all put together. 
    });
    content += "</table><br>"; //on ferme le tableau
    content += '<button onclick="addPromoForm()">Ajouter une promotion</button>';
    document.getElementById('promotions').innerHTML = content; // 'document' refers to index.html. 'getElementById' get the div (or any other requested tagname) in the html where id is 'promotions'. 'innerHTML' replace the div's content by the let 'content';
}



function displayStudentsFromPromo(students, year){
    var content = "<br><h3>Étudiants IMAC"+ year + "</h3>";

    if(students[0]){
        students.forEach(function (student) {
            content += '<button onclick="displayStudentInfo(' + student.id + ')"> + </button> '  + student.lastName + ' ' + student.firstName + '<br><br>';
        });
        
    }
    else{
        content += 'Pas d\'étudiants encore enregistrés dans cette promotion';
    }
    content += "<br>";

        document.getElementById('studentsDisplay').innerHTML = content;
        document.getElementById('family').innerHTML = '';
        document.getElementById('godFather').innerHTML = '';
        document.getElementById('godChild').innerHTML = '';
        document.getElementById('studentInfos').innerHTML = "";
}



function addPromoForm(){
    var content = '<br>\
    <form action="php/router.php/promotions" method="post" id="addPromo" > \
    <div> \
        <label for="year">Année d\'obtention du diplôme : </label> \
        <input type="text" id="year" name="year" autocomplete="off"> \
    </div><br> \
    <div class="button"> \
        <button type="submit">Ajouter</button> \
    </div> \
    </form>';

    document.getElementById('promoForm').innerHTML = content;
    document.getElementById('studentsDisplay').innerHTML = '';
    document.getElementById('family').innerHTML = '';
    document.getElementById('godFather').innerHTML = '';
    document.getElementById('godChild').innerHTML = '';
}



async function displayStudentInfo(studentId){
    const infos = await getStudentInfos(studentId);
    infos.forEach(info => {    
        let content = "<h3>Profil Étudiant</h3>";
        content += '<button onclick="removeStudent(' + studentId + ')" style="width:150px;"> Supprimer ce profil</button><br>'; 
        
        content += "Nom : " + info.firstName + " " + info.lastName + "<br>Date de naissance : " + info.birthDate + "<br>IMAC" + info.year;

        let godChildButton = '<br><button class="relativesButton" onclick="displayGodChild('+info.id+')">Fillot.e</button>';
        
        let godFatherButton = '<button class="relativesButton" onclick="displayGodFather('+info.godFatherId+')">Parrain/Marraine</button>';

        let familyButton = '<button class="relativesButton" onclick="displayAllFamily('+info.id+')">Arbre de tous les parrains et fillots</button>';


        // Remove previous informations from the dom
        document.getElementById('studentsDisplay').innerHTML = '';
        document.getElementById('promoForm').innerHTML = '';

        // Add the new information in the dom
        document.getElementById('studentInfos').innerHTML = content;
        document.getElementById('godChild').innerHTML = godChildButton;
        document.getElementById('godFather').innerHTML = godFatherButton;
        document.getElementById('family').innerHTML = familyButton;


    });
}



function displayAddStudentForm(year){
    var content = '<br>\
    <h3>Ajouter un étudiant à la promo IMAC' + year + ' </h3>\
    <form action="php/router.php/students/'+year+'" method="post"  id="addStudent"> \
    <div> \
        <label for="firstName">Prénom :</label> \
        <input type="text" id="firstName" name="firstName" required placeholder="Elena" autocomplete="off"> \
    </div><br> \
    <div> \
        <label for="lastName">Nom :</label> \
        <input type="text" id="lastName" name="lastName" required placeholder="ARMAND" autocomplete="off"> \
    </div><br> \
    <div> \
        <label for="birthDate">Date de naissance :</label> \
        <input type="date" id="birthDate" name="birthDate" value="2000-01-01" placeholder="dd/mm/yyyy" required> \
    </div>\
    <input type="hidden" id="year" name="year" value="'+ year + '">\
    </div><br> \
    <div class="button"> \
        <button type="submit">Ajouter</button> \
    </div> \
    </form>';

    document.getElementById('promoForm').innerHTML = content;

}



async function displayGodFather(godFatherId)
{
    const godFather = (await getStudentInfos(godFatherId))[0];//[0] because we have an array inside an array
    let content=" :  " ;

    if (!godFather)
    {
        content += 'Pas encore de parrain/marraine'
    }
    else
    {
        content += godFather.firstName+' '+godFather.lastName;
    }

    document.getElementById('godFather').innerHTML += content;
}



async function displayGodChild(studentId)
{
    const godchild = await getGodChild(studentId);
    let content = " :  ";

    if (godchild ==-1)
    {
        content += 'Pas encore de fillot.e'
    }
    else
    {
        godchild.forEach(child => {
            content += child.firstName+ ' '+child.lastName;
        })

    }

    document.getElementById('godChild').innerHTML += content; 
}



async function displayAllFamily(studentId)
{
    const generations = await getAllFamily(studentId);
    let content = "<h3>Arbre généalogique des parrains/marraines </h3>"

    generations.forEach(members => {
        members.forEach( member =>{
            if(member.id==studentId){
                content += '<p><strong>'+member.firstName+' '+member.lastName+ ' (IMAC'+ member.year+') </strong></p>'
            }
            else {
                content += '<p>'+member.firstName+' '+member.lastName+ ' (IMAC'+ member.year+') </p>'
            }
        })
    })

    document.getElementById('family').innerHTML += content;
}