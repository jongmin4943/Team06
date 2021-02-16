<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!-- post방식으로 넘어온 자료 읽기 -->
<%@ page import="data.UserDao"%><!-- import dao -->
<%@ page import="data.UserDto"%><!-- import dao -->
<%@ page import="java.io.PrintWriter"%><!-- json파일 읽기위해 가져옴 -->
<%@ page import="java.util.List"%><!-- json파일 읽기위해 가져옴 -->
<jsp:useBean id="user" class="data.UserDto" scope="page" /><!--scope는 현재 페이지만 적용되게 함. -->
<jsp:setProperty name="user" property="userID" />
<!-- signin 페이지의 form에서 넘어온 userID, userPassword를 bean에 추가 -->
<jsp:setProperty name="user" property="userPassword" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" content="text/html">
<title>Sign In Checking</title>
</head>
<body>
	<%
	String userID = null;
	PrintWriter pr = response.getWriter();
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	if(userID != null) {
		pr.println("<script>");
		pr.println("alert('로그인 상태입니다.')");
		pr.println("location.href = 'main.jsp'");
		pr.println("</script>");
	}
	UserDao dao = new UserDao();
	boolean check = dao.loginCheck(user.getUserID(), user.getUserPassword());
	if(check) {
		session.setAttribute("userID", user.getUserID());
		session.setAttribute("guestID", user.getUserID());
		pr.println("<script>");
		pr.println("alert('로그인 성공!')");
		pr.println("history.go(-2);");
		pr.println("</script>");
	} else {
		pr.println("<script>");
		pr.println("alert('아이디나 패스워드가 틀렸습니다.')");
		pr.println("history.back();");
		pr.println("</script>");
	}
%>

</body>
</html>