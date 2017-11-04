$(function(){
	
	console.log("hi sami Kidanu");
	$("#newbtn").click(display);
	$("#cancelbtn").click(display);
	$("#addbtn").click(validate);
	$("#searchbtn").click(getAppointments)



	function getAppointments(){        
        $.ajax({
            type: 'POST',
            url: '/cgi-bin/searchAppointment.pl',
            dataType: 'json',
            data: {'searchResult':$("#search").val()},           
            success: function(Data){
                $("#aptRecords").empty();                         
                if( Data.length != 0 ){
                    $("#aptRecords").append("<th>Date</th> <th>Time</th> <th>Desctioption</th>")
                    for(var key in Data){
                        $("#aptRecords").append("<tr>")
                        $("#aptRecords").append("<td>" + Data[key].appointmentDate + "</td>")
                        $("#aptRecords").append("<td>" + Data[key].appointmentTime + "</td>")
                        $("#aptRecords").append("<td>" + Data[key].appointmentDescription + "</td>")
                        $("#aptRecords").append("</tr>")
                    }
                }else{
                    $("#EmptyRecord").append("There is no Record Currently")
                }
            },
            error: function(){                
                alert("An error has occurred");
            },
            complete: function() {
            }
        });

    }


	function validate() {        
        var errorMessage = ""; 
        if ($("#date").val() == "") {
            errorMessage = ".Date required\n";
        }
        if ($("#time").val() == "") {
            errorMessage = errorMessage +".Time required\n";
        }
        if ($("#description").val() == "") {
            errorMessage = errorMessage + ".Description required";
        }

        if(errorMessage != ""){
            alert("You have to fill the required information\n" + errorMessage);
        }else{
            $("#addAppointment").submit();
        }
    }



	function display(){
		$("#addAppointment").toggle();
		$("#newbtn").toggle();
	}


});