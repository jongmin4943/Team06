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
		pr.println("<script>");
		pr.println("alert('로그인 성공!')");
		pr.println("location.href = 'main.jsp'");
		pr.println("</script>");
	} else {
		pr.println("<script>");
		pr.println("alert('아이디나 패스워드가 틀렸습니다.')");
		pr.println("history.back();");
		pr.println("</script>");
	}
	/* List<UserDto> a = dao.getAll();
	 for(int i=0; i<a.size(); i++) {   모든 데이터를 불러와서 비교하는데 너무 비효율적인거같다. 좀 더 효율적인 방법을 생각해보자 
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
			script.println("location.href = 'signIn.jsp'"); 틀릴시 다시 로그인 페이지로 전달. 뒤로가기로 만들면 좋을거같다.
			script.println("</script>");
		}
	} */
%>

</body>
</html>