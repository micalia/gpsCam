<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="imgInfo.ImginfoDAO" %>
<%@ page import="imgInfo.ImgInfo" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="./js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ufu00uecjo&submodules=geocoder"></script>

<title>지도 위치 검색</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<style>
@import "compass/css3";

html,
body{
	min-height:100% !important;
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
	position:relative;
	top:20px;
    display: inline-block;
	background-color:#4287f5;
	color:white;
	padding:0px 9px 0px 9px;
	border-radius:18px;
	font-size:27px;
}
#interBox{
	width:91%;
	height:96%;
	border:solid 1px #333;
	background-color:#fff;
	padding:5px;
	margin:0 auto;
	left: 50%;
    top: 50%;
    position: absolute;
    transform: translate(-50%, -50%);
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
	z-index:2;
	position:relative;
	display:none;
}
.search{
	position:relative;
	z-index:2;
	padding-top:6px;
	padding-left:20px;
	padding-right:20px;
	width:100%;
}
.searchMarker{
	width:30px;
	height:40px;
	position:absolute;
	bottom:0px;
	left:-15px;
}
#address{
	width:90%;
	float:left;
}
#search-btn{
	width:10%;
}
</style>
</head>
<body>

<div id="map" style="width:100%;height:100%;">
<div class="search">
	<input type="text" id="address" autocomplete="off"><input type="button" id="search-btn" value="검색">
</div>
<div class="image-box">
</div>
<div id="listContainer">

</div>
</div>
<script>


	var map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(37.0073165, 127.17575970000001),
	    zoom: 19
	});

/* 	var infoWindow = new naver.maps.InfoWindow({
		  anchorSkew: true
		}); */

		map.setCursor('pointer');

		function searchCoordinateToAddress(latlng) {

		 // infoWindow.close();

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

		   /*  var address = response.v2.address,
		        htmlAddresses = [];

		    if (address.jibunAddress !== '') {
		        htmlAddresses.push('[지번 주소] ' + address.jibunAddress);
		    }

		    if (address.roadAddress !== '') {
		        htmlAddresses.push('[도로명 주소] ' + address.roadAddress);
		    } */

		   /*  infoWindow.setContent([
		      '<div style="padding:10px;min-width:200px;line-height:150%;">',
		      '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
		      htmlAddresses.join('<br />'),
		      '</div>' 
		    ].join('\n')); */

		    //infoWindow.open(map, latlng);
		  });
		}
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
		function searchAddressToCoordinate(address) {
			 
		  naver.maps.Service.geocode({
		    query: address
		  }, function(status, response) {
		    if (status === naver.maps.Service.Status.ERROR) {
		      if (!address) {
		        return alert('Geocode Error, Please check address');
		      }
		      return alert('Geocode Error, address:' + address);
		    }

		    if (response.v2.meta.totalCount === 0) {
		      return alert('No result.');
		    }

		    var htmlAddresses = [],
		      item = response.v2.addresses[0],
		      point = new naver.maps.Point(item.x, item.y);
		    console.log(point);
		    var marker = new naver.maps.Marker({
			    position: new naver.maps.LatLng(point),
			    map: map,
			    icon: {
			        content: [
			                    '<img src="./img/searchMarker.png" class="searchMarker">',
			                ].join(''),
			       // size: new naver.maps.Size(38, 58),
			        //anchor: new naver.maps.Point(19, 58),
			    },
			    //draggable: true 드래그 가능
			}); 
		    if (item.roadAddress) {
		      htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
		    }

		    if (item.jibunAddress) {
		      htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
		    }

		    if (item.englishAddress) {
		      htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
		    }

		  /*   infoWindow.setContent([
		      '<div style="padding:10px;min-width:200px;line-height:150%;">',
		      '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
		      htmlAddresses.join('<br />'),
		      '</div>'
		    ].join('\n')); */

		    map.setCenter(point);
		    //infoWindow.open(map, point);
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

		  //searchAddressToCoordinate('정자동 178-1');
		}

		naver.maps.onJSContentLoaded = initGeocoder;
		naver.maps.Event.once(map, 'init_stylemap', initGeocoder);
		

</script>
</body>
</html>