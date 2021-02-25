<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="board.BoardDto"%>
<%@page import="board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userID=null;
PrintWriter pr = response.getWriter();
if(session.getAttribute("userID") != null) {		
	userID = (String)session.getAttribute("userID");
}
if(userID == null) { //세션을 가지고 있지 않으면 접근 불가
	pr.println("<script>");
	pr.println("alert('로그인 해주세요.')"); 
	pr.println("top.location.href = 'signIn.jsp'");
	pr.println("</script>");
}
String uploadPath = application.getRealPath("/img");
//String uploadPath3 = request.getSession().getServletContext().getRealPath("/img");
String userName = (String)session.getAttribute("userID");
int size = 10*1024*1024;
String name1="";
String filename1="";
String origfilename1="";
request.setCharacterEncoding("utf-8");
String fileName = request.getParameter("partFile1");
MultipartRequest multi= null;
try{
	multi=new MultipartRequest(request,
						uploadPath,
						size, 
						"UTF-8",
			new DefaultFileRenamePolicy());
		name1=multi.getParameter("name");
	
	Enumeration<?> files=multi.getFileNames();
	
	String file1 =(String)files.nextElement();
	filename1=multi.getFilesystemName(file1);
	origfilename1= multi.getOriginalFileName(file1);
	
}catch(Exception e){
	e.printStackTrace();
}
//int idx = uploadPath.indexOf("Team06")+6;
//String realPath = uploadPath.substring(idx,uploadPath.length());

String no= multi.getParameter("no");
String name= multi.getParameter("name");
String title= multi.getParameter("title");
String writer= multi.getParameter("writer");
String textarea= multi.getParameter("textarea");
String selector= multi.getParameter("selector");
if(origfilename1 == null) {
	origfilename1 = BoardDao.selectOne(new BoardDto(no)).getPicUrl();
}
BoardDao.modify(new BoardDto(no,title,name,textarea,writer,"NOW()",selector,null,origfilename1));

response.sendRedirect("boardView.jsp?no="+no);
%>