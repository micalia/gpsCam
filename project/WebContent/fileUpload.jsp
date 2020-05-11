<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	
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

int size = 10*1024*1024;
String imgName = "";
	
try{
    MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());
		
    Enumeration files = multi.getFileNames();
    String img = (String)files.nextElement();
    imgName = multi.getFilesystemName(img);
    /* String file2 = (String)files.nextElement();
    filename2=multi.getFilesystemName(file2); */
}catch(Exception e){
    e.printStackTrace();
}
%>
<body>
<script>
	history.back();
</script>
</body>
</html>