<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
String userID = request.getParameter("userID");
%>
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8" pageEncoding="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>My Journey</title>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="apple-touch-icon" href="apple-touch-icon.jpg">

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/bootstrap-theme.min.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/fontAwesome.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/light-box.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/templatemo-style.css">

<link
	href="https://fonts.googleapis.com/css?family=Kanit:100,200,300,400,500,600,700,800,900"
	rel="stylesheet">

<script src="./js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function checkValue() {
		if (!document.userInfo.userPassword.value) {
			alert("비밀번호를 입력하세요.");
			return false;
		}
		if (document.userInfo.userPassword.value != document.userInfo.userPasswordCheck.value) {
			alert("비밀번호를 동일하게 입력하세요.");
			return false;
		}
	}

	function goSignInForm() {
		location.href = "signIn.jsp";
	}
</script>
<style type="text/css">
body {
	background-color: darkgray;
}

.btn {
	width: 75px;
	height: 35px;
	border-color: gray;
}
</style>
</head>
<body>
	<nav>
		<div class="logo">
			<a href="main.jsp">My <em>Journey</em> <b><font size="6"
					color="gray">Reset Password</font></b></a>
		</div>
		<div class="menu-icon">
			<span></span>
		</div>
	</nav>
	<br>
	<br>
	<br>
	<br>
	<br>
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px">
			
				<form method="post" action="updatePassword.jsp" name="userInfo"
					onsubmit="return checkValue()">
					<h3 style="text-align: center;">Reset Password</h3>
					<div class="form-group">
						<input type="password" class="form-control"
							placeholder="New Password" name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control"
							placeholder="Confirm Password" name="userPasswordCheck"
							maxlength="20">
					</div>
					<input class="btn" type="submit" value="Reset"> 
					<input type="hidden" name="userID" value="<%=userID%>" /> <!--넘어온 id값을 update쪽에 넘긴다-->
					<input class="btn" type="button" value="Cancle" onclick="goSignInForm()">
				</form>
			</div>
		</div>
	</div>
	<section class="overlay-menu">
		<div class="container">
			<div class="row">
				<div class="main-menu">
					<ul>
						<li><a href="main.jsp">Home</a></li>
						<li><a href="signIn.jsp">Sign - In</a></li>
						<li><a href="myList.jsp">My Trips</a></li>
						<li><a href="aboutUs.jsp">About Us</a></li>
					</ul>
					<p>We create awesome lists for you.</p>
				</div>
			</div>
		</div>
	</section>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script>
		window.jQuery
				|| document
						.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')
	</script>
	<script src="js/vendor/bootstrap.min.js"></script>
	<script src="js/plugins.js"></script>
	<script src="js/main.js"></script>

</body>
</html>