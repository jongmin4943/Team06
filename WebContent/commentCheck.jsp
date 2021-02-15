<%@page import="comment.CommentDao"%>
<%@page import="comment.CommentDto"%>
<%@page import="java.io.PrintWriter"%>
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
	pr.println("location.href = 'signIn.jsp'");
	pr.println("</script>");
}
String content = request.getParameter("textarea");
String no = request.getParameter("no");
CommentDao cDao = new CommentDao();
cDao.insertComment(new CommentDto(userID,no,content,null));
response.sendRedirect("boardView.jsp?no="+no);
%>