<%@page import="java.io.PrintWriter"%>
<%@page import="board.BoardDto"%>
<%@page import="board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
String title = request.getParameter("title");
String name = request.getParameter("name");
String textarea = request.getParameter("textarea");
String writer = request.getParameter("writer");
String no = request.getParameter("no");
BoardDto dto = new BoardDto(no,title,name,textarea,writer);
BoardDao.insert(dto);

response.sendRedirect("boardList2.jsp");
%>
