<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!-- post방식으로 넘어온 자료 읽기 -->
<%@ page import="data.UserDao"%><!-- import dao -->
<%@ page import="data.UserDto"%><!-- import dto -->
<%@ page import="java.io.PrintWriter"%><!-- json파일 읽기위해 가져옴 -->
<jsp:useBean id="user" class="data.UserDto" scope="page" /><!--scope는 현재 페이지만 적용되게 함. -->
<jsp:setProperty name="user" property="userID" />
<!-- 빈 user에 접근, value에 signup 페이지에서 넘어온 -->
<jsp:setProperty name="user" property="userPassword" />
<!-- value들 넣는다.-->
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userEmail" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" content="text/html">
<title>Sign Up Checking</title>
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
	int a = dao.insert(user);
	if(a == -1) {/* insert() 는 retrun값으로 pstmt.executeUpdate()의 int값을 받는다. 실행중 오류가 나면  */
	pr.println("<script>");/* 예를 들면 PRIMARY KEY로 등록한 ID가 같아서 데이터 베이스에서 못받아 Exception이 생기면 */
	pr.println("alert('이미 존재하는 아이디입니다.')"); /* -1을 반환 한다. */
	pr.println("history.back();");
	pr.println("</script>");
	} else {
	pr.println("<script>");
	pr.println("alert('회원가입 되셨습니다.')");
	pr.println("location.href = 'signIn.jsp'");
	pr.println("</script>");
	}
%>

</body>
</html>