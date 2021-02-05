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
	UserDao dao = new UserDao();
	PrintWriter pr = response.getWriter();
	
	int check = dao.confirmUser(user.getUserID(),user.getUserName(),user.getUserEmail());
	if(check == 1) {
		pr.println("<script>");
		pr.println("location.href = 'resetPassword.jsp'");
		pr.println("</script>");
	} else if(check == -1){
		pr.println("<script>");
		pr.println("alert('입력하신 정보가 존재하지 않습니다.')");
		pr.println("history.back();");
		pr.println("</script>");
	}
%>



</body>
</html>