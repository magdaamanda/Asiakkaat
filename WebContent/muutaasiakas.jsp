<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Insert title here</title>
</head>
<body>
<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>		
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>Sposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="submit" id="tallenna" value="Hyv�ksy"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="asiakas_id" id="asiakas_id">
	<%-- <input type="hidden" name="vanha_primary_key" id="vanha_primary_key"> --%>
	<%-- jos halutaan vaihtaa primary keyhin sidotun kent�n arvoa, nime� tms. --%>
	<%-- katso alempana js #vanha_primary_key --%>
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	//console.log("javascripti toimii");
	$("#takaisin").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	//haetaan muutettavan asiakkaan tiedot. kutsutaan GET metodilla ja v�litet��n polku haeyksi mukaan.
	var asiakas_id = requestURLParam("asiakas_id");
	$.ajax({url:"asiakkaat/haeyksi/"+asiakas_id, type:"GET", dataType:"json", success:function(result){
		//$("#vanha_primary_key").val(result.primary_key);
		//jos halutaan vaihtaa primary keyhin sidottua arvoa ^
		$("#asiakas_id").val(result.asiakas_id);
		$("#etunimi").val(result.etunimi);
		$("#sukunimi").val(result.sukunimi);
		$("#puhelin").val(result.puhelin);
		$("#sposti").val(result.sposti);
	}});
	
	$("#tiedot").validate({						
		rules: {
			asiakas_id: {
				required: true,
				minlength: 1
			},
			etunimi:  {
				required: true,
				minlength: 3				
			},	
			sukunimi:  {
				required: true,
				minlength: 3				
			},
			puhelin:  {
				required: true,
				minlength: 5
			},	
			sposti:  {
				required: true,
				email: true,
			}	
		},
		messages: {
			asiakas_id: {
				required: "id puuttuu",
				minlength: "id liian lyhyt"
			},
			etunimi: {     
				required: "Puuttuu",
				minlength: "Liian lyhyt"			
			},
			sukunimi: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			puhelin: {
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sposti: {
				required: "Puuttuu",
				email: "Ei kelpaa",
			}
		},			
		submitHandler: function(form) {	
			paivitaTiedot();
		}		
	}); 
	$("#etunimi").focus();
});
//funktio tietojen p�ivitt�mist� varten. kutsutaan PUT metodia ja v�litet��n kutsun mukana tiedot json stringin�.
//PUT /asiakkaat/
function paivitaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	//console.log(formJsonStr);
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#ilmo").html("Asiakkaan p�vitt�minen ep�onnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan p�ivitt�minen onnistui.");
      	$("#asiakas_id", "#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
		}
  }});	
}
</script>
</html>