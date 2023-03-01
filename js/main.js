document.addEventListener('DOMContentLoaded', async () => {
    //here we call our functions when the page is loaded it's like a main

    //call for the function in the request.js and wait till you have a response(with await) 
    //then call your function in display.js for the layout
    const promotions = await getAllPromotions(); //gives the object 'promotions' as a response
    displayPromotions(promotions); //send the object to display function



    const list = document.getElementsByClassName('promo'); //get all of the table's rows where class is 'promo' (meaning that div shouldn't be empty and have been filled with content already by a previous function = the table is already display)
    //get students from a promotion
    for (let element of list) {
        element.firstChild.addEventListener('click', async() => {
            var year = element.firstChild.innerText;
            displayAddStudentForm(year);
            await getAllStudents(year).then(students =>{        
                displayStudentsFromPromo(students, year)
            })

            //check if the add student form was submitted (works with jquery linked in index)
            $("#addStudent").on('submit', function(e) {
                e.preventDefault();
                $.ajax({
                    type: $(this).prop('method'),
                    url : $(this).prop('action'),
                    data: $(this).serialize()
                }).done(async function() {
                    displayAddStudentForm(year);
                    await getAllStudents(year).then(students =>{        
                        displayStudentsFromPromo(students, year)
                    })
                });
            });
        })
    }

    //delete a promotion
    for (let element of list) { 
        element.lastChild.addEventListener('click', async() => {  
            var year = element.firstChild.innerText; 
            await removePromo(year).then( 
                window.location.reload() 
            )
        })
    }
    
})