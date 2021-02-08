<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<%@ page import="data.UserDao"%>
<%@ page import="data.UserDto"%>
<%@ page import="java.io.PrintWriter"%>
<jsp:useBean id="user" class="data.UserDto" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" content="text/html">
<title>Reset Password</title>
</head>
<body>
	<%
	PrintWriter pr = response.getWriter();
	
	boolean check = UserDao.confirmUser(user.getUserID(),user.getUserName(),user.getUserEmail());
	if(check) {
		String userID = request.getParameter("userID");
		pr.println("<script>");
		pr.print("location.href = 'resetPassword.jsp?userID=");
		pr.println(userID+"'");//get으로 넘어온 id값을 reset페이지쪽에 넘겨준다
		pr.println("</script>");
	} else {
		pr.println("<script>");
		pr.println("alert('입력하신 정보가 존재하지 않습니다.')");
		pr.println("history.back();");
		pr.println("</script>");
	}
%>



</body>
</html>