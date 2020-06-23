<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="imgInfo.ImginfoDAO"%>
<%@ page import="net.coobird.thumbnailator.Thumbnails"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
request.setCharacterEncoding("UTF-8"); 
String lat = request.getParameter("lat");
String lng = request.getParameter("lng");
String sub = request.getParameter("sub");
String con = request.getParameter("con");

java.util.Calendar cal = java.util.Calendar.getInstance();
String year = Integer.toString(cal.get ( cal.YEAR ));
String month = Integer.toString(cal.get ( cal.MONTH ) + 1) ;
String time = year + month;

String uploadFolder = "upload/" + time;
ServletContext context = getServletContext();
String uploadPath = context.getRealPath(uploadFolder);

File Folder = new File(uploadPath);

if(!Folder.exists()) {
	try{
	    Folder.mkdir(); //폴더 생성합니다.
        } 
        catch(Exception e){
	    e.getStackTrace();
	} 
}

String thumbnailFolder = "thumbnail/" + time;
ServletContext context2 = getServletContext();
String thumbnailPath = context2.getRealPath(thumbnailFolder);

File thumbFolder = new File(thumbnailPath);

if(!thumbFolder.exists()) {
	try{
		thumbFolder.mkdir(); //폴더 생성합니다.
        } 
        catch(Exception e){
	    e.getStackTrace();
	} 
}

int size = 10*1024*1024;
String imgName = "";
try{
    MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());
	
    
    Enumeration files = multi.getFileNames();
    String img = (String)files.nextElement();
    imgName = multi.getFilesystemName(img);
    String fullPath = "/project/upload/" + time + "/" + imgName;
    
    String originPath = uploadPath + "/" + imgName;
   String saveThumbPath = thumbnailPath + "/" + imgName;
   	Thumbnails.of(originPath).size(180,180).toFile(saveThumbPath);
    
    ImginfoDAO imginfoDAO = new ImginfoDAO();
if(lat == null || lng == null || lat =="" || lng == ""){
%>
	<script>
		alert("오류가 발생했습니다");
		window.history.back();
	</script>
<%
}else{
    imginfoDAO.upImgInfo(lat, lng, fullPath, sub, con);
}
}catch(Exception e){
    e.printStackTrace();
}


%>

<script>
	location.href="https://54.180.24.137:8443/project/mapsurfing.jsp";
	//location.href="https://110.12.74.87:8443/project/mapsurfing.jsp";
	//location.href="https://localhost:8443/project/mapsurfing.jsp";
</script>

</body>
</html>