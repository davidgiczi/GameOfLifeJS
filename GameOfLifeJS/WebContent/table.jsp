<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>

<title>Game of Life</title>

<style>

body {

text-align: center;
background-color: powderblue;
}

table, td {
  
  font-size: 10px;
  
  border: 1px solid black;
 	
  border-collapse: collapse;
  
}
 
table {

width:800px;
height:800px;

}


</style>
</head>


<body>

<h1 id="counter" style="color:white">${counter}</h1>

<h3 style="color:#ffbf00">${patternName}</h3>

<table align="center">

<c:forEach begin="0" end="${row-1}" varStatus="i">

<tr>

<c:forEach begin="0" end="${row-1}" varStatus="j">


<c:if test="${i.index*row+j.index lt row}">
<td id="${i.index*row+j.index}" style="background: white"><font style="color: black">${i.index*row+j.index}</font></td>
</c:if>

<c:if test="${i.index*row+j.index ge row && j.index%row == 0}">
<td id="${i.index*row+j.index}" style="background: white"><font style="color: black">${i.index*row+j.index}</font></td>
</c:if>

 
<c:if test="${i.index*row+j.index ge row+1 && j.index%row!=0}">
<td id="${i.index*row+j.index}" style="background: white"><font style="color: white">${i.index*row+j.index}</font></td>
</c:if>


</c:forEach>

</tr>
</c:forEach>
</table><br><hr>


<form style="float: left" action="GameServlet">

<select name="pattern">

<c:forEach items="${names}" var="name">
<option  value="${name}">${name}</option>
</c:forEach>

</select>

<input type="submit" value="Load">
</form>



<form method="POST" style="float: left" action="GameServlet">
<input size="4" type="text" name="input">
<input type="hidden" id="count" value="" name="counter">
<input type="hidden" id="tab" value="" name="table">
<input type="submit" onclick="stop()" value="Send">
</form>

<button  onclick="start()">Start</button>
<button  onclick="stop()">Stop</button>


<button style="float: right" onclick="exit()">Exit</button>


<script>

var table=${pattern};
var hostTable=[];
var i=0;
var bad=${badvalue};
var row=${row};
var go;
var counter=${counter};


	while(i<table.length){
		
		
		
	if(table[i]) {
			
			document.getElementById(i).style.backgroundColor="#ffbf00";
		}	
		
	
	
		i++;
	}
	
	i=0;

	while(i<row*row){
		
		hostTable.push(false);
		i++;
	}
	
	
	document.getElementById("count").value = counter;
	document.getElementById("tab").value = table;
	
function running() {
	
	i=0;
		
	while(i<table.length){
		
		evaluateCell(i);
		
		i++;
	}
	
	i=0;
	
	if(isStop()){
		
		stop();
		
	}
	
	i=0;
	
	while(i<hostTable.length) {
		
		table[i]=hostTable[i];
		
		i++;
		
	}
	
	i=0;
	
	while(i<table.length){
		
		if(table[i]){
			
			document.getElementById(i).style.backgroundColor="#ffbf00";
			
		}
		else{
			
			document.getElementById(i).style.backgroundColor="white";
		}
		
		i++;
	}
	
	i=0;
	
	
	
	document.getElementById("counter").innerHTML=++counter;
	document.getElementById("tab").value = table;
	document.getElementById("count").value = counter;
	
}




function start() {
	
	go=setInterval(running,100);
}


function stop() {
	
	clearInterval(go);
	
}

function getNeighborsNumber(index) {
	
	var x=Math.floor(index/row);
	var y=Math.floor(index%row);
	var neighbor=0;
	
	
	if(x-1>=0 && y-1>=0 && table[(x-1)*row+(y-1)])
	neighbor++;
	if(x-1>=0 && table[(x-1)*row+y])
	neighbor++;
	if(x-1>=0 && y+1<row && table[(x-1)*row+(y+1)])
	neighbor++;
	if(y+1<row && table[x*row+(y+1)])
	neighbor++;
	if(x+1<row && y+1<row && table[(x+1)*row+(y+1)])
	neighbor++;
	if(x+1<row && table[(x+1)*row+y])
	neighbor++;
	if(x+1<row && y-1>=0 && table[(x+1)*row+(y-1)])
	neighbor++;
	if(y-1>=0 && table[x*row+(y-1)])
	neighbor++;
		
	return neighbor;
	
	
}


function evaluateCell(index) {

		
		var neighbor=getNeighborsNumber(index);
		
		
		if(table[index] && (neighbor==2 || neighbor==3)) {
			
			hostTable[index]=true;
			
		}
		else if(table[index] && (neighbor>3 || neighbor<2)) {
			
			hostTable[index]=false;
			
		}
		else if(!table[index] && neighbor==3) {
			
			hostTable[index]=true;
			
		}
		
	}
	


if(bad){
	
	alert("Invalid input value!");
}


function isStop() {
	
	var j=0;
	
	while(i<table.length){
		
		if((table[i] && hostTable[i]) || (!table[i] && !hostTable[i]))
		j++;
		
		
		i++;
	}
	
	if(j==row*row)
	return true;
	
	
	return false;
}


function exit() {
	
	if(confirm("Would you like to exit?")){

       window.close();

	}    

}
</script>


</body>
</html>