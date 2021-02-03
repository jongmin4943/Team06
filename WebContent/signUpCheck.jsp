<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %> <!-- post방식으로 넘어온 자료 읽기 -->
<%@ page import="user.UserDao" %><!-- import dao -->
<%@ page import="java.io.PrintWriter" %><!-- json파일 읽기위해 가져옴 -->
<jsp:useBean id="user" class="user.UserDto" scope="page" /><!--scope는 현재 페이지만 적용되게 함. -->
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userEmail"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" content="text/html">
<title>Sign Up Checking</title>
</head>
<body>
<%
	UserDao dao = new UserDao();
	int a = dao.insert(user);
	PrintWriter script = response.getWriter();
	if(a == -1) {
	script.println("<script>");
	script.println("alert('이미 존재하는 아이디입니다.')");
	script.println("location.href = 'main.jsp'");
	script.println("</script>");
	} else {
	script.println("<script>");
	script.println("alert('회원가입 되셨습니다.')");
	script.println("location.href = 'main.jsp'");
	script.println("</script>");
	}
%>

</body>
</html>