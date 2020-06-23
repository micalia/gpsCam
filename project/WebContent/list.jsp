<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="imgInfo.ImgInfo" %>
<%@ page import="imgInfo.ImginfoDAO" %>
<%@ page import="imgInfo.DayOfWeek" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%
	String zoom = request.getParameter("zoom");
	ArrayList<ImgInfo> list = new ArrayList<ImgInfo>();
	String[] num = request.getParameterValues("num");
	ImginfoDAO imginfoDAO = new ImginfoDAO();
	
	for(int i=0; i < num.length; i++){
		ImgInfo info = imginfoDAO.infoGet(num[i]);
		list.add(info);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="./js/jquery-3.4.1.min.js"></script>
<title>Map Surfing</title>
<style>
html,body{
	height:100%;
	min-height:100% !important;
	width:100%;
	position:absolute;
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
	padding:5px !important;
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
	background-color: #29e2ff;
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
<body style="overflow:hidden;">
	
<div id="topBar"><span class="titleName" onclick="filterNone()">Map Surfing</span><div id="filterBox"  onclick="filterView()"><img src="./img/filterIcon.png" id="filterIcon"></div></div>
<div id="searchBar">
<input type="text" id="searchInput" class="form-control AllsearchInput" placeholder="전체검색" autocomplete="off" onclick="filterNone()">
<input type="submit" class="btn btn-secondary" value="검색" style="border-radius:0px;width:17%;" onclick="realSearch()">
<input type="text" id="keyword" class="form-control searchInput" placeholder="검색결과에서 찾기"  autocomplete="off" onclick="filterNone()">
<!-- <input type="submit" class="btn btn-secondary" value="검색" style="border-radius:0px;width:17%;"> -->
</div>
<div id="filterGlass">
<div id="glassBox" onclick="disappearfilter()" style="display:none;"></div><br><br>
<div id="filterContainer" style="display:none;">
<nav class="navigation">
  <ul class="mainmenu">
    <li><span id="allShow" class="timeselect" onclick="allShow()">전체</span></li>
    <li><span id="todaySort" class="timeselect" onclick="todaySort()">오늘</span></li>
    <li><span id="weekSort" class="timeselect" onclick="weekSort()">이번 주</span></li>
    <li><span id="monthSort" class="timeselect" onclick="monthSort()">이번 달</span></li>
    <li><span id="thisYear" class="timeselect" onclick="thisYear()">올해</span></li>
    <li><span class="directInput">직접입력</span><input type="date" name="startdate" id="startdate" class="form-control termInput" style="width:146px;padding: .375rem 0.25rem;">
    <center>~</center>
    <input type="date" name="enddate" id="enddate" class="form-control termInput" style="width:146px;padding: .375rem 0.25rem;">
    <button class="btn btn-secondary applybtn" onclick="setPeriod()">적용하기</button></li>
  </ul>                                                                                                                                                           
</nav>                                                                                                                                                             
</div>
</div>
<div class="inter-box">
<div class="scroll-box" onclick="filterNone()">
<table id="listBox" class="listBox" border="1" onclick="filterNone()">
<%
String filter = request.getParameter("filter");
if(filter == null){
	filter ="All";
}
SimpleDateFormat format = new SimpleDateFormat ("yyyyMMdd");// 이번주 배열로 불러올 때 필요함
SimpleDateFormat Todayformat = new SimpleDateFormat ("yyyy-MM-dd");// 오늘 날짜 불러올 때 필요함
SimpleDateFormat Monthformat = new SimpleDateFormat ("yyyy-MM");// 오늘 날짜 불러올 때 필요함
SimpleDateFormat yearformat = new SimpleDateFormat ("yyyy");// 오늘 날짜 불러올 때 필요함
Date time = new Date();
		
String timeVal = format.format(time); // 이번주 배열로 불러올 때 필요함
String todayVal = Todayformat.format(time); // 오늘 날짜 불러올 때 필요함
String monthVal = Monthformat.format(time); // 이번 달 불러올 때 필요함
String yearVal = yearformat.format(time); // 이번 달 불러올 때 필요함

%>
<% 
if(filter.equals("All")){
%>
<%for(int i=0; i < list.size(); i++){%>

		<tr>
			<td>	
				<img class="object cover" src="<%= list.get(i).getImg_path().replace("upload","thumbnail") %>" onclick="goImginfo(<%= list.get(i).getNum()%>)">		
			</td>
			<td class="infotd">
				<span><b>날짜</b> : <span class="time"><%= list.get(i).getTime().substring(0,19)%></span></span><br>
				<span><b>제목</b> : <%= list.get(i).getSubject()%></span><br>
				<span><b>내용</b> : <%= list.get(i).getContent()%></span>
			</td>
		</tr>
		<%}%>
<% }else if(filter.equals("today")){%>
<%for(int i=0; i < list.size(); i++){
%>
		<%if(list.get(i).getTime().substring(0,10).equals(todayVal)){ %>
			<tr>
				<td>	
					<img class="object cover" src="<%= list.get(i).getImg_path().replace("upload","thumbnail") %>" onclick="goImginfo(<%= list.get(i).getNum()%>)">		
				</td>
				<td class="infotd">
					<span><b>날짜</b> : <span class="time"><%= list.get(i).getTime().substring(0,19)%></span></span><br>
					<span><b>제목</b> : <%= list.get(i).getSubject()%></span><br>
					<span><b>내용</b> : <%= list.get(i).getContent()%></span>
				</td>
			</tr>
			<%} %>
		<%}%>
<%}else if(filter.equals("week")){
//현재 날짜를 기준으로 이번 주 날짜들을 배열에 담음. 월요일 ~ 일요일
DayOfWeek dayOfWeek = new DayOfWeek();
String[] dayOfWeekArr = dayOfWeek.weekCalendar(timeVal);

	//이번주에 업로드된 정보만 출력
	for(int i=0; i < list.size(); i++){
		for(int z=0; z<dayOfWeekArr.length; z++){
				if(dayOfWeekArr[z].equals(list.get(i).getTime().substring(0,10))){%>
					<tr>
						<td>	
							<img class="object cover" src="<%= list.get(i).getImg_path().replace("upload","thumbnail") %>" onclick="goImginfo(<%= list.get(i).getNum()%>)">		
						</td>
						<td class="infotd">
							<span><b>날짜</b> : <span class="time"><%= list.get(i).getTime().substring(0,19)%></span></span><br>
							<span><b>제목</b> : <%= list.get(i).getSubject()%></span><br>
							<span><b>내용</b> : <%= list.get(i).getContent()%></span>
						</td>
					</tr>
				<%}
			}
	}

}else if(filter.equals("month")){
	for(int i=0; i < list.size(); i++){
		if(monthVal.equals(list.get(i).getTime().substring(0,7))){
%>
					<tr>
						<td>	
							<img class="object cover" src="<%= list.get(i).getImg_path().replace("upload","thumbnail") %>" onclick="goImginfo(<%= list.get(i).getNum()%>)">		
						</td>
						<td class="infotd">
							<span><b>날짜</b> : <span class="time"><%= list.get(i).getTime().substring(0,19)%></span></span><br>
							<span><b>제목</b> : <%= list.get(i).getSubject()%></span><br>
							<span><b>내용</b> : <%= list.get(i).getContent()%></span>
						</td>
					</tr>
<%		}		
	}
}else if(filter.equals("year")){
	for(int i=0; i < list.size(); i++){
		if(yearVal.equals(list.get(i).getTime().substring(0,4))){
%>
					<tr>
						<td>	
							<img class="object cover" src="<%= list.get(i).getImg_path().replace("upload","thumbnail") %>" onclick="goImginfo(<%= list.get(i).getNum()%>)">		
						</td>
						<td class="infotd">
							<span><b>날짜</b> : <span class="time"><%= list.get(i).getTime().substring(0,19)%></span></span><br>
							<span><b>제목</b> : <%= list.get(i).getSubject()%></span><br>
							<span><b>내용</b> : <%= list.get(i).getContent()%></span>
						</td>
					</tr>
<%		}
	}
	
}else if(filter.equals("setPeriod")){
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	Date start_time = dateFormat.parse(startdate);
	Date end_time = dateFormat.parse(enddate);
	
	for(int i=0; i < list.size(); i++){
		Date listTime = dateFormat.parse(list.get(i).getTime().substring(0,10)); // 리스트정보에 날짜를 비교를 위해 형변환
		if(start_time.compareTo(listTime) <= 0 && end_time.compareTo(listTime) >= 0){//시작시간 < 리스트날짜 < 끝날짜
%>
				<tr>
					<td>	
						<img class="object cover" src="<%= list.get(i).getImg_path().replace("upload","thumbnail") %>" onclick="goImginfo(<%= list.get(i).getNum()%>)">		
					</td>
					<td class="infotd">
						<span><b>날짜</b> : <span class="time"><%= list.get(i).getTime().substring(0,19)%></span></span><br>
						<span><b>제목</b> : <%= list.get(i).getSubject()%></span><br>
						<span><b>내용</b> : <%= list.get(i).getContent()%></span>
					</td>
				</tr>
<%
		}
	}
}else{// filter 파라미터가 없으면 전체리스트를 보여줌
%>
<%for(int i=0; i < list.size(); i++){%>

		<tr>
			<td>	
				<img class="object cover" src="<%= list.get(i).getImg_path().replace("upload","thumbnail") %>" onclick="goImginfo(<%= list.get(i).getNum()%>)">		
			</td>
			<td class="infotd">
				<span><b>날짜</b> : <span class="time"><%= list.get(i).getTime().substring(0,19)%></span></span><br>
				<span><b>제목</b> : <%= list.get(i).getSubject()%></span><br>
				<span><b>내용</b> : <%= list.get(i).getContent()%></span>
			</td>
		</tr>
		<%}%>

	<%} %>
</table>
</div>
<input type="button" class="btn btn-primary gomap" onclick="backToMap()" value="지도로 돌아가기" style="height:9%;">
</div>
<div class="image-box">
</div>

<script>
$(document).ready(function() {
    var windowHeight = $(window).innerHeight();
    $('body').css({'height':windowHeight});
});
function filterNone(){
	document.getElementById("filterGlass").style.display="none";
	document.getElementById("glassBox").style.display="none";
	document.getElementById("filterContainer").style.display="none";
}

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
	
	var zoomVal = document.createElement("input");
	zoomVal.setAttribute("type","hidden");
	zoomVal.setAttribute("name","zoom");
	zoomVal.setAttribute("value",<%= zoom%>);
	newForm.appendChild(zoomVal);
	
	var filterVal = document.createElement("input");
	filterVal.setAttribute("type","hidden");
	filterVal.setAttribute("name","filter");
	filterVal.setAttribute("value","<%= filter%>");
	newForm.appendChild(filterVal);
	
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
	newForm.action="mapsurfing.jsp";

	var zoom = document.createElement("input");
	zoom.setAttribute("type","hidden");
	zoom.setAttribute("name","zoom");
	zoom.setAttribute("value",<%= zoom%>);
	newForm.appendChild(zoom);
	
	var input = document.createElement("input");
	input.setAttribute("type","hidden");
	input.setAttribute("name","lat");
	input.setAttribute("value",<%= list.get(0).getLatitude()%>);
	newForm.appendChild(input);
	var input2 = document.createElement("input");
	input2.setAttribute("type","hidden");
	input2.setAttribute("name","lng");
	input2.setAttribute("value",<%= list.get(0).getLongitude()%>);
	newForm.appendChild(input2);
	
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
	var searchInput = document.getElementById("searchInput").value;
	if(searchInput == ""){
		alert("검색 키워드를 입력해주세요");
		return false;
	}
	
	var newForm = document.createElement("form");
	newForm.name = "newForm";
	newForm.method = "post";
	newForm.action="searchlist.jsp";
	
	var searchVal = document.createElement("input");
	searchVal.setAttribute("type","hidden");
	searchVal.setAttribute("name","search");
	searchVal.setAttribute("value", searchInput);
	newForm.appendChild(searchVal);

		document.body.appendChild(newForm);
		newForm.submit();
}

/*		//input type =date로 바꾸면서 필요없어짐
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
		  } */
		
        var temp = $("#listBox > tbody > tr > td:nth-child(2n+2)");
		var currentDay = new Date();  
		var theYear = currentDay.getFullYear();
		var theMonth = currentDay.getMonth();
		var theDate  = currentDay.getDate();
		var theDayOfWeek = currentDay.getDay();
			
		var month = ("0" + (theMonth + 1)).slice(-2);
		var todayVal = theYear + "-" + month + "-" + theDate;
		//현재 날짜 값을 필터에 시작날짜, 끝날짜에 넣어줌
		var selectDate = theYear + month + theDate; //weekSort()메소드에서 사용
		
		var monthVal = theYear + "-" + month; //monthSort()메소드에 사용
		Date.prototype.toDateInputValue = (function() {
		    var local = new Date(this);
		    local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
		    return local.toJSON().slice(0,10);
		});
		document.getElementById("startdate").value = new Date().toDateInputValue();
		document.getElementById("enddate").value = new Date().toDateInputValue();
		
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
		
		function todaySort(){
			document.getElementById("filterGlass").style.display="none";
			document.getElementById("glassBox").style.display="none";
			document.getElementById("filterContainer").style.display="none";
			for(i=0; i < document.getElementsByClassName("timeselect").length; i++){
				document.getElementsByClassName("timeselect")[i].style.backgroundColor="";
			}
			document.getElementById("todaySort").style.backgroundColor="#d1d1d1";
			var showNum = [];
			
			for(i=0; i<temp.length; i++){
				if($(temp[i]).find(".time").html().substring(0,10) == todayVal){
					showNum[i] = i;
				}
			}
			
			$("#listBox > tbody > tr").hide();
			for(i = 0; i < showNum.length; i ++){
		        $(temp[showNum[i]]).parent().show();
		        	
		        }
		}
		
		function weekSort(){
			document.getElementById("filterGlass").style.display="none";
			document.getElementById("glassBox").style.display="none";
			document.getElementById("filterContainer").style.display="none";
			for(i=0; i < document.getElementsByClassName("timeselect").length; i++){
				document.getElementsByClassName("timeselect")[i].style.backgroundColor="";
			}
			document.getElementById("weekSort").style.backgroundColor="#d1d1d1";

			var year  = selectDate.substring(0,4); //선택된 년도
		    var month = selectDate.substring(4,6); //선택된 월
		    var day   = selectDate.substring(6,8); //선택된 일자
		    var week  = new Array("", "월", "화", "수", "목", "금", "토", "일");  // 아래 코드에서는 사용하지 않음
		    // 보통 0~6 까지가 일~토로 표현된다 하지만 월요일부터 표현하기 위해 0번째를 공백처리
			var currentDay = new Date(year, month-1, day);  
			var theDayOfWeek = currentDay.getDay();        // 요일을 숫자로 구해옴

			// 선택한 날이 일요일 일때 전주의 날짜를 담음
			 if(theDayOfWeek == 0){		 
				 var currentDay = new Date(year, month-1, day-7);  		 
			 }	 
			 var theYear = currentDay.getFullYear();
			 var theMonth = currentDay.getMonth();
			 var theDate  = currentDay.getDate();
			 var thisWeek = [];
			 
			 for(var i=1; i<8; i++) {
			   var resultDay = new Date(theYear, theMonth, theDate + (i - theDayOfWeek));
			   var yyyy = resultDay.getFullYear();
			   var mm = Number(resultDay.getMonth()) + 1;
			   var dd = resultDay.getDate();
			   var dd_nm = resultDay.getDay();

			   mm = String(mm).length === 1 ? '0' + mm : mm;
			   dd = String(dd).length === 1 ? '0' + dd : dd;
			  
			//월요일부터 화, 수 ~ 일요일까지 날짜를 담음
			   thisWeek[i] = yyyy + '-' + mm + '-' + dd;

			   if(i==1){
				  // 검색기준 월요일
			   }else if(i==7){
				  // 검색기준 일요일
			   }	   

			 }
			 thisWeek.splice(0,1);
			 
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
				if($(temp[i]).find(".time").html().substring(0,7) == monthVal){
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
			/*var startInput = document.getElementById("startdate");
			var endInput = document.getElementById("enddate");
			
			 input type =date로 바꾸고 필요 없어짐 
			if(checkdate(startInput) == false){
				return false;
			}
			if(checkdate2(endInput) == false){
				return false;
			} */
			document.getElementById("filterGlass").style.display="none";
			document.getElementById("glassBox").style.display="none";
			document.getElementById("filterContainer").style.display="none";
			
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