<%@page import="java.util.List"%>
<%@page import="data.UserDao"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter"%>
<html>
<head>
<meta charset="utf-8">
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
<script src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
        function checkValue(){
        	var emailCheck = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
        	var input = document.userInfo;
            if(!input.userID.value){
                alert("아이디를 입력하세요.");
                return false;
            }
            
            if(!input.userPassword.value){
                alert("비밀번호를 입력하세요.");
                return false;
            } else if (input.userPassword.value.length < 4) {
            	alert("비밀번호가 너무 짧습니다.")
            	return false;
            }
            
            if(input.userPassword.value != input.userPasswordCheck.value ){
                alert("비밀번호를 동일하게 입력하세요.");
                return false;
            }
            
            if(!input.userName.value){
                alert("이름을 입력하세요.");
                return false;
            }
            if(!input.userEmail.value){
                alert("이메일을 입력하세요.");
                return false;
            } else if(!(emailCheck.test(input.userEmail.value))){
            	alert("이메일 형식이 틀렸습니다.")
            	return false;
            }
        }
        
        // 취소 버튼 클릭시 로그인 화면으로 이동
        function goSignInForm() {
            location.href="signIn.jsp";
        }
$(function() {
	$('#userID').keyup(function(){
		userID= $('#userID').val();
		var id = {
				userID : $('#userID').val()
		};
		if(!userID) {
			 $("#showResult").html("");
		} else {
			$.post("idcheck.jsp",id,function(data,status) {
				var avail = data;
				  if(avail.possible == "Yes") {
					  $("#showResult").html("사용 가능한 아이디");
					  $("#showResult").css('color','blue');
				  } else if(avail.possible == "Nolength") {
					  $("#showResult").html("5글자 이상 입력해주세요");
					  $("#showResult").css('color','red');
				  } else if(avail.possible == "NoReg"){
					  $("#showResult").html("영문자와 숫자만 입력 가능합니다");
					  $("#showResult").css('color','red');
				  } else if(avail.possible == "No"){
					  $("#showResult").html("중복된 아이디");
					  $("#showResult").css('color','red');
				  } else {
					  $("#showResult").html("");
				  }
			});
		}
	});
});
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
%>
	<nav>
		<div class="logo">
			<a href="main.jsp">My <em>Journey</em> <b><font size="6"
					color="gray">Sign Up</font></b></a>
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
		<!-- 컨테이너 클래스 이용 -->
		<div class="col-lg-4"></div>
		<!-- 창을 중앙으로 모으기 -->
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top: 20px;">
				<!-- 점보트론 박스 이용. 중앙에서 시작할수있게 탑에서 20패딩 -->
				<form method="post" action="signUpCheck.jsp" name="userInfo"
					onsubmit="return checkValue()">
					<h3 style="text-align: center;">Sign Up</h3>
					<div class="form-group">
						<!-- 위에서 아래로 내려오는 폼 작성 -->
						<input type="text" class="form-control" placeholder="ID"
							name="userID" maxlength="20" id="userID">
							<div id="showResult"></div><!--아이디 중복체크 결과 넣기-->
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="Password"
							name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control"
							placeholder="Confirm Password" name="userPasswordCheck"
							maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="Name"
							name="userName" maxlength="10">
					</div>
					<div class="form-group">
						<input type="email" class="form-control"
							placeholder="Email Address" name="userEmail" maxlength="30">
					</div>
					<input class="btn" type="submit" value="Sign Up"> <input
						class="btn" type="button" value="Cancle" onclick="goSignInForm()">
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
						<li><a href="myList.jsp?where=mixed">My Trips</a></li>
						<li><a href="aboutUs.jsp">About Us</a></li>
					</ul>
					<p>We create awesome lists for you.</p>
				</div>
			</div>
		</div>
	</section>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
	<script src="js/vendor/bootstrap.min.js"></script>
	<script src="js/plugins.js"></script>
	<script src="js/main.js"></script>

</body>
</html>


