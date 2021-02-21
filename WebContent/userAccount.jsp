<%@page import="data.UserDto"%>
<%@page import="java.util.List"%>
<%@page import="data.UserDao"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<style type="text/css">
body {
	background-color: darkgray;
}
label {
	display: inline-block;
	width: 100px;
}
p {
	margin: 5px 0;
}
input {
	margin: 5px;
}
</style>
<script src="http://code.jquery.com/jquery.js"></script>
</head>
<body>
<%
	String userID = null;
	String userName = null;
	String userEmail = null;
	String profileUrl = null;
	PrintWriter pr = response.getWriter();
	if(session.getAttribute("userID") != null) {		
		userID = (String)session.getAttribute("userID");
	}
	if(userID == null) { //세션을 가지고 있지 않으면 접근 불가
		pr.println("<script>");
		pr.println("alert('로그인 해주세요.')"); 
		pr.println("location.href = 'signIn.jsp'");
		pr.println("</script>");
	}
	UserDao dao = new UserDao();
	UserDto dto = dao.selectUser(userID);	//세션에서 나온 아이디값으로 이 아이디의 정보를 데이터베이스에서 가져옴
	if(dto != null){
		userEmail = dto.getUserEmail(); // 이 공간에 뭐든 담아줄수있음.
		userName = dto.getUserName(); 
		profileUrl = dto.getProfileUrl(); 
	} else {
		pr.println("<script>");
		pr.println("alert('로그인을 해주세요')");
		pr.println("location.href = 'signIn.jsp'");
		pr.println("</script>");
	}
%>
<script type="text/javascript">
$(function(){	//빈 텍스트 칸에 위에서 나온 정보들을 담아줌
	$("#id").val(<%='"'+userID+'"'%>);
	$("#email").val(<%='"'+userEmail+'"'%>);
	$("#profile").attr("src", "img/"+<%='"'+profileUrl+'"'%>)
	$('#loca').change(function(){  //사진 선택후 프리뷰
		var fakePath = this.value;
		var fakeIdx = fakePath.indexOf("th\\")+3;
		var realPath = fakePath.substr(fakeIdx,fakePath.length);
		$("#profile").attr("src", "img/"+realPath);
	});
});
function goResetPassword() {	//비밀번호 리셋사이트로 유저 아이디정보와 함께 넘어감
    location.href="resetPassword.jsp?userID="+<%='"'+userID+'"'%>;
}
function goSignOut() {	//로그아웃
    location.href="signOut.jsp";
}
</script>
	<nav>
		<div class="logo">
			<a href="main.jsp">My <em>Journey</em> <b><font size="6"
					color="gray">My Account</font></b></a>
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
			<div class="jumbotron jumbotron-fluid" style="padding-top: 20px;">
			<form action="deleteAccount.jsp" onsubmit="return confirm('정말 삭제하시겠습니까?')" method="post" name="userInfo" id="userInfo">
				<fieldset class="form-group">
					<legend><%=userName%>님의 회원정보</legend><!-- 위에서 날아온 userID를 담아서 실시간으로 보여줌 -->
						<h3 class="form-group" style="text-align: center;">My Account</h3>
						<p><label for="id">아이디</label><input class="form-control" style="margin-right : 20px" readonly type="text" name="id" id="id"/></p><!-- readonly로 수정 불가 -->
						<p><label for="email">이메일</label><input class="form-control" readonly type="email" name="email" id="email" /></p><!-- readonly로 수정 불가 -->
						<input style="margin-left : 0" type="button" value="비밀번호 바꾸기" onclick="goResetPassword()"/>
						<input style="margin-left : 5px" type="button" value="로그아웃" onclick="goSignOut()"/>
						<input style="margin-left : 0px" type="submit" value="탈퇴하기"/>
				</fieldset>
			</form>
			
			
			<form id="img" action="profileUpload.jsp" method="post" enctype="multipart/form-data" onsubmit="return confirm('수정하시겠습니까')">
				<fieldset class="form-group">
					<legend>프로필</legend><!-- 위에서 날아온 userID를 담아서 실시간으로 보여줌 -->
						<h3 class="form-group" style="text-align: center;">My Profile</h3>
						<img id="profile" src="" style="width:200px;height:150px;margin-bottom:10px;">
						<input id = "loca" type = "file" name = "partFile1" id = "partFile1"> <!-- preview 이미지 -->
						<input style="margin-top: 10px"type = "submit" value = "사진수정"/>
						<br>
						<br>
						<a href="myList.jsp?where=myList" style="text-align:center;">내가 기록한 글 보러 가기</a>
				</fieldset>
			</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	
	<section class="overlay-menu">
		<div class="container">
			<div class="row">
				<div class="main-menu">
					<ul>
						<li><a href="main.jsp">Home</a></li>
						<li><a href="signOut.jsp">Sign - Out</a></li> <!-- 이 페이지는 세션정보를 가진사람만 접근가능하므로 Sign-In은 필요없음 -->
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