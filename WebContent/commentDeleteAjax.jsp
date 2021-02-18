<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.List"%>
<%@page import="comment.CommentDto"%>
<%@page import="comment.CommentDao"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
%>

<%
String guestID=null;
PrintWriter pr = response.getWriter();
if(session.getAttribute("guestID")!=null) {
	guestID = (String)session.getAttribute("guestID");
}
String commentNo = request.getParameter("commentNo");
CommentDao cDao = new CommentDao();
cDao.delete(commentNo);
JSONObject sendObj = new JSONObject();
sendObj.put("sent","deleted");
out.print(sendObj);
%>