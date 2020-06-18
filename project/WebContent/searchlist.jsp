<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="imgInfo.ImgInfo" %>
<%@ page import="imgInfo.ImginfoDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	String search = request.getParameter("search");
	ImginfoDAO imginfoDAO = new ImginfoDAO();
	
	ArrayList<ImgInfo> list = imginfoDAO.search(search);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="./js/jquery-3.4.1.min.js"></script>
<title>history view</title>
<style>
html,body{
	height:100%;
	min-height:100% !important;
	width:100%;
}
body{
	margin:0px;
	padding:0px;
}
.listBox{
	border-collapse:collapse;
    margin-top: 124px;
}
.object{
	height:130px;
	width:130px;
	display:block;
}
.cover{
	object-fit:cover;
}
.cover:hover{
	cursor:pointer;
}
.listBox td{
	padding:0px;
}
.infotd{
	width:100%;
	vertical-align:baseline;
}
.gomap{
	width:100%;
	height:8%;
	border-radius:0px;
}
.scroll-box{
	overflow:auto;
	height:92%;
}
.inter-box{
	height:100%;
}
.image-box{
	width:100%;
	height:100%;
	background:rgba(0,0,0,0.5);
	padding-top:80px;
	z-index:2;
	position:absolute;
	display:none;
}
#topBar{
	background-color: black;
	position: absolute;
	z-index:2;
	width:100%;
	height:48px;
	display:table;
}
.titleName{
	color:white;
	display:table-cell;
	vertical-align:middle;
	font-size:24px;
	padding-left:11px;
	width:100%;
}
#searchBar{
	background:white;
	position:absolute;
	z-index:2;
	width:100%;
	margin-top:48px;
}
.searchInput{
 	border-radius:0px; 
 	float:left;
 	width:100%;
}
.AllsearchInput{
 	border-radius:0px; 
 	float:left;
 	width:83%;
}
#filterBox{
	height:100%;
	position:relative;
	width:45px;
	float:right;
}
#filterIcon{
	position:absolute;
	max-width:100%;
	max-height:100%;
	width:auto;
	height:auto;
	margin:auto;
	top:0;
	bottom:0;
	left:0;
	right:0;
}
#filterContainer{
	position:relative;
    float: right;
    z-index: 4;
    width: 132px;
    border: 1px solid gray;
    background: white;
}
#filterGlass{
	position:absolute;
	right:0px;
}
#glassBox{
    position: relative;
    float: right;
    z-index: 3;
    width: 45px;
    height: 48px;
}

.navigation {
  width: 100%;
}

.mainmenu {
  list-style: none;
  padding: 0;
  margin: 0;
}

.timeselect {
  display: block;
  background-color: white;
  text-decoration: none;
  padding: 10px;
  color: #000;
}

.timeselect:hover {
    background-color: #d1d1d1;
}

.mainmenu li:hover .submenu {
  display: block;
  max-height: 200px;
}
.termInput{
	width: 110px;
    margin: 0 auto;
}
.directInput{
  display: block;
  background-color: white;
  text-decoration: none;
  padding: 10px;
  color: #000;
}
.applybtn{
	border-radius:0px;
	width:100%;
	margin-top:10px;
}
</style>
</head>
<body>

<div id="topBar"><span class="titleName">History View</span><div id="filterBox" onclick="filterView()"><img src="./img/filterIcon.png" id="filterIcon"></div></div>
<div id="searchBar">
<input type="text" id="searchInput" class="form-control AllsearchInput" placeholder="전체검색">
<input type="submit" class="btn btn-secondary" value="검색" style="border-radius:0px;width:17%;" onclick="realSearch()">
<input type="text" id="keyword" class="form-control searchInput" placeholder="검색결과에서 찾기">
<!-- <input type="submit" class="btn btn-secondary" value="검색" style="border-radius:0px;width:17%;"> -->
</div>
<div id="filterGlass">
<div id="glassBox" onclick="disappearfilter()" style="display:none;"></div><br><br>
<div id="filterContainer" style="display:none;">
<nav class="navigation">
  <ul class="mainmenu">
    <li><span id="allShow" class="timeselect" onclick="allShow()">전체</span></li>
    <li><span id="weekSort" class="timeselect" onclick="weekSort()">이번 주</span></li>
    <li><span id="monthSort" class="timeselect" onclick="monthSort()">이번 달</span></li>
    <li><span id="thisYear" class="timeselect" onclick="thisYear()">올해</span></li>
    <li><span class="directInput">직접입력</span><input type="text" name="startdate" id="startdate" class="form-control termInput" onkeyup="date_mask(this.name);">
    <center>~</center>
    <input type="text" name="enddate" id="enddate"class="form-control termInput" onkeyup="date_mask2(this.name);">
    <button class="btn btn-secondary applybtn" onclick="setPeriod()">적용하기</button></li>
  </ul>
</nav>
</div>
</div>
<div class="inter-box">
<div class="scroll-box">
<table id="listBox" class="listBox" border="1" >
<%
	for(int i=0; i < list.size(); i++){%>
		<tr>
			<td>	
				<img class="object cover" src="<%= list.get(i).getImg_path().replace("upload","thumbnail") %>" onclick="goImginfo(<%= list.get(i).getNum()%>)">		
			</td>
			<td class="infotd">
				<span>날짜 : <span class="time"><%= list.get(i).getTime().substring(0,19)%></span></span><br>
				<span>제목 : <%= list.get(i).getSubject()%></span><br>
				<span>내용 : <%= list.get(i).getContent()%></span>
			</td>
		</tr>
		<%}%>
</table>
</div>
<input type="button" class="btn btn-primary gomap" onclick="backToMap()" value="지도로 돌아가기">
</div>
<div class="image-box">
</div>
<script>
function goImginfo(gonum){
	var newForm = document.createElement("form");
	newForm.name = "newForm";
	newForm.method = "post";
	newForm.action="imginfo.jsp";
	
	var num = document.createElement("input");
	num.setAttribute("type","hidden");
	num.setAttribute("name","num");
	num.setAttribute("value",gonum);
	newForm.appendChild(num);
	
<%
	for(int i=0; i < list.size(); i++){
%>
	var backnum = document.createElement("input");
	backnum.setAttribute("type","hidden");
	backnum.setAttribute("name","backnum");
	backnum.setAttribute("value",<%= list.get(i).getNum() %>);
	newForm.appendChild(backnum);
	
	<%}%>
	
	document.body.appendChild(newForm);
	newForm.submit();
}
function backToMap(){
	var newForm = document.createElement("form");
	newForm.name = "newForm";
	newForm.method = "post";
	newForm.action="historyView.jsp";
	
	document.body.appendChild(newForm);
	newForm.submit();
}

function filterView(){
	document.getElementById("filterGlass").style.display="block";
	document.getElementById("glassBox").style.display="block";
	document.getElementById("filterContainer").style.display="block";
}

function disappearfilter(){
	document.getElementById("filterGlass").style.display="none";
	document.getElementById("glassBox").style.display="none";
	document.getElementById("filterContainer").style.display="none";
	
}

$(document).ready(function() {
    $("#keyword").keyup(function() {
        var k = $(this).val();
        $("#listBox > tbody > tr").hide();
        var temp = $("#listBox > tbody > tr > td:nth-child(2n+2):contains('" + k + "')");
        $(temp).parent().show();
    });
});

function realSearch(){
	var newForm = document.createElement("form");
	newForm.name = "newForm";
	newForm.method = "post";
	newForm.action="searchlist.jsp";
	
	var searchVal = document.createElement("input");
	searchVal.setAttribute("type","hidden");
	searchVal.setAttribute("name","search");
	searchVal.setAttribute("value", document.getElementById("searchInput").value);
	newForm.appendChild(searchVal);

		document.body.appendChild(newForm);
		newForm.submit();
}


function date_mask(textid) {
	var text = eval(textid);
	var textlength = text.value.length;

		if (textlength == 4) {
		text.value = text.value + "-";
		} else if (textlength == 7) {
		text.value = text.value + "-";
		} else if (textlength > 9) {
		//날짜 수동 입력 Validation 체크
		var chk_date = checkdate(text);
		
			if (chk_date == false) {
				return false;
			}
		}
	} 

	function checkdate(input) {
	   var validformat = /^\d{4}\-\d{2}\-\d{2}$/; //Basic check for format validity
	   var returnval = false;
	   if (!validformat.test(input.value)) {
	    alert("날짜 형식이 올바르지 않습니다. YYYY-MM-DD");
	    document.getElementById("startdate").select();
	    return false;
	   } else { //Detailed check for valid date ranges
	    var yearfield = input.value.split("-")[0];
	    var monthfield = input.value.split("-")[1];
	    var dayfield = input.value.split("-")[2];
	    var dayobj = new Date(yearfield, monthfield - 1, dayfield);
	   }
	   if ((dayobj.getMonth() + 1 != monthfield)
	     || (dayobj.getDate() != dayfield)
	     || (dayobj.getFullYear() != yearfield)) {
	    alert("날짜 형식이 올바르지 않습니다. YYYY-MM-DD");
	    document.getElementById("startdate").select();
	    return false;
	   } else {
	    //alert ('Correct date');
	    returnval = true;
	   }
	   if (returnval == false) {
	    input.select();
	   }
	   return returnval;
	  }
	
	function date_mask2(textid) {
		var text = eval(textid);
		var textlength = text.value.length;

			if (textlength == 4) {
			text.value = text.value + "-";
			} else if (textlength == 7) {
			text.value = text.value + "-";
			} else if (textlength > 9) {
			//날짜 수동 입력 Validation 체크
			var chk_date = checkdate2(text);
			
				if (chk_date == false) {
					return false;
				}
			}
		} 

		function checkdate2(input) {
		   var validformat = /^\d{4}\-\d{2}\-\d{2}$/; //Basic check for format validity
		   var returnval = false;
		   if (!validformat.test(input.value)) {
		    alert("날짜 형식이 올바르지 않습니다. YYYY-MM-DD");
		    document.getElementById("enddate").select();
		    return false;
		   } else { //Detailed check for valid date ranges
		    var yearfield = input.value.split("-")[0];
		    var monthfield = input.value.split("-")[1];
		    var dayfield = input.value.split("-")[2];
		    var dayobj = new Date(yearfield, monthfield - 1, dayfield);
		   }
		   if ((dayobj.getMonth() + 1 != monthfield)
		     || (dayobj.getDate() != dayfield)
		     || (dayobj.getFullYear() != yearfield)) {
		    alert("날짜 형식이 올바르지 않습니다. YYYY-MM-DD");
		    document.getElementById("enddate").select();
		    return false;
		   } else {
		    returnval = true;
		   }
		   if (returnval == false) {
		    input.select();
		   }
		   return returnval;
		  }
		
        var temp = $("#listBox > tbody > tr > td:nth-child(2n+2)");
		var currentDay = new Date();  
		var theYear = currentDay.getFullYear();
		var theMonth = currentDay.getMonth();
		var theDate  = currentDay.getDate();
		var theDayOfWeek = currentDay.getDay();
		
		function allShow(){
			document.getElementById("filterGlass").style.display="none";
			document.getElementById("glassBox").style.display="none";
			document.getElementById("filterContainer").style.display="none";
			for(i=0; i < document.getElementsByClassName("timeselect").length; i++){
				document.getElementsByClassName("timeselect")[i].style.backgroundColor="";
			}
			document.getElementById("allShow").style.backgroundColor="#d1d1d1";
	        $(temp).parent().show();
		}
		
		function weekSort(){
			document.getElementById("filterGlass").style.display="none";
			document.getElementById("glassBox").style.display="none";
			document.getElementById("filterContainer").style.display="none";
			for(i=0; i < document.getElementsByClassName("timeselect").length; i++){
				document.getElementsByClassName("timeselect")[i].style.backgroundColor="";
			}
			document.getElementById("weekSort").style.backgroundColor="#d1d1d1";
			var thisWeek = [];
			 
			for(var i=0; i<7; i++) {
			  var resultDay = new Date(theYear, theMonth, theDate + (i - theDayOfWeek));
			  var yyyy = resultDay.getFullYear();
			  var mm = Number(resultDay.getMonth()) + 1;
			  var dd = resultDay.getDate();
			 
			  mm = String(mm).length === 1 ? '0' + mm : mm;
			  dd = String(dd).length === 1 ? '0' + dd : dd;
			 
			  thisWeek[i] = yyyy + '-' + mm + '-' + dd;
			}
			
			
			var showNum = [];
			for(i=0; i<temp.length; i++){
				for(j=0; j < thisWeek.length; j++){
					if($(temp[i]).find(".time").html().substring(0,10) == thisWeek[j]){
						showNum[i] = i;
					}
				}
			} 
			 
			 $("#listBox > tbody > tr").hide();
		        for(i = 0; i < showNum.length; i ++){
		        $(temp[showNum[i]]).parent().show();
		        	
		        }
		
		}
		
		var month = ("0" + (theMonth + 1)).slice(-2);
		
		function monthSort(){
			document.getElementById("filterGlass").style.display="none";
			document.getElementById("glassBox").style.display="none";
			document.getElementById("filterContainer").style.display="none";
			for(i=0; i < document.getElementsByClassName("timeselect").length; i++){
				document.getElementsByClassName("timeselect")[i].style.backgroundColor="";
			}
			document.getElementById("monthSort").style.backgroundColor="#d1d1d1";
			var showNum = [];
			
			for(i=0; i<temp.length; i++){
				if($(temp[i]).find(".time").html().substring(5,7) == month){
					showNum[i] = i;
				}
			}
			
			$("#listBox > tbody > tr").hide();
			for(i = 0; i < showNum.length; i ++){
		        $(temp[showNum[i]]).parent().show();
		        	
		        }
		}
		
		function thisYear(){
			document.getElementById("filterGlass").style.display="none";
			document.getElementById("glassBox").style.display="none";
			document.getElementById("filterContainer").style.display="none";
			for(i=0; i < document.getElementsByClassName("timeselect").length; i++){
				document.getElementsByClassName("timeselect")[i].style.backgroundColor="";
			}
			document.getElementById("thisYear").style.backgroundColor="#d1d1d1";
			var showNum = [];

			for(i=0; i<temp.length; i++){
				 if($(temp[i]).find(".time").html().substring(0,4) == theYear){
					showNum[i] = i;
				} 
			}
			
			$("#listBox > tbody > tr").hide();
			for(i = 0; i < showNum.length; i ++){
		        $(temp[showNum[i]]).parent().show();
		        	
		        }
		}
		
		function setPeriod(){
			document.getElementById("filterGlass").style.display="none";
			document.getElementById("glassBox").style.display="none";
			document.getElementById("filterContainer").style.display="none";
			
			if(date_mask("startdate") == false){
				return false;
			}
			if(date_mask2("enddate") == false){
				return false;
			}
			var start = document.getElementById("startdate").value;
			var end = document.getElementById("enddate").value;
			
			start = start + " 00:00:00";
			end = end + " 23:59:59";
			
			if(start > end){
				alert("시간 설정을 다시해주세요");
				return false;
			}
			
			for(i=0; i < document.getElementsByClassName("timeselect").length; i++){
				document.getElementsByClassName("timeselect")[i].style.backgroundColor="";
			}
			
			var showNum = [];
			for(i=0; i<temp.length; i++){
					if($(temp[i]).find(".time").html() > start && $(temp[i]).find(".time").html() < end){
						showNum[i] = i;
				}
			} 
			 
			 $("#listBox > tbody > tr").hide();
		        for(i = 0; i < showNum.length; i ++){
		        $(temp[showNum[i]]).parent().show();
		        }
			
		}
</script>
</body>
</html>