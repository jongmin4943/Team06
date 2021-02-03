<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %> <!-- post방식으로 넘어온 자료 읽기 -->
<%@ page import="user.UserDao" %><!-- import dao -->
<%@ page import="user.UserDto" %><!-- import dao -->
<%@ page import="java.io.PrintWriter" %><!-- json파일 읽기위해 가져옴 -->
<%@ page import="java.util.List" %><!-- json파일 읽기위해 가져옴 -->
<jsp:useBean id="user" class="user.UserDto" scope="page" /><!--scope는 현재 페이지만 적용되게 함. -->
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" content="text/html">
<title>Sign In Checking</title>
</head>
<body>
<%
	UserDao dao = new UserDao();
	PrintWriter script = response.getWriter();
	List<UserDto> a = dao.getAll();
	for(int i=0; i<a.size(); i++) {
		if(a.get(i).getUserID().equals(user.getUserID())) {
			if(a.get(i).getUserPassword().equals(user.getUserPassword())) {
				script.println("<script>");
				script.println("alert('로그인 성공!')");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		} else if(i == a.size()-1) {
			script.println("<script>");
			script.println("alert('아이디나 패스워드가 틀렸습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
	}
%>

</body>
</html>