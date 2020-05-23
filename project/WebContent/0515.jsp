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
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=ufu00uecjo"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
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
    display: inline-block;
	background-color:#4287f5;
	color:white;
	padding:0px 9px 0px 9px;
	border-radius:18px;
	font-size:27px;
}
</style>
</head>
<body>
<div id="map" style="width:100%;height:100%;">
<div class="image-box">
</div>
</div>
<script>
$(window).on("load", function() {
	

	var locationBtnHtml = '<form id="imageFrm" method="post" enctype="multipart/form-data"> \n'
		+ '<label for="img"><img src="./img/cam_icon.png" class="camIcon"></label> \n'
		+ '<input type="file" name="img" accept="image/*" id="img">'
		+ '<input type="hidden" id="latV" name ="latitude" value="">'
		+ '<input type="hidden" id="lngV" name ="longitude" value=""></form>'; 
		
/*  var locationBtnHtml = '<form id="imageFrm" action="http://54.180.24.137:8080/project/fileUpload.jsp" method="post" enctype="multipart/form-data"> \n'
		+ '<label for="img"><img src="./img/cam_icon.png" class="camIcon"></label> \n'
		+ '<input type="file" name="img" accept="image/*" id="img"></form>'; */

function readURL(input) {
if (input.files && input.files[0]) {
var reader = new FileReader();

reader.onload = function (e) {
$(".image-box").html('<div id="uploadBox"><div class="imgContainer"><img id ="blah" src="'+ e.target.result +'" class="uploadImg"></div>'+
					'<div class="btn-box"><button id="cancelUp" class="btn btn-danger btn-lg">취소</button><span class="marSpan"></span><button id="uploadBtn" class="btn btn-primary btn-lg">확인</button></div></div>');
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
//navigator.geolocation.getCurrentPosition(success, error);
// document.getElementById('imageFrm').action= "http://localhost:8080/project/fileUpload.jsp?lat="+ lat +"&lng="+ lng;  //이클립스에서는 풀기
document.getElementById('imageFrm').action= "http://54.180.24.137:8080/project/fileUpload.jsp?lat="+ lat +"&lng="+ lng; //실제 웹서버에서 실행
document.getElementById('imageFrm').submit(); 
});

}

reader.readAsDataURL(input.files[0]);
}
}

/* function success(pos) {
var crd = pos.coords;
alert("실행");
$('#imageFrm').append('<input type="hidden" name = "latitude" value="'+ crd.latitude +'"'>);
$('#imageFrm').append('<input type="hidden" name = "latitude" value="'+ crd.longitude +'"'>);

console.log('Latitude : ' + crd.latitude);
console.log('Longitude: ' + crd.longitude);
};

function error(err) {
console.warn('ERROR(' + err.code + '): ' + err.message);
}; */

var map = new naver.maps.Map('map', {
zoom: 13,
logoControlOptions: {
position: naver.maps.Position.TOP_LEFT
},
scaleControlOptions: {
position: naver.maps.Position.TOP_RIGHT
}
});

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
System.out.println(imgInfo.getImg_path());
%>
var getShowMarker = new naver.maps.Marker({
position: new naver.maps.LatLng(<%= lat%>, <%= lng%>),
map: map,
icon: {
content: [
	<%-- <img src="<%= imgInfo.getImg_path()%>" style="width:100px; height:100px;"> --%>
            '<div class="getShowM">',
            <%= sCount%>,
            '</div>'
            //<img src="" style="width:100px; height:100px;">
        ].join(''),
size: new naver.maps.Size(38, 58),
anchor: new naver.maps.Point(19, 58),
},
//draggable: true 드래그 가능
});

var MarkerOverlapRecognizer = function(opts) { //마커가 겹쳐지는걸 인식함.
    this._options = $.extend({
        tolerance: 20, //허용 오차
       highlightRect: true, //하이라이트 직사각형?
        highlightRectStyle: {
            strokeColor: '#ff0000',//빨간색
            strokeOpacity: 1,
            strokeWeight: 2,
            strokeStyle: 'dot',
            //strokeStyle: 'black',
            fillColor: '#ff0000',
           // fillColor: 'black',
            fillOpacity: 0.5
        },
        intersectNotice: true,//교차 알림
       intersectNoticeTemplate: '<div style="width:10px;border:solid 1px #333;background-color:#fff;">{{count}}</div>',
       
    }, opts);
//console.log(this._options);
    this._listeners = [];
    this._markers = [];

    this._rectangle = new naver.maps.Rectangle(this._options.highlightRectStyle);//직사각형
    this._overlapInfoEl = $('<div style="position:absolute;z-index:100;margin:0;padding:0;display:block;border:1px solid yellow;"></div>');
    this._overlapListEl = $('<div style="position:absolute;z-index:100;margin:0;padding:0;display:block;border:1px solid yellow;"></div>');//겹쳐진 리스트
};

MarkerOverlapRecognizer.prototype = {
    constructor: MarkerOverlapRecognizer,

    setMap: function(map) {
        var oldMap = this.getMap();

        if (map === oldMap) return;

        this._unbindEvent();

        //this.hide();

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
    		//map.addListener('idle', $.proxy(this._onOver, this)),
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
       /*  this._overlapInfoEl.remove();
        this._overlapListEl.remove(); */
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
     /*    this._overlapListEl.hide();
        this._overlapInfoEl.hide(); */
        this._rectangle.setMap(null);
    },

    _bindMarkerEvent: function(marker) {
        marker.__intersectListeners = [
        	
            marker.addListener('mouseover', $.proxy(this._onOver, getShowMarker)),
            //marker.addListener('mouseout', $.proxy(this._onOut, this)),
            //marker.addListener('mousedown', $.proxy(this._onDown, this))
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
            offset = proj.fromCoordToOffset(position), //상쇄하다
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

    _onIdle: function() {//가동되지 않는
       	
    },

    _onOver: function(e) {//가동되는
    	console.log(e);
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
            //this.hide();
        }
    },

    _onOut: function(e) {
        /* this._rectangle.setMap(null);
        this._overlapInfoEl.hide(); */
    },

    _guid: function() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c){
            var r = Math.random()*16|0, v = c == "x" ? r : (r&0x3|0x8);
            return v.toString(16);
        }).toUpperCase();
    },

    _renderIntersectList: function(overlaped, offset) { //교차되는 것들 리스트로 뽑기
        
    }, 

    _onDown: function(e) {
    
    },

    _onClickItem: function(marker, e) {
      
    }
};

var recognizer = new MarkerOverlapRecognizer({
    highlightRect: true,
    tolerance: 20
});

recognizer.setMap(map);

var bounds = map.getBounds(),
    southWest = bounds.getSW(),
    northEast = bounds.getNE(),
    lngSpan = northEast.lng() - southWest.lng(),
    latSpan = northEast.lat() - southWest.lat();


<% }else if(sCount > 1){
equalPos = imginfoDAO.equalPos(lat, lng);%>

var getShowMarker = new naver.maps.Marker({
position: new naver.maps.LatLng(<%= lat%>, <%= lng%>),
map: map,
icon: {
    content: [
                '<div class="getShowM">',
                <%= sCount%>,
                '</div>'
            ].join(''),
    size: new naver.maps.Size(38, 58),
    anchor: new naver.maps.Point(19, 58),
},
//draggable: true 드래그 가능
});

var MarkerOverlapRecognizer = function(opts) { //마커가 겹쳐지는걸 인식함.
    this._options = $.extend({
        tolerance: 20, //허용 오차
       highlightRect: true, //하이라이트 직사각형?
        highlightRectStyle: {
            strokeColor: '#ff0000',//빨간색
            strokeOpacity: 1,
            strokeWeight: 2,
            strokeStyle: 'dot',
            //strokeStyle: 'black',
            fillColor: '#ff0000',
           // fillColor: 'black',
            fillOpacity: 0.5
        },
        intersectNotice: true,//교차 알림
       intersectNoticeTemplate: '<div style="width:10px;border:solid 1px #333;background-color:#fff;">{{count}}</div>',
       
    }, opts);
//console.log(this._options);
    this._listeners = [];
    this._markers = [];

    this._rectangle = new naver.maps.Rectangle(this._options.highlightRectStyle);//직사각형
    this._overlapInfoEl = $('<div style="position:absolute;z-index:100;margin:0;padding:0;display:block;border:1px solid yellow;"></div>');
    this._overlapListEl = $('<div style="position:absolute;z-index:100;margin:0;padding:0;display:block;border:1px solid yellow;"></div>');//겹쳐진 리스트
};

MarkerOverlapRecognizer.prototype = {
    constructor: MarkerOverlapRecognizer,

    setMap: function(map) {
        var oldMap = this.getMap();

        if (map === oldMap) return;

        this._unbindEvent();

        //this.hide();

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
    		//map.addListener('idle', $.proxy(this._onOver, this)),
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
       /*  this._overlapInfoEl.remove();
        this._overlapListEl.remove(); */
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
     /*    this._overlapListEl.hide();
        this._overlapInfoEl.hide(); */
        this._rectangle.setMap(null);
    },

    _bindMarkerEvent: function(marker) {
        marker.__intersectListeners = [
        	
            marker.addListener('mouseover', $.proxy(this._onOver, getShowMarker)),
            //marker.addListener('mouseout', $.proxy(this._onOut, this)),
            //marker.addListener('mousedown', $.proxy(this._onDown, this))
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
            offset = proj.fromCoordToOffset(position), //상쇄하다
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

    _onIdle: function() {//가동되지 않는
       	
    },

    _onOver: function(e) {//가동되는
    	console.log(e);
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
            //this.hide();
        }
    },

    _onOut: function(e) {
        /* this._rectangle.setMap(null);
        this._overlapInfoEl.hide(); */
    },

    _guid: function() {
        return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c){
            var r = Math.random()*16|0, v = c == "x" ? r : (r&0x3|0x8);
            return v.toString(16);
        }).toUpperCase();
    },

    _renderIntersectList: function(overlaped, offset) { //교차되는 것들 리스트로 뽑기
        
    }, 

    _onDown: function(e) {
    
    },

    _onClickItem: function(marker, e) {
      
    }
};

var recognizer = new MarkerOverlapRecognizer({
    highlightRect: true,
    tolerance: 20
});

recognizer.setMap(map);

var bounds = map.getBounds(),
    southWest = bounds.getSW(),
    northEast = bounds.getNE(),
    lngSpan = northEast.lng() - southWest.lng(),
    latSpan = northEast.lat() - southWest.lat();


<%
for (int j = 0; j < equalPos.size(); j++) {
System.out.println(equalPos.get(j).getImg_path());
%>

<%
}
}
}
%>
/* var getShowMarker = new naver.maps.Marker({
position: new naver.maps.LatLng(37.0073565, 127.17576810000001),
map: map,
icon: {
content: [
'<div class="getShowM">',
3,
'</div>'
].join(''),
size: new naver.maps.Size(38, 58),
anchor: new naver.maps.Point(19, 58),
},
//draggable: true 드래그 가능
}); */

function onSuccessGeolocation(position) {
var location = new naver.maps.LatLng(position.coords.latitude, position.coords.longitude);

map.setCenter(location); // 얻은 좌표를 지도의 중심으로 설정합니다.
map.setZoom(18); // 지도의 줌 레벨을 변경합니다.

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
if (navigator.geolocation) {

navigator.geolocation.getCurrentPosition(onSuccessGeolocation, onErrorGeolocation);       
navigator.geolocation.watchPosition(
 function(position) {
	 document.getElementById("latV").value=position.coords.latitude;
	 document.getElementById("lngV").value= position.coords.longitude;
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
	

	
 
	
});
</script>
</body>
</html>