<%@page import="java.io.PrintWriter"%>
<%@page import="board.BoardDto"%>
<%@page import="board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.json.JSONObject"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%!
%>
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

String title = multi.getParameter("title");
String name = multi.getParameter("name");
String textarea = multi.getParameter("textarea");
String writer = multi.getParameter("writer");
String no = multi.getParameter("no");
String selector = multi.getParameter("selector");

BoardDto dto = new BoardDto(no,title,name,textarea,writer,"NOW()",selector,BoardDao.getCommentCount(no),origfilename1);
BoardDao.insert(dto);
BoardDto currDto = BoardDao.selectOneAfterInsert(dto);

response.sendRedirect("boardView.jsp?no="+currDto.getNo());
%>
