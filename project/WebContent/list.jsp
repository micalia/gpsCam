<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="imgInfo.ImgInfo" %>
<%@ page import="imgInfo.ImginfoDAO" %>
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
<title>Insert title here</title>
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
}
.object{
	height:130px;
	width:130px;
	display:block;
}
.cover{
	object-fit:cover;
}
.listBox td{
	padding:0px;
}
.infotd{
	width:100%;
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
</style>
</head>
<body>
<div class="inter-box">
<div class="scroll-box">
<table class="listBox" border="1" >
<%
	for(int i=0; i < list.size(); i++){%>
		<tr>
			<td>	
				<img class="object cover"src="<%= list.get(i).getImg_path().replace("upload","thumbnail") %>">		
			</td>
			<td class="infotd">
				<span><%= list.get(i).getTime().substring(0,19)%></span>
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
function backToMap(){
	var newForm = document.createElement("form");
	newForm.name = "newForm";
	newForm.method = "post";
	newForm.action="historyView.jsp";

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
</script>
</body>
</html>