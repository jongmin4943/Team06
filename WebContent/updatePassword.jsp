<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ page import="data.UserDao" %>
<%@ page import="data.UserDto" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="user" class="data.UserDto" scope="page" />
<jsp:setProperty name="user" property="userID" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>구현중</h2>
</body>
</html>