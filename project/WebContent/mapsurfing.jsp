<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="imgInfo.ImginfoDAO" %>
<%@ page import="imgInfo.ImgInfo" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<script src="./js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ufu00uecjo&submodules=geocoder"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

<title>Map Surfing</title>
<style>
@import "compass/css3";

html,
body{
	min-height:100% !important;
	width:100%;
	height:100%;
	position:absolute;
}

.circle {
 background: red;
  width: 86px;
  height: 86px;
  position:absolute;
  top:-43px;
  left:-43px;
  margin: auto;
  border-radius: 100%;
  overflow: hidden;
}
.circle {
  -webkit-animation:grow 2.8s infinite;
}
@-webkit-keyframes grow {
 0% {
-webkit-transform: scale( 0.2 );-moz-transform: scale( 0 .2);-o-transform: scale( 0.2 );-ms-transform: scale( 0.2 );transform: scale( 0.2 );
  } 
  50% {
  -webkit-transform: scale( 0.14 );-moz-transform: scale( 0.14 );-o-transform: scale( 0.14 );-ms-transform: scale( 0.14 );transform: scale( 0.14 );
  }  
  100% {
  -webkit-transform: scale( 0.2);-moz-transform: scale( 0.2 );-o-transform: scale( 0.2 );-ms-transform: scale( 0.2 );transform: scale( 0.2 );
  }
}

#img{
	display:none;
}
.image-box{
	width:100%;
	height:100%;
	z-index:3;
	position:absolute;
	display:none;
}
.uploadImg{
	max-width:100%;
	max-height:100%;
	height:auto;
}
.imgContainer{
	width:316px;
	margin:0 auto;
	height:300px;
	line-height:285px;
	text-align:center;
}
.imgContainer>*{
	vertical-align:middle;
}
.btn-box{
	text-align:center;
	margin-top:17px;
}
.marSpan{
	margin:38px;
}
#map{
	z-index:1;
}
/* .getShowM{
  background: #4287f5;
  width: 34px;
  height: 34px;
  margin: auto;
  border-radius: 100%;
  overflow: hidden;
  position: absolute;
  top: 41px;
  left: 2px;
} */
#interBox{
	width:91%;
	height:96%;
	border:solid 1px #333;
	background-color:#fff;
	/* padding:5px; */
	margin:0 auto;
	left: 50%;
    top: 50%;
    position: absolute;
    transform: translate(-50%, -50%);
    /* overflow:auto; */
    -webkit-overflow-scrolling: touch;
    border-radius:15px;
}
#imgList{
	width:100%;
	position:absolute;
	z-index:100;
	margin:0;
	padding:0;
	display:none;
}
#listContainer{
	width:100%;
	height:100%;
	background:rgba(0,0,0,0.5);
	z-index:3;
	position: absolute;
	display:none;
}
.liimgstyle{
     overflow: hidden;
     display: flex;
     align-items: center;
     justify-content: center;
     width:100%;
     height:auto;
   /*   width: 815px;
     height: 815px; */
}
.list-area{
	/* padding-left:17px;
	padding-right:17px; */
	border: 3px solid #c4c4c4;
}
#realList{
	float:right;
}
#realList li{
	margin-top:46px;
	margin-bottom:46px;
}
.lidate-str{
	font-size:20px;
}
.search{
	position: absolute;
	z-index:2;
	bottom:0px;
	padding-bottom:26px;
	padding-left:14px;
	padding-right:14px;
	width:100%;
}
.searchMarker{
	width:30px;
	height:44px;
	position:absolute;
	bottom:0px;
	left:-15px;
}
#address{
	width:80%;
	float:left;
	font-size:22px;
    padding-top: 3px;
    padding-bottom: 3px;
    border-radius: 0px;
}
#search-btn{
	width:20%;
	font-size:22px;
	padding-top: 3px;
    padding-bottom: 3px;
    border-radius: 0px;
}
#closeList{
	float: right;
    width: 100%;
    height: 8%;
    border-bottom-left-radius: 15px;
    border-bottom-right-radius: 15px;
    border-top-left-radius: 0px;
    font-size: 24px;
    border-top-right-radius: 0px;
}
.scroll-box{
    overflow: auto;
    height: 92%;
}
.gpsIcon{
	width:60px;
	position: absolute;
	z-index:2;
	left:14px;
	bottom:36px;
}
.camIcon{
	width:60px;
	position:absolute;
	z-index:2;
	bottom:41px;
	right:14px;
}
#loadingBox{
	width:100%;
	height:100%;
	z-index:4;
	position: absolute;
	display:none;
	background:rgba(0,0,0,0.4);
}


.flexbox{
    margin: 0 auto;
    left: 50%;
    top: 50%;
    position: absolute;
    transform: translate(-50%, -50%);
}


.flexbox > div {
  width: 150px;
  height: 150px;
  -webkit-box-flex: 0;
  -ms-flex: 0 0 25%;
  flex: 0 0 25%;
 /*  border: 1px solid black; */
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  margin: 0;
  position: relative;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-pack: center;
  -ms-flex-pack: center;
  justify-content: center;
  -webkit-box-align: center;
  -ms-flex-align: center;
  align-items: center;
  overflow: hidden;
}




/* CIRCLE DOT LOADER */

.circle-loader {
  position: relative;
  width: auto;
  height: auto;
}

.circle-loader div {
  height: 10px;
  width: 10px;
  background-color: #f44336;
  border-radius: 50%;
  position: absolute;
  -webkit-animation: 0.8s opaque ease-in-out infinite both;
  animation: 0.8s opaque ease-in-out infinite both;
}

.circle-loader > div:nth-child(1) {
  top: -25px;
  left: 0;
}
.circle-loader > div:nth-child(2) {
  top: -17px;
  left: 17px;
  -webkit-animation-delay: 0.1s;
  animation-delay: 0.1s;
}
.circle-loader > div:nth-child(3) {
  top: 0;
  left: 25px;
  -webkit-animation-delay: 0.2s;
  animation-delay: 0.2s;
}
.circle-loader > div:nth-child(4) {
  top: 17px;
  left: 17px;
  -webkit-animation-delay: 0.3s;
  animation-delay: 0.3s;
}
.circle-loader > div:nth-child(5) {
  top: 25px;
  left: 0;
  -webkit-animation-delay: 0.4s;
  animation-delay: 0.4s;
}
.circle-loader > div:nth-child(6) {
  top: 17px;
  left: -17px;
  -webkit-animation-delay: 0.5s;
  animation-delay: 0.5s;
}
.circle-loader > div:nth-child(7) {
  top: 0;
  left: -25px;
  -webkit-animation-delay: 0.6s;
  animation-delay: 0.6s;
}
.circle-loader > div:nth-child(8) {
  top: -17px;
  left: -17px;
  -webkit-animation-delay: 0.7s;
  animation-delay: 0.7s;
}


@-webkit-keyframes opaque {
  0% {
    opacity: 0.1;
  }
  40% {
    opacity: 1;
  }
  80% {
    opacity: 0.1;
  }
  100% {
    opacity: 0.1;
  }
}

@keyframes opaque {
  0% {
    opacity: 0.1;
  }
  40% {
    opacity: 1;
  }
  80% {
    opacity: 0.1;
  }
  100% {
    opacity: 0.1;
  }
}


@media only screen and (max-width: 968px) {
  .flexbox > div {
    -webkit-box-flex: 0;
    -ms-flex: 0 0 33.3333333%;
    flex: 0 0 33.3333333%;
  }
}

@media only screen and (max-width: 768px) {
  .flexbox > div {
    -webkit-box-flex: 0;
    -ms-flex: 0 0 50%;
    flex: 0 0 50%;
  }
}

@media only screen and (max-width: 568px) {
  .flexbox > div {
    -webkit-box-flex: 0;
    -ms-flex: 0 0 100%;
    flex: 0 0 100%;
  }
}

.pinMarker{
	width: 20px;
    position: absolute;
    top: 18px;
    left: 9px;
}

#img-subject{
	margin: 0 auto;
    display: block;
    margin-top: 19px;
    width: 316px;
}
#img-content{
	margin: 0 auto;
    display: block;
    margin-top: 19px;
    width: 316px;
    height:136px;
}

.textcountbox{
	overflow:hidden;
	width: 316px;
	margin:0 auto;
}
#topBar{
	background-color: #29e2ff;
	position: absolute;
	z-index:2;
	width:100%;
	height:48px;
	display:table;
	table-layout: fixed;
}
.titleName{
	color:white;
	display:table-cell;
	vertical-align:middle;
	font-size:24px;
	padding-left:11px;
	width:100%;
}
#searchBox{
	height:100%;
	position:relative;
	width:45px;
	float:right;
	display: inline-block;
}
#searchIcon{
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
#changeSearch{
	display: table-cell;
    vertical-align: middle;
    width:100%;
}
.searchStyle{
    border-radius: 0px;
}
#backFlow{
    width: 39px;
}
.inlineBox{
    height: 100%;
    display:flex;
}
#backFlow{
    height: 100%;
    position: relative;
    width:49px;
}
.backArrowCss{
	position:absolute;
	max-width:100%;
	max-height:100%;
	width:24px;
	height:auto;
	margin:auto;
	top:0;
	bottom:0;
	left:0;
	right:0;
}
#searchModeBox{
	position:absolute;
	z-index:2;
	height:100%;
	width:100%;
	background:rgba(0,0,0,0.9);
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
#filterBox{
	height:100%;
	position:relative;
	width:45px;
	float:right;
	display: inline-block;
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
    width: 150px;
    border: 1px solid gray;
    background: white;
}
#uploadBox{
	height:100%;
	padding-top: 80px;
    background: rgba(0,0,0,0.9);
}
/* .AllContainer{
	position:fixed;
	top:0px;
	left:0px; 
	min-height:100%;
	width:100%;
} */
.filterSearch{
    display: table-cell;
    width: 92px;
}
</style>
</head>
<body>

<div id="topBar"><div id="changeSearch" onclick="filterNone()"><span class="titleName">Map Surfing</span></div>
	<div class="filterSearch">
		<div id="filterBox" onclick="filterView()"><img src="./img/filterIcon.png" id="filterIcon"></div>
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
		<div id="searchBox" onclick="changeSearch()"><img src="./img/searchIcon.png" id="searchIcon"></div>
	</div>
</div>
<div class="image-box"></div>
<div id="loadingBox">
	<div class="flexbox">
		  <div>
			    <div class="circle-loader">
			      <div></div>
			      <div></div>
			      <div></div>
			      <div></div>
			      <div></div>
			      <div></div>
			      <div></div>
			      <div></div>
			    </div>
		  </div>
  </div>
</div>
<div id="map" style="width:100%;height:100%;" onclick="filterNone()">
<!-- <div class="search"> 2020-06-14 검색바 위로 뺄거임. 일단 주석 
	<input type="text" id="address" class="form-control" autocomplete="off"><input type="button" id="search-btn" class="btn btn-secondary" value="검색">
</div> -->
<!-- <div id="listContainer">

</div> -->

<img src="./img/gps_icon.png" class="gpsIcon" onclick="myPosition()">
<form id="imageFrm" method="post" enctype="multipart/form-data">
		<label for="img"><img src="./img/cam_icon.png" id="camIcon" class="camIcon"></label>
		<input type="file" name="img" accept="image/*" id="img">
		<input type="hidden" id="latV" name ="latitude" value="">
		<input type="hidden" id="lngV" name ="longitude" value=""></form>
		<div id="searchModeBox" onclick="backFlow()" style="display:none;"></div>
</div>
<input type="hidden" id="lat">
<input type="hidden" id="lng">

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

var camIcon = document.getElementById("img");

camIcon.addEventListener('change', function(event){
	document.getElementsByClassName("image-box")[0].style.display="block";
	readURL(document.getElementById('img'));
});
var map = new naver.maps.Map('map', {
	zoom: 20,
	logoControlOptions: {
		position: naver.maps.Position.TOP_LEFT
		},
	scaleControlOptions: {
        position: naver.maps.Position.TOP_RIGHT
    }
	});
	

	    
	/* var locationBtnHtml = '<form id="imageFrm" method="post" enctype="multipart/form-data"> \n'
		+ '<label for="img"><img src="./img/cam_icon.png" class="camIcon"></label> \n'
		+ '<input type="file" name="img" accept="image/*" id="img">'
		+ '<input type="hidden" id="latV" name ="latitude" value="">'
		+ '<input type="hidden" id="lngV" name ="longitude" value=""></form>'; 
	//camera 찍으면 미리보기 보여주기  START */
		function readURL(input) {
		    if (input.files && input.files[0]) {
		    var reader = new FileReader();

		    reader.onload = function (e) {
		    		$(".image-box").html('<div id="uploadBox"><div class="imgContainer"><img id ="blah" src="'+ e.target.result +'" class="uploadImg"></div>'+
		    						'<input type="text" id="img-subject" name="subject" class="form-control" placeholder="제목 *검색기능에 사용됩니다" maxlength="20">'+
		    						'<div class="textcountbox"><textarea id="img-content" name="content" class="form-control" placeholder="내용 100자 제한 *검색기능에 사용됩니다" maxlength="100"></textarea>'+
		    						'<span style="color:#aaa;float:right;" id="counter">(0 / 200)</span></div>' +
		    				'<div class="btn-box"><button id="cancelUp" class="btn btn-danger btn-lg">취소</button><span class="marSpan"></span><button id="uploadBtn" class="btn btn-primary btn-lg">확인</button></div></div>' +
		    				'<SCRIPT' + '>' +
		    				
		    				'$("#img-content").keyup(function (e){' +
		    				    'var content = $(this).val();' +
		    				   ' $("#counter").html("("+content.length+" / 100)");' + //글자수 실시간 카운팅
		    				    'if (content.length > 100){' +
		    				       ' alert("최대 100자까지 입력 가능합니다.");' +
		    				        '$(this).val(content.substring(0, 100));' +
		    				        '$("#counter").html("(100 / 100)");' +
		    				    '}' +
		    				'});' +
		    				'</SCRIPT' + '>');
		    		var cancelUp = document.getElementById('cancelUp');
		    		cancelUp.addEventListener('click', function(event){
		    	        document.getElementsByClassName("image-box")[0].style.display="none";
		    	        $("#uploadBox").remove();
		    	    });
		    		
		    		var uploadBtn = document.getElementById('uploadBtn');
		    		uploadBtn.addEventListener('click', function(event){
		    			/* var location = new naver.maps.LatLng(position.coords.latitude, position.coords.longitude);
		    			console.log(location) */
		    		var lat = document.getElementById('latV').value;
		    		var lng = document.getElementById('lngV').value;
		    		var sub = document.getElementById('img-subject').value;
		    		var con = document.getElementById('img-content').value;
		    		
		    		if(lat =="" || lng ==""){
		    			alert("위치값을 불러올 수 없습니다.");
		    			return false;
		    		}else if(sub == ""){
		    			alert("제목을 입력해주세요");
		    			document.getElementById('img-subject').focus();
		    			return false;
		    		}else if(con == ""){
		    			alert("내용을 입력해주세요");
		    			document.getElementById('img-content').focus();
		    			return false;
		    		}
		    			document.getElementById("loadingBox").style.display="block";
		    			//navigator.geolocation.getCurrentPosition(success, error);
		    			
					    //document.getElementById('imageFrm').action= "http://110.12.74.87:8080/project/fileUpload.jsp?lat="+ lat +"&lng="+ lng;
					    document.getElementById('imageFrm').action= "http://localhost:8080/project/fileUpload.jsp?lat="+ lat +"&lng="+ lng + "&sub=" + sub + "&con=" + con;
					    
					   //document.getElementById('imageFrm').action= "http://54.180.24.137:8080/project/fileUpload.jsp?lat="+ lat +"&lng="+ lng; 
					   
		    	       document.getElementById('imageFrm').submit(); 
		    	    });
		    		
		        }

		      reader.readAsDataURL(input.files[0]);
		    }
		}
		//camera 찍으면 미리보기 보여주기  END	
	
		/* //camera아이콘 위치 START
		naver.maps.Event.once(map, 'init_stylemap', function() {
	    //customControl 객체 이용하기
	    var customControl = new naver.maps.CustomControl(locationBtnHtml, {
	        position: naver.maps.Position.BOTTOM_RIGHT
	    });

	    customControl.setMap(map);

	    naver.maps.Event.addDOMListener(customControl.getElement(), 'change', function() {
	    	document.getElementsByClassName("image-box")[0].style.display="block";
	    	readURL(document.getElementById('img'));
	    	
	    	//navigator.geolocation.getCurrentPosition(onSuccessGeolocation2, onErrorGeolocation); 
	    });

	});
		//camera아이콘 위치 END
		 */
		
	//마크 겹침 처리 START
	var MarkerOverlapRecognizer = function(opts) { //마커가 겹쳐지는걸 인식함.
	    this._options = $.extend({
	        tolerance: 20, //허용 오차
	       highlightRect: true, //하이라이트 직사각형?
	        highlightRectStyle: {
	            //strokeColor: '#ff0000',//빨간색
	            strokeOpacity: 1,
	            strokeWeight: 2,
	            strokeStyle: 'dot',
	            //strokeStyle: 'black',
	            fillColor: '#ff0000',
	           // fillColor: 'black',
	            fillOpacity: 0.5
	        },
	        intersectNotice: false,//교차 알림
	       intersectNoticeTemplate: '<div style="width:10px;border:solid 1px #333;background-color:#fff;">{{count}}</div>',
	       intersectList: true,
	        intersectListTemplate:'<ul id="liList" style="display:none;">'
	            + '{{#repeat}}'
	            + '<li class="li-data" style="list-style:none;" data-val="{{title}}"></li>'
	            + '{{/#repeat}}'
	            + '</ul>'
	        	+ '<SCRIPT' + '>'
	        	+ '$(document).ready(function(){'
	        		+ 'document.getElementsByClassName("camIcon")[0].style.display="none";'
	        	+ 'var liArray = document.getElementsByClassName("li-data");'
	        	+ 'var ArrayBox = new Array;'
	        		+ 'for(i=0; i<liArray.length; i++){'
	        			+ 'if(liArray[i].dataset.val != ""){'
	        	+ 'var strArray = liArray[i].dataset.val.split(","); '
	        			+ 'ArrayBox.push(strArray);}'
	        			+'}'
	        		
	        		+ 'ArrayBox.sort().reverse();'
	        		
	        		/* + 'for(i=0; i<ArrayBox.length; i++){'
	        			+ '$("#realList").append("<li><div class=\'list-area\'>'
	        					+ '<div class=\'img-area\'><img class=\'liimgstyle\' src=\'"+ ArrayBox[i][1] +"\'></div><span class=\'lidate-str\'>" + ArrayBox[i][0] + "</span></div></li>");'
	        			+ '}'  */
	        			+ 'var newForm = document.createElement("form");'
	        			+ 'newForm.name = "newForm";'
	        			+ 'newForm.method = "post";'
	        			+ 'newForm.action="list.jsp";'
	        			
	        			+ 'var zoomVal = document.createElement("input");'
	        			+ 'zoomVal.setAttribute("type","hidden");'
        				+ 'zoomVal.setAttribute("name","zoom");'
        				+ 'zoomVal.setAttribute("value",map.getZoom());'
        				+ 'newForm.appendChild(zoomVal);'
	        			+ 'for(i=0; i<ArrayBox.length; i++){'
	        				+ 'var input = document.createElement("input");'
	        				+ 'input.setAttribute("type","hidden");'
	        				+ 'input.setAttribute("name","num");'
	        				+ 'input.setAttribute("value",ArrayBox[i][2]);'
	        				+ 'newForm.appendChild(input);'
	        				+ '}'
	        				+ 'document.body.appendChild(newForm);'
	        				+ 'newForm.submit();'
	        		+ ' });'
	        		+ '</SCRIPT' + '>'
        		/* + '<SCRIPT' + '>'
			        + 'var listBox = document.getElementById("listContainer");'
			        + 'listBox.style.display="block";'
			        + '$("#listContainer").html("'
			        + '<div id=\'interBox\'>'
		            + '<div class=\'scroll-box\'><ul id=\'realList\' style=\'list-style:none;margin:0;padding:0;\'></ul></div>'
		            + '<input type=\'button\' value=\'닫기\' class= \'btn btn-primary\'id=\'closeList\' onclick=\'closeList()\'>'	
		            + '</div>'	
					+ '");'
	        	+ '</SCRIPT' + '>' */
	        	
	            + '<SCRIPT' + '>'
	            + 'function closeList(){document.getElementById("listContainer").style.display="none";'
			/* 	+ 'console.log(_.find(map));' */
	            
	                + 'document.getElementsByClassName("camIcon")[0].style.display="block";'
			    + 'map.setOptions({'
		        +	'draggable: true,'
		        +	'pinchZoom: true,'
		        +	'scrollWheel: true,'
		        +	'keyboardShortcuts: true,'
        		+   'disableDoubleTapZoom: true,'
		        +   'disableDoubleClickZoom: true,'
		        +   'disableTwoFingerTapZoom: true'
		        +	'});'
            	
	            	+ '}'
	            + '</SCRIPT' + '>'
	            
	
	    }, opts);

	    this._listeners = [];
	    this._markers = [];

	    this._rectangle = new naver.maps.Rectangle(this._options.highlightRectStyle);//직사각형
	    this._overlapInfoEl = $('<div style="position:absolute;z-index:100;margin:0;padding:0;display:block;border:1px solid yellow;"></div>');
	    this._overlapListEl = $('<div id= "imgList"></div>');//겹쳐진 리스트
	    
	
	};

	/* function ListHide(){
		document.getElementById("imgList").style.display="none";
	} */
/* 	var imgList = document.getElementById("imgList");
	imgList.addEventListener('click', function(event){
		alert("ㅎㅇㅎㅇㅎㅇ");
	});
	 */
	MarkerOverlapRecognizer.prototype = {
		    constructor: MarkerOverlapRecognizer,

		    setMap: function(map) {
		        var oldMap = this.getMap();

		        if (map === oldMap) return;

		        this._unbindEvent();

		        this.hide();

		        if (map) {
		            this._bindEvent(map);
		            this._overlapInfoEl.appendTo(map.getPanes().floatPane);
		            this._overlapListEl.appendTo(map.getPanes().floatPane);
		        }

		        this.map = map || null;
		    },

		    getMap: function() {
		        return this.map;
		    },

		    _bindEvent: function(map) {
		        var listeners = this._listeners,
		            self = this;

		        listeners.push(
		            map.addListener('idle', $.proxy(this._onIdle, this)),
		            map.addListener('click', $.proxy(this._onIdle, this))
		        );

		        this.forEach(function(marker) {
		            listeners = listeners.concat(self._bindMarkerEvent(marker));
		        });
		    },

		    _unbindEvent: function(map_) {
		        var map = map_ || this.getMap();

		        naver.maps.Event.removeListener(this._listeners);
		        this._listeners = [];

		        this._rectangle.setMap(null);
		        this._overlapInfoEl.remove();
		        this._overlapListEl.remove();
		    },

		    add: function(marker) {
		        this._listeners = this._listeners.concat(this._bindMarkerEvent(marker));
		        this._markers.push(marker);
		    },

		    remove: function(marker) {
		        this.forEach(function(m, i, markers) {
		            if (m === marker) {
		                markers.splice(i, 1);
		            }
		        });
		        this._unbindMarkerEvent(marker);
		    },

		    forEach: function(callback) {
		        var markers = this._markers;

		        for (var i=markers.length-1; i>=0; i--) {
		            callback(markers[i], i, markers);
		        }
		    },

		    hide: function() {
		        this._overlapListEl.hide();
		        this._overlapInfoEl.hide();
		        this._rectangle.setMap(null);
		    },

		    _bindMarkerEvent: function(marker) {
		        marker.__intersectListeners = [
		            marker.addListener('mouseover', $.proxy(this._onOver, this)),
		            marker.addListener('mouseout', $.proxy(this._onOut, this)),
		            marker.addListener('mousedown', $.proxy(this._onDown, this))
		        ];

		        return marker.__intersectListeners;
		    },

		    _unbindMarkerEvent: function(marker) {
		        naver.maps.Event.removeListener(marker.__intersectListeners);
		        delete marker.__intersectListeners;
		    },

		    getOverlapRect: function(marker) {
		        var map = this.getMap(),
		            proj = map.getProjection(),
		            position = marker.getPosition(),
		            offset = proj.fromCoordToOffset(position),
		            tolerance = this._options.tolerance || 20,
		            rectLeftTop = offset.clone().sub(tolerance, tolerance),
		            rectRightBottom = offset.clone().add(tolerance, tolerance);

		        return naver.maps.PointBounds.bounds(rectLeftTop, rectRightBottom);
		    },

		    getOverlapedMarkers: function(marker) {
		        var baseRect = this.getOverlapRect(marker),
		            overlaped = [{
		                marker: marker,
		                rect: baseRect
		            }],
		            self = this;

		        this.forEach(function(m) {
		            if (m === marker) return;

		            var rect = self.getOverlapRect(m);

		            if (rect.intersects(baseRect)) {
		                overlaped.push({
		                    marker: m,
		                    rect: rect
		                });
		            }
		        });

		        return overlaped;
		    },

		    _onIdle: function() {
		        this._overlapInfoEl.hide();
		        this._overlapListEl.hide();
		    },

		    _onOver: function(e) {
		        var marker = e.overlay,
		            map = this.getMap(),
		            proj = map.getProjection(),
		            offset = proj.fromCoordToOffset(marker.getPosition()),
		            overlaped = this.getOverlapedMarkers(marker);

		        if (overlaped.length > 1) {
		            if (this._options.highlightRect) {
		                var bounds;

		                for (var i=0, ii=overlaped.length; i<ii; i++) {
		                    if (bounds) {
		                        bounds = bounds.union(overlaped[i].rect);
		                    } else {
		                        bounds = overlaped[i].rect.clone();
		                    }
		                };

		                var min = proj.fromOffsetToCoord(bounds.getMin()),
		                    max = proj.fromOffsetToCoord(bounds.getMax());

		                this._rectangle.setBounds( naver.maps.LatLngBounds.bounds(min, max) );
		                this._rectangle.setMap(map);
		            }

		            if (this._options.intersectNotice) {
		                this._overlapInfoEl
		                    .html(this._options.intersectNoticeTemplate.replace(/\{\{count\}\}/g, overlaped.length))
		                    .css({
		                        left: offset.x,
		                        top: offset.y
		                    })
		                    .show();
		            }
		        } else {
		            this.hide();
		        }
		    },

		    _onOut: function(e) {
		        this._rectangle.setMap(null);
		        this._overlapInfoEl.hide();
		    },

		    _guid: function() {
		        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c){
		            var r = Math.random()*16|0, v = c == "x" ? r : (r&0x3|0x8);
		            return v.toString(16);
		        }).toUpperCase();
		    },

		    _renderIntersectList: function(overlaped, offset) {
		        if (!this._options.intersectList) return;

		        var listLayer = this._overlapListEl;

		        var REPEAT_REGEX = /\{\{#repeat\}\}([\s\S]*)\{\{\/#repeat\}\}/gm,
		            template = this._options.intersectListTemplate,
		            itemTemplate = null,
		            itemPlace = null,
		            matches = REPEAT_REGEX.exec(template),
		            uid = this._guid(),
		            self = this;

		        listLayer.empty();

		        if (matches && matches.length >= 2) {
		            template = template.replace(matches[0], '<div id="intersects-'+ uid +'"></div>');
		            itemTemplate = matches[1];

		            listLayer.append($(template));

		            var placeholder = $('#intersects-'+ uid);

		            itemPlace = placeholder.parent();

		            placeholder.remove();
		            placeholder = null;
		        } else {
		            itemTemplate = template;
		            itemPlace = listLayer;
		        }

		        var items = [];
		        for (var i=0, ii=overlaped.length; i<ii; i++) {
		            var c = overlaped[i],
		                item = $(itemTemplate.replace(/\{\{(\w+)\}\}/g, function(match, symbol) {
		                    if (symbol === 'order') {
		                        return i+1;
		                    } else if (symbol in marker) {
		                        return c.marker[symbol];
		                    } else if (c.marker.get(symbol)) {
		                        return c.marker.get(symbol);
		                    } else {
		                        match;
		                    }
		                }));

		            item.on('click', $.proxy(self._onClickItem, self, c.marker));
		            items.push(item);
		        };

		        for (var j=0, jj=items.length; j<jj; j++) {
		            itemPlace.append(items[j]);
		        }

		        listLayer.css({
		                    /* left: offset.x + 5,
		                    top: offset.y */
		                })
		                .show();
		    },

		    _onDown: function(e) {
		        var marker = e.overlay,
		            map = this.getMap(),
		            proj = map.getProjection(),
		            offset = proj.fromCoordToOffset(marker.getPosition()),
		            overlaped = this.getOverlapedMarkers(marker),
		            self = this;

		        naver.maps.Event.resumeDispatch(marker, 'click');

		        if (overlaped.length <= 1) {
		            return;
		        }

		        naver.maps.Event.stopDispatch(marker, 'click');
		        
		        this._renderIntersectList(overlaped, offset);
		        this._overlapInfoEl.hide();

		        naver.maps.Event.trigger(this, 'overlap', overlaped);
		        map.setOptions({
		        	draggable:false,
		        	pinchZoom:false,
		        	scrollWheel:false,
		        	keyboardShortcuts: false,
		            disableDoubleTapZoom: false,
		            disableDoubleClickZoom: false,
		            disableTwoFingerTapZoom: false
		        });
		    },

		    _onClickItem: function(marker, e) {
		        naver.maps.Event.resumeDispatch(marker, 'click');

		        naver.maps.Event.trigger(this, 'clickItem', {
		            overlay: marker,
		            originalEvent: e.originalEvent
		        });

		        marker.trigger('click');
		    }
		};

		var recognizer = new MarkerOverlapRecognizer({
		    highlightRect: false,
		    tolerance: 17
		});
		recognizer.setMap(map);

		var bounds = map.getBounds(),
		    southWest = bounds.getSW(),
		    northEast = bounds.getNE(),
		    lngSpan = northEast.lng() - southWest.lng(),
		    latSpan = northEast.lat() - southWest.lat();

	/* 	function highlightMarker(marker) {
		    var icon = marker.getIcon();

		    if (icon.url !== MARKER_HIGHLIGHT_ICON_URL) {
		        icon.url = MARKER_HIGHLIGHT_ICON_URL;
		        marker.setIcon(icon);
		    }

		    marker.setZIndex(1000);
		}

		function unhighlightMarker(marker) {
		    var icon = marker.getIcon();

		    if (icon.url === MARKER_HIGHLIGHT_ICON_URL) {
		        icon.url = MARKER_ICON_URL;
		        marker.setIcon(icon);
		    }

		    marker.setZIndex(100);
		}
 */
		 

		var overlapCoverMarker = null;
		naver.maps.Event.addListener(recognizer, 'overlap', function(list) {
		    if (overlapCoverMarker) {
		       // unhighlightMarker(overlapCoverMarker);
		    }

		    overlapCoverMarker = list[0].marker;

		    naver.maps.Event.once(overlapCoverMarker, 'mouseout', function() {
		        //highlightMarker(overlapCoverMarker);
		    });
		});

		naver.maps.Event.addListener(recognizer, 'clickItem', function(e) {
		    recognizer.hide();

		    if (overlapCoverMarker) {
		       // unhighlightMarker(overlapCoverMarker);

		        overlapCoverMarker = null;
		    }
		});

		var currentDay = new Date();  
		var theYear = currentDay.getFullYear();
		var theMonth = currentDay.getMonth();
		var theDate  = currentDay.getDate();
		var month = ("0" + (theMonth + 1)).slice(-2);
		
		var todayVal = theYear + "-" + month + "-" + theDate;
		
	<%
	ArrayList<ImgInfo> selectAll = null;
	ArrayList<ImgInfo> equalPos = null;
	ImgInfo imgInfo = null;
	int sCount = 0;
	ImginfoDAO imginfoDAO = new ImginfoDAO();
	selectAll = imginfoDAO.getPosNum();
	String lat ="";
	String lng ="";
	for (int i = 0; i < selectAll.size(); i++) {
	lat = selectAll.get(i).getLatitude();
	lng = selectAll.get(i).getLongitude();
	sCount = imginfoDAO.getPosCount(selectAll.get(i).getLatitude(), selectAll.get(i).getLongitude());//같은위치에 등록된 사진 갯수

	if(sCount == 1){
	imgInfo = imginfoDAO.posData(selectAll.get(i).getLatitude(), selectAll.get(i).getLongitude());
	
	%>//마커가 한개일 경우 리스트를 안보여주는 문제 때문에 같은위치에 마커한개를 만들어서 [마커 겹침]메소드가 실행되서 리스트를 보여주게 함 
	var marker = new naver.maps.Marker({
		position: new naver.maps.LatLng(<%= lat%>, <%= lng%>),
		map: map,
		title: '',
		icon: {
		content: [
					'<img src="./img/pinmarker.png" class="pinMarker">'
		        ].join(''),
		size: new naver.maps.Size(38, 58),
		anchor: new naver.maps.Point(19, 58),
		},
	});
	
	recognizer.add(marker);
	//오늘 추가된 이미지 정보인 경우 노란색 마커이미지를 보여줌. z-index 999로 맨앞에 나오게끔 함
	if(todayVal == "<%= imgInfo.getTime().substring(0,10)%>"){

		var marker = new naver.maps.Marker({
			position: new naver.maps.LatLng(<%= lat%>, <%= lng%>),
			map: map,
			title: '<%= imgInfo.getTime().substring(0,19)%>,<%= imgInfo.getImg_path()%>,<%= imgInfo.getNum()%>',
			icon: {
			content: [
						'<img src="./img/newpinmarker.png" class="pinMarker" style="z-index:999;" data-time="<%= imgInfo.getTime().substring(0,19)%>">'
			        ].join(''),
			size: new naver.maps.Size(38, 58),
			anchor: new naver.maps.Point(19, 58),
			},
		});
		
		recognizer.add(marker);
	}else{
	var marker = new naver.maps.Marker({
		position: new naver.maps.LatLng(<%= lat%>, <%= lng%>),
		map: map,
		title: '<%= imgInfo.getTime().substring(0,19)%>,<%= imgInfo.getImg_path()%>,<%= imgInfo.getNum()%>',
		icon: {
		content: [
					'<img src="./img/pinmarker.png" class="pinMarker" data-time="<%= imgInfo.getTime().substring(0,19)%>">'
		        ].join(''),
		size: new naver.maps.Size(38, 58),
		anchor: new naver.maps.Point(19, 58),
		},
	});
	
	recognizer.add(marker);
	}
	<% }else if(sCount > 1){//같은 위치에 등록된 사진이 1개 이상인 경우
		//같은 위치에 등록된 이미지정보 리스트를 뽑아서 ArrayList 변수인 equalPos에 담음	
		equalPos = imginfoDAO.equalPos(lat, lng);%>
			
			<%
			for (int j = 0; j < equalPos.size(); j++) {
			
			%>
			if(todayVal == <%= equalPos.get(j).getTime().substring(0,10)%>){
				var marker = new naver.maps.Marker({
					position: new naver.maps.LatLng(<%= lat%>, <%= lng%>),
					map: map,
					title: '<%= equalPos.get(j).getTime().substring(0,19)%>,<%= equalPos.get(j).getImg_path()%>,<%= equalPos.get(j).getNum()%>',
					icon: {
					    content: [
					    			'<img src="./img/newpinmarker.png" class="pinMarker" data-time="<%= equalPos.get(j).getTime().substring(0,19)%>">'
					            ].join(''),
					    size: new naver.maps.Size(38, 58),
					    anchor: new naver.maps.Point(19, 58),
					},
				});
				
				recognizer.add(marker);
			}else{
				var marker = new naver.maps.Marker({
					position: new naver.maps.LatLng(<%= lat%>, <%= lng%>),
					map: map,
					title: '<%= equalPos.get(j).getTime().substring(0,19)%>,<%= equalPos.get(j).getImg_path()%>,<%= equalPos.get(j).getNum()%>',
					icon: {
					    content: [
					    			'<img src="./img/pinmarker.png" class="pinMarker" data-time="<%= equalPos.get(j).getTime().substring(0,19)%>">'
					            ].join(''),
					    size: new naver.maps.Size(38, 58),
					    anchor: new naver.maps.Point(19, 58),
					},
				});
				
				recognizer.add(marker);
			}
			<%
			}
		}
	}
	%>


	var overlapCoverMarker = null;
	//마크 겹침 처리 END
	
	//검색처리 START
 	/* var infoWindow = new naver.maps.InfoWindow({
		  anchorSkew: true
		});  */

		map.setCursor('pointer');

		/* function searchCoordinateToAddress(latlng) {

		 //infoWindow.close();

		  naver.maps.Service.reverseGeocode({
		    coords: latlng,
		    orders: [
		      naver.maps.Service.OrderType.ADDR,
		      naver.maps.Service.OrderType.ROAD_ADDR
		    ].join(',')
		  }, function(status, response) {
		   if (status === naver.maps.Service.Status.ERROR) {
		      if (!latlng) {
		        return alert('ReverseGeocode Error, Please check latlng');
		      }
		      if (latlng.toString) {
		        return console.log('ReverseGeocode Error, latlng:' + latlng.toString());
		      }
		      if (latlng.x && latlng.y) {
		        return console.log('ReverseGeocode Error, x:' + latlng.x + ', y:' + latlng.y);
		      }
		      return alert('ReverseGeocode Error, Please check latlng');
		    } 

		   var address = response.v2.address,
		        htmlAddresses = [];

		    if (address.jibunAddress !== '') {
		        htmlAddresses.push('[지번 주소] ' + address.jibunAddress);
		    }

		    if (address.roadAddress !== '') {
		        htmlAddresses.push('[도로명 주소] ' + address.roadAddress);
		    } 

		    infoWindow.setContent([
		      '<div style="padding:10px;min-width:200px;line-height:150%;">',
		      '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
		      htmlAddresses.join('<br />'),
		      '</div>' 
		    ].join('\n')); 

		    //infoWindow.open(map, latlng);
		  });
		} */
		/* var searchMarker = new naver.maps.Marker({
		    position: new naver.maps.LatLng(127.1052232, 37.3595099),
		    map: map,
		    icon: {
		        content: [
		                    '<img src="./img/searchMarker.png">',
		                ].join(''),
		        size: new naver.maps.Size(38, 58),
		        anchor: new naver.maps.Point(19, 58),
		    },
		    //draggable: true 드래그 가능
		}); */
		var chkS=true;
		function searchAddressToCoordinate(address) {
			 
		  naver.maps.Service.geocode({
		    query: address
		  }, function(status, response) {
			  
		    /* if (status === naver.maps.Service.Status.ERROR) {
		      if (!address) {
		        return alert('Geocode Error, Please check address');
		      }
		      return alert('Geocode Error, address:' + address);
		    } */

		    if (response.v2.meta.totalCount === 0) {
		    	if(chkS ==true){
		    	chkS=false;
		    	alert("검색결과가 없습니다");
		    	}else{
		    		chkS = true;
		    	}
		    }else{
			
		    	if(document.getElementById("searchMarker")){
		    		$("#searchMarker").remove();
		    	}
		    var htmlAddresses = [],
		      item = response.v2.addresses[0],
		      point = new naver.maps.Point(item.x, item.y);
		   
		    var marker = new naver.maps.Marker({
			    position: new naver.maps.LatLng(point),
			    map: map,
			    icon: {
			        content: [
			                    '<img src="./img/searchMarker.png" id="searchMarker" class="searchMarker">',
			                ].join(''),
			       // size: new naver.maps.Size(38, 58),
			        //anchor: new naver.maps.Point(19, 58),
			    },
			    //draggable: true 드래그 가능
			}); 
		   /*  if (item.roadAddress) {
		      htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
		    }

		    if (item.jibunAddress) {
		      htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
		    }

		    if (item.englishAddress) {
		      htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
		    }

		     infoWindow.setContent([
		      '<div style="padding:10px;min-width:200px;line-height:150%;">',
		      '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
		      htmlAddresses.join('<br />'),
		      '</div>'
		    ].join('\n')); */

		    map.setCenter(point);
		  // infoWindow.open(map, point);
		    }
		  });
		  
		 
		}

		function initGeocoder() {
		  if (!map.isStyleMapReady) {
		    return;
		  }

		  map.addListener('click', function(e) {
		    searchCoordinateToAddress(e.coord);
		  });

		  $('#address').on('keydown', function(e) {
		    var keyCode = e.which;

		    if (keyCode === 13) { // Enter Key
		      searchAddressToCoordinate($('#address').val());
		    }
		  });  

		  $('#search-btn').on('click', function(e) {
		    e.preventDefault();

		    searchAddressToCoordinate($('#address').val());
		  }); 

		 
		}

		naver.maps.onJSContentLoaded = initGeocoder;
		naver.maps.Event.once(map, 'init_stylemap', initGeocoder);
		//검색처리 END

		//현재위치 표시START
function onSuccessGeolocation(position) {
			<%
			String rlat = request.getParameter("lat");
			String rlng = request.getParameter("lng");
			String zoom = request.getParameter("zoom");
			if(rlat != null && rlng != null && zoom != null){ %>
			var location = new naver.maps.LatLng(<%=rlat%>, <%=rlng%>);
			 map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
			    map.setZoom(<%=zoom%>); // 지도의 줌 레벨을 변경합니다.

		<%}else{%> 
	var location = new naver.maps.LatLng(position.coords.latitude, position.coords.longitude);		
	    map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
	    map.setZoom(18); // 지도의 줌 레벨을 변경합니다.
	   
			<%}%> 


}
	function onSuccessGeolocation2(position) {
		var location = new naver.maps.LatLng(position.coords.latitude, position.coords.longitude);

		    map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
		}
		
	function onErrorGeolocation() {
	    var center = map.getCenter();

	    infowindow.setContent('<div style="padding:20px;">' +
	        '<h5 style="margin-bottom:5px;color:#f00;">Geolocation failed!</h5>'+ "latitude: "+ center.lat() +"<br />longitude: "+ center.lng() +'</div>');

	    infowindow.open(map, center);
	}
	
	var centerlat;
	var centerlng;
	    if (navigator.geolocation) {
	    	
	    	navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);       
	         navigator.geolocation.watchPosition(
	                 function(position) {
	                	 document.getElementById("latV").value = position.coords.latitude;
	                	 document.getElementById("lngV").value = position.coords.longitude;
	                document.getElementById("lat").value = position.coords.latitude;
	                document.getElementById("lng").value = position.coords.longitude;
            	 	
	            /*     console.log(latV);
	                console.log(lngV); */
	                	 
	                	 // console.log("lat" + position.coords.latitude);
	                	 //console.log("lng" + position.coords.longitude);
	                	 var location = new naver.maps.LatLng(position.coords.latitude,
	                             position.coords.longitude);
	                	 if(document.getElementById("circle")){
	                		 document.getElementById("circle").remove();
	                	 }
	               	 	//map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
						//map.setZoom(18); // 지도의 줌 레벨을 변경합니다.
						
						var unarySpotMarker = new naver.maps.Marker({
					    position: location,
					    map: map,
					    icon: {
					        content: '<div id="circle" class="circle"></div>',
					       
					    }
	                 });
						//console.log('Coordinates: ' + location.toString());
						
	                     $('#latitude').html(position.coords.latitude);     // 위도 
	                     $('#longitude').html(position.coords.longitude); // 경도 
	                     
	                 }, function(error){
	                	 alert(error);
	                 }, {
	                		enableHighAccuracy: true,
		     				timeout: Infinity,
		     				maximumAge: 0
	                 });
	    } else {
	    	alert("오류");
	        var center = map.getCenter();
	        infowindow.setContent('<div style="padding:20px;"><h5 style="margin-bottom:5px;color:#f00;">Geolocation not supported</h5></div>');
	        infowindow.open(map, center);
	    }
//현재위치 표시END

function myPosition(){
	var lng = document.getElementById("lng").value;
	var lat = document.getElementById("lat").value;
	p = new naver.maps.LatLng(lat, lng);
	map.setCenter(p);
}

function changeSearch(){
	document.getElementById("filterGlass").style.display="none";
	document.getElementById("glassBox").style.display="none";
	document.getElementById("filterContainer").style.display="none";
	
	$("#changeSearch").html("<div class='inlineBox'><div id='backFlow' onclick='backFlow()'><img src='./img/backArrow.png' class='backArrowCss'></div><input type='text' id='searchInput' class='form-control searchStyle' placeholder='검색' maxlength='20'></div>");
	document.getElementById("searchInput").focus();
	document.getElementById("searchModeBox").style.display="block";
	document.getElementById("searchBox").setAttribute("onclick", "realSearch()");
}

function backFlow(){
	$("#changeSearch").empty();
	$("#changeSearch").html("<span class='titleName'>Map Surfing</span>");
	document.getElementById("searchModeBox").style.display="none";
	document.getElementById("searchBox").setAttribute("onclick", "changeSearch()");
}

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


function filterView(){
	backFlow();
	document.getElementById("filterGlass").style.display="block";
	document.getElementById("glassBox").style.display="block";
	document.getElementById("filterContainer").style.display="block";
}

function disappearfilter(){
	document.getElementById("filterGlass").style.display="none";
	document.getElementById("glassBox").style.display="none";
	document.getElementById("filterContainer").style.display="none";
	
}

/* 
 // input type =date로 바꾸면서 필요없어짐
 function date_mask(textid) {
var text = eval(textid);
var textlength = text.value.length;
 '-'자동입력 때문에 날짜 수정이 힘듦
	if (textlength == 4) {
	text.value = text.value + "-";
	} else if (textlength == 7) {
	text.value = text.value + "-";
	} else 
	if (textlength > 9) { 
		console.log("실행");
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
   console.log(input.value);
   if (!validformat.test(input.value)) {
    alert("날짜 형식이 올바르지 않습니다. YYYY-MM-DD");
    document.getElementById("startdate").select();
    return false;
   } else { //Detailed check for valid date ranges
    var yearfield = input.value.substring(0,3);
    console.log(yearfield);
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
	'-'자동입력 때문에 날짜 수정이 힘듦
		if (textlength == 4) {
		text.value = text.value + "-";
		} else if (textlength == 7) {
		text.value = text.value + "-";
		} else 
		if (textlength > 9) {
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
		
        var temp =[];
        temp = document.getElementsByClassName("pinMarker");
		
		var theDayOfWeek = currentDay.getDay();
		
		Date.prototype.toDateInputValue = (function() {
		    var local = new Date(this);
		    local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
		    return local.toJSON().slice(0,10);
		});
		document.getElementById("startdate").value = new Date().toDateInputValue();
		document.getElementById("enddate").value = new Date().toDateInputValue();
		//시간 필터 메소드
		function allShow(){
			document.getElementById("filterGlass").style.display="none";
			document.getElementById("glassBox").style.display="none";
			document.getElementById("filterContainer").style.display="none";
			for(i=0; i < document.getElementsByClassName("timeselect").length; i++){
				document.getElementsByClassName("timeselect")[i].style.backgroundColor="";
			}
			document.getElementById("allShow").style.backgroundColor="#d1d1d1";
	        $(temp).show();
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
				if(temp[i].dataset.time){
					 if(temp[i].dataset.time.substring(0,10) == todayVal){
						showNum[i] = i;
					} 
				}
			}
			
			$(".pinMarker").hide();
			for(i = 0; i < showNum.length; i ++){
		        $(temp[showNum[i]]).show();
		        	
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
					if(temp[i].dataset.time){
						if(temp[i].dataset.time.substring(0,10) == thisWeek[j]){
							showNum[i] = i;
						} 
					}
				}
			} 
			 
			  $(".pinMarker").hide();
		        for(i = 0; i < showNum.length; i ++){
		        $(temp[showNum[i]]).show();
		        	
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
				if(temp[i].dataset.time){
					if(temp[i].dataset.time.substring(5,7) == month){
						showNum[i] = i;
					}
				}
			}
			
			$(".pinMarker").hide();
			for(i = 0; i < showNum.length; i ++){
		        $(temp[showNum[i]]).show();
		        	
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
				if(temp[i].dataset.time){
					 if(temp[i].dataset.time.substring(0,4) == theYear){
						showNum[i] = i;
					} 
				}
			}
			
			$(".pinMarker").hide();
			for(i = 0; i < showNum.length; i ++){
		        $(temp[showNum[i]]).show();
		        	
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
					if(temp[i].dataset.time > start && temp[i].dataset.time < end){
						showNum[i] = i;
				}
			} 
			 
			 $(".pinMarker").hide();
		        for(i = 0; i < showNum.length; i ++){
		        $(temp[showNum[i]]).show();
		        }
			
		}
</script>

</body>
</html>