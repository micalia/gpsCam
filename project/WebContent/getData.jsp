<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<title>gpsCam</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="./js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ufu00uecjo"></script>

<style>
@import "compass/css3";

html,
body{
	width:100%;
	height:100%;
}
.circle {
  background: red;
  width: 85px;
  height: 85px;
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
.camIcon{
	width:60px;
	position:absolute;
	bottom:75px;
	right:34px;
}
#img{
	display:none;
}
.image-box{
	width:100%;
	height:999px;
	background:rgba(0,0,0,0.5);
	padding-top:80px;
	z-index:2;
	position:relative;
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
	border:3px solid yellow;
	height:300px;
	line-height:285px;
	text-align:center;
}
.imgContainer>*{
	vertical-align:middle;
}
.btn-box{
	text-align:center;
	margin-top:57px;
}
.marSpan{
	margin:38px;
}
#map{
	z-index:1;
}

.getShowM{
	background-color:#4287f5;
	color:white;
	padding:0px 9px 0px 9px;
	border-radius:18px;
	font-size:27px;
}
</style>
</head>
<body>
<!-- <form action="http://localhost:8080/project/fileUpload.jsp" method="post" enctype="multipart/form-data">
		<input type="file" name="img" accept="image/*" id="img"></form> -->
<div id="map" style="width:100%;height:100%;">
<div class="image-box">
</div>
</div>

<script>

$(window).on("load", function() {
	
	var map = new naver.maps.Map('map', {
	        bounds: naver.maps.LatLngBounds.bounds(new naver.maps.LatLng(37.0073565, 127.17576810000001),
	                                              new naver.maps.LatLng(37.0073565, 127.17576810000001))
	    });

	

	var getShowMarker = new naver.maps.Marker({
	    position: new naver.maps.LatLng(37.0073565, 127.17576810000001),
	    map: map,
	    icon: {
	        content: [
	                    '<div class="getShowM">',
	                    '1',
	                    '</div>'
	                ].join(''),
	        size: new naver.maps.Size(38, 58),
	        anchor: new naver.maps.Point(19, 58),
	    },
	    //draggable: true 드래그 가능
	});

	
		   
	
});


</script>

</body>
</html>