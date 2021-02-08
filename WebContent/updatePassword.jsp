<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<%@ page import="data.UserDao" %>
<%@ page import="data.UserDto" %>
<%@ page import="java.io.PrintWriter" %>
<jsp:useBean id="user" class="data.UserDto" scope="page" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Updating New Password</title>
</head>
<body>
	<%
	String userID = request.getParameter("userID");
	PrintWriter pr = response.getWriter();
	int update = UserDao.updatePassword(userID,user.getUserPassword());
	if(update == -1) {
		pr.println("<script>");
		pr.println("alert('서버 연동 실패')");
		pr.println("history.back();");
		pr.println("</script>");
		
	} else {
		pr.println("<script>");
		pr.println("alert('변경되었습니다')");
		pr.println("location.href = 'signIn.jsp'");
		pr.println("</script>");
	}
	%>

</body>
</html>