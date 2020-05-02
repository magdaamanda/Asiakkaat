<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<style>
.a{
	text-align: right;
	background-color: green;
	color: white;
	height: 30px;
	font-family: Arial, Helvetica, sans-serif;
	padding: 5px 5px 5px 5px;
}
.b{
	text-align: left;
	background-color: green;
	color: white;
	height: 30px;
	font-family: Arial, Helvetica, sans-serif;
	padding: 5px 5px 5px 5px;
}
.c{
	text-align: left;
	background-color: white;
	padding: 5px 5px 5px 5px;
	border: 1px solid black;
}
</style>
<title>Insert title here</title>
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th class="a" colspan="2">Hakusana:</th>
			<th class="b"><input type="text" id="hakusana"></th>
			<th class="b"><input class="c" type="button" value="Hae" id="hakunappi"></th>
		</tr>
		<tr>
			<th class="b">Etunimi</th>
			<th class="b">Sukunimi</th>
			<th class="b">Puhelin</th>
			<th class="b">Sposti</th>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
$(document).ready(function(){

	haeAsiakkaat();
	$("#hakunappi").click(function(){
		//console.log($("#hakusana").val());
		haeAsiakkaat();
	});
	$(document.body).on("keydown", function(event){
		if(event.which==13){ //Enteriä painettu, ajetaan haku
			haeAsiakkaat();	
		}
	});
	$("#hakusana").focus();//viedään kursori hakusana-kenttään
	
});
function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax({
		url:"asiakkaat/"+$("#hakusana").val(),
		type:"GET",
		dataType:"json",//funktio palauttaa tiedot json objektina
		success:function(result){
			$.each(result.asiakkaat, function(i, field){
				var htmlStr;
				htmlStr+="<tr>";
				htmlStr+="<td class='c'>"+field.etunimi+"</td>";
				htmlStr+="<td class='c'>"+field.sukunimi+"</td>";
				htmlStr+="<td class='c'>"+field.puhelin+"</td>";
				htmlStr+="<td class='c'>"+field.sposti+"</td>";
				htmlStr+="</tr>";
				$("#listaus tbody").append(htmlStr);
			});
	}});
}
</script>
</body>
</html>