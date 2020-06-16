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
    margin-top: 86px;
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

.mainmenu a {
  display: block;
  background-color: white;
  text-decoration: none;
  padding: 10px;
  color: #000;
}

.mainmenu a:hover {
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
<div id="searchBar"><input type="text" id="keyword" class="form-control searchInput" placeholder="검색결과에서 찾기"><!-- <input type="submit" class="btn btn-secondary" value="검색" style="border-radius:0px;width:17%;"> --></div>
<div id="filterGlass">
<div id="glassBox" onclick="disappearfilter()" style="display:none;"></div><br><br>
<div id="filterContainer" style="display:none;">
<nav class="navigation">
  <ul class="mainmenu">
    <li><a href="">전체</a></li>
    <li><a href="">이번 주</a></li>
    <li><a href="">이번 달</a></li>
    <li><a href="">올해</a></li>
    <li><span class="directInput">직접입력</span><input type="text" class="form-control termInput"><center>~</center><input type="text" class="form-control termInput">
    <button class="btn btn-secondary applybtn">적용하기</button></li>
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
				<span>날짜 : <%= list.get(i).getTime().substring(0,19)%></span><br>
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
</script>
</body>
</html>