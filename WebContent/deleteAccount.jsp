<%@page import="data.UserDto"%>
<%@page import="data.UserDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
<%
String userID = request.getParameter("id");
UserDao dao = new UserDao();
UserDto user = dao.selectUser(userID);
dao.delete(user);
%>
alert("탈퇴 되었습니다.");
location.href="signOut.jsp";
</script>
</body>
</html>