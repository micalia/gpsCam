<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.drew.metadata.iptc.IptcReader"%>
<%@page import="com.drew.metadata.exif.ExifReader"%>
<%@page import="com.drew.imaging.jpeg.JpegSegmentReader"%>
<%@page import="com.drew.metadata.iptc.IptcDirectory"%>
<%@page import="com.drew.metadata.exif.ExifDirectory"%>
<%@page import="com.drew.metadata.Tag"%>
<%@page import="com.drew.metadata.Directory"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.drew.imaging.jpeg.JpegMetadataReader"%>
<%@page import="com.drew.metadata.Metadata"%>
<%@page import="java.io.File"%>
<%@page import="imgInfo.ImginfoDAO"%>
<%@page import="imgInfo.ImgInfo"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<title>history view</title>
<style>
	html,body{
		height:100%;
		min-height:100% !important;
		width:100%;
		margin:0px;
	}
	.imgStyle{
		width:100%;
		display:block;
		margin:0 auto;
	}
	.tableStyle{
		border:1px solid black;
		width:100%;
		border-collapse:collapse;
		margin:0 auto;
	}
	.tableStyle th, td{
		border:1px solid black;
	}
	.tableStyle td{
		padding:4px;
	}
	.inter-box{
		height:100%;
	}
	.scroll-box{
		overflow:auto;
		height:92%;
	}
	.backBtn{
		width: 100%;
	    height: 8%;
	    border-radius: 0px;
	}
</style>
</head>
<body>
<%
String num = request.getParameter("num");
ImginfoDAO imginfoDAO = new ImginfoDAO();
ImgInfo imgInfo = imginfoDAO.infoGet(num);

String dbImgPath = imgInfo.getImg_path();
//System.out.println(imgInfo.getImg_path());
ServletContext context = getServletContext();
String modifyPath = dbImgPath.replace("project","");
String imgPath = context.getRealPath(modifyPath);

//String imgPath = "E:/jspProject/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps" + dbImgPath; 

File jpegFile = new File(imgPath);
String exifImgPart = "";
//exifImgPart = "0";//파일 존재 하지 않음
//exifImgPart = "1";//jpg 파일이 아닙니다.
//exifImgPart="2";//정상적으로 exif정보를 읽습니다.


 try{
  Metadata metadata = JpegMetadataReader.readMetadata(jpegFile);
  
  String exifMake = "";
  String exifModel = "";
  //iterate through metadata directories
  Iterator directories = metadata.getDirectoryIterator();%>
  
  <div class="inter-box">
	<div class="scroll-box">
		  <img src="<%=dbImgPath %>" class="imgStyle">
	<table class="tableStyle">
		<colgroup>
			<col width="50%" style="background-color:#d29cf0;">
			<col width="50%">
		</colgroup>
  <%
	  while (directories.hasNext()) {
	   //System.out.println("----------------------------------------------------------------------");
	                
	      Directory directory = (Directory)directories.next();
	      // iterate through tags and print to System.out
	      Iterator tags = directory.getTagIterator();
	      while (tags.hasNext()) {
		          Tag tag = (Tag)tags.next();
		          %>
	    	  	<tr>
	    	  		<td><%= tag.getTagName()%></td><td><%= tag.getDescription()%></td>
				</tr>
	    	  	<%
		          /* if("Make".equals(tag.getTagName())){
		           exifMake = tag.getDescription();
		           System.out.println(exifMake);
		          }
		          if("Model".equals(tag.getTagName())){
		           exifModel = tag.getDescription();
		           System.out.println(exifModel);
		          } */
	      }
	       //회사명과 모델명이 검색되면 while을 중지 시킨다.
	      if(!"".equals(exifMake) && !"".equals(exifModel)){
	      exifImgPart="2";//정상적으로 exif정보를 읽습니다.
	      System.out.println("break : "+ exifImgPart);
	       break;
	      } 
	  }
 }catch(Exception ex){
     exifImgPart = "1";//jpg 파일이 아닙니다.
 	 ex.printStackTrace();
 	System.out.println("catch"+ exifImgPart);
 }
 
%>
</table>
	</div>
	<input type="button" class="btn btn-primary backBtn" onclick="backPage()" value="리스트로 돌아가기">
</div>
<%
String[] backNum = request.getParameterValues("backnum");
String zoom = request.getParameter("zoom");
%>
<script>
function backPage(){
	var newForm = document.createElement("form");
	newForm.name = "newForm";
	newForm.method = "post";
	newForm.action="list.jsp";
	
	var zoomVal = document.createElement("input");
	zoomVal.setAttribute("type","hidden");
	zoomVal.setAttribute("name","zoom");
	zoomVal.setAttribute("value",<%= zoom%>);
	newForm.appendChild(zoomVal);
	<%
	for(int i=0; i < backNum.length; i++){
	%>
	var backnum = document.createElement("input");
	backnum.setAttribute("type","hidden");
	backnum.setAttribute("name","num");
	backnum.setAttribute("value",<%= backNum[i] %>);
	newForm.appendChild(backnum);
	<%}%>
	document.body.appendChild(newForm);
	newForm.submit();
}
</script>
</body>
</html>