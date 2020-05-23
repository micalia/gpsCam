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
</style>
</head>
<body>

<div id="map" style="width:100%;height:100%;">
<div class="image-box">
</div>
<div id="listContainer">

</div>
</div>
<script>
//$(window).on("load", function() {

	var map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(37.0073165, 127.17575970000001),
	    zoom: 19
	});

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
	        intersectListTemplate:'<ul id="liList" style="list-style:none;margin:0;padding:0;">'
	            + '{{#repeat}}'
	            + '<li style="list-style:none;margin:0;padding:0;"><a href="#">{{order}}. {{title}}</a></li>'
	            + '{{/#repeat}}'
	            + '</ul>'
	        	+ '<SCRIPT' + '>'
	        + 'var listBox = document.getElementById("listContainer");'
	        + 'listBox.style.display="block";'
	        + 'var liList = $("#liList").html();'
	        + '$("#listContainer").html("'
	        		/* + '<span style=\'color:yellow;\'>하이</span>' 잘됨*/
	        + '<div id=\'interBox\'><input type=\'button\' value=\'닫기\' id=\'closeList\' onclick=\'closeList()\'>'
            + '<ul style=\'list-style:none;margin:0;padding:0;\'>"'
            + '+ liList +'
            + '"</ul>'
            + '</div>'	
			+ '");'
	        /* + '<div id="interBox"><input type="button" value="닫기" id="closeList" onclick="closeList()">'
            + '<ul style="list-style:none;margin:0;padding:0;">'
            + '{{#repeat}}'
            + '<li style="list-style:none;margin:0;padding:0;"><a href="#">{{order}}. {{title}}</a></li>'
            + '{{/#repeat}}'
            + '</ul>'
            + '</div>' */
	        		/* + '");' */
	        	+ '</SCRIPT' + '>'
	        	
	            + '<SCRIPT' + '>'
	            + 'function closeList(){document.getElementById("listContainer").style.display="none";'
			/* 	+ 'console.log(_.find(map));' */
	            
	                
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
	
	%>
	var marker = new naver.maps.Marker({
		position: new naver.maps.LatLng(<%= lat%>, <%= lng%>),
		map: map,
		title: '<%= imgInfo.getTime()%>',
		icon: {
		content: [
			<%-- <img src="<%= imgInfo.getImg_path()%>" style="width:100px; height:100px;"> --%>
		            '<div class="getShowM">',
		          		'<span style="color:#4287f5;"><%= sCount%></span>',
		            '</div>'
		            //<img src="" style="width:100px; height:100px;">
		        ].join(''),
		size: new naver.maps.Size(38, 58),
		anchor: new naver.maps.Point(19, 58),
		},
		//draggable: true 드래그 가능
	});
	
	recognizer.add(marker);

	<% }else if(sCount > 1){
	equalPos = imginfoDAO.equalPos(lat, lng);%>

	var marker = new naver.maps.Marker({
		position: new naver.maps.LatLng(<%= lat%>, <%= lng%>),
		map: map,
		icon: {
		    content: [
		                '<div class="getShowM">',
		                '<span style="color:#4287f5;"><%= sCount%></span>',
		                '</div>'
		            ].join(''),
		    size: new naver.maps.Size(38, 58),
		    anchor: new naver.maps.Point(19, 58),
		},
		//draggable: true 드래그 가능
	});
	
	recognizer.add(marker);

	<%
	for (int j = 0; j < equalPos.size(); j++) {
	System.out.println(equalPos.get(j).getTime());//이미지 경로
	%>

	<%
	}
	}
	}
	%>


	var overlapCoverMarker = null;

	$('.closeList').click(function(){});
//});
</script>
</body>
</html>