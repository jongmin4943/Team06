<%@page import="java.util.List"%>
<%@page import="board.BoardDto"%>
<%@page import="board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
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
<style>
.hoyList {
	font-size : 20px;
}
a:link{
	color:black;
}
a:visited{
	color:black;
}
</style>
</head>

<body style="background-color:#333;">
	<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	BoardDao bDao = new BoardDao();
	List<BoardDto> list = bDao.selectLatelyHotboard();
%>

	<nav>
		<div class="logo">
			<a href="main.jsp">My <em>Journey</em></a>
		</div>
		<div class="menu-icon">
			<span></span>
		</div>
	</nav>

	<div id="video-container">
		<div class="video-overlay"></div>
		<div class="video-content">
			<div class="inner">
				<h1>
					Welcome to <em>My Journey</em>
				</h1>
				<p>내가 가본 맛집, 관광지를 정리해보세요!</p>
				<p>다른 사람의 의견도 참고해보세요!</p>
				<div class="scroll-icon">
					<a class="scrollTo" data-scrollTo="portfolio" href="#"><img
						src="img/scroll-icon.png" alt=""></a>
				</div>
			</div>
		</div>
		<video autoplay loop muted>
			<source src="img/highway-loop.mp4" type="video/mp4" />
		</video>
	</div>


	<div class="full-screen-portfolio" id="portfolio">
		<div class="container-fluid" style="background-color:lightgray;">
			<div class="col-md-4 col-sm-6">
				<div class="portfolio-item">
					<div class="thumb">
						<a href="myList.jsp?where=myList">
							<div class="hover-effect">
								<div class="hover-content">
									<h1>
										나의 기록들 <em>My Trips</em>
									</h1>
									<p>내가 기록한 맛집,관광지들 보기</p>
								</div>
							</div>
							<div class="image">
								<img src="img/meal5.jpg">
							</div>
						</a>
					</div>
				</div>
			</div>
			<div class="col-md-4 col-sm-6">
				<div class="portfolio-item">
					<div class="thumb">
						<a href="myList.jsp?where=mixed">
							<div class="hover-effect">
								<div class="hover-content">
									<h1>
										모든 기록들 <em>People's Journey</em>
									</h1>
									<p>다른 사람들 기록 둘러보기</p>
								</div>
							</div>
							<div class="image">
								<img src="img/portfolio_item_2.jpg">
							</div>
						</a>
					</div>
				</div>
			</div>
			<div class="col-md-4 col-sm-6" >
				<div class="portfolio-item">
					<div class="thumb">
						<div class="hover-effect">
							<div class="hover-content" style="padding-bottom:50px; padding-left:40px">
								<h2 style="color:black; text-shadow:#ccc 1px 0px 10px; ">
									<b>이 주의 인기글 </b>
								</h2>
								<p>&nbsp;</p>
									<%for(int i = 0; i<list.size(); i++) { %>
									<em style = "color:red; font-size:19px; float:left; padding-right:3px;">[<%=i+1%>] </em>
									<a style = "font-size:20px; float:left;" href = 'myList.jsp?no=<%=list.get(i).getNo() %>&where=viewBoard'><%=list.get(i).getTitle() %></a>
									<p style = "color:blue; font-size:18px;"> [<%=list.get(i).getCountCom() %>]</p>
									<br />
									<%}%>
							</div>
						</div>
						<div class="image">
								<img src="img/gaesi.png">
							</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<footer style="background-color:#333;">
		<div class="container-fluid">
			<div class="col-md-12">
				<p>Copyright &copy; Team06 | Created by 박찬우, 윤종민</p>
			</div>
		</div>
	</footer>





	<section class="overlay-menu">
		<div class="container">
			<div class="row">
				<div class="main-menu">
					<%
					if(userID == null) {
				%>
					<ul>
						<li><a href="main.jsp">Home</a></li>
						<li><a href="signIn.jsp">Sign - In</a></li>
						<li><a href="myList.jsp?where=mixed">My Trips</a></li>
						<li><a href="aboutUs.jsp">About Us</a></li>
					</ul>
					<%
					} else { 
				%>
					<ul>
						<li><a href="main.jsp">Home</a></li>
						<li><a href="userAccount.jsp">My Account</a></li>
						<li><a href="myList.jsp?where=mixed">My Trips</a></li>
						<li><a href="aboutUs.jsp">About Us</a></li>
						<li><a href="signOut.jsp">Sign - Out</a></li>
					</ul>
					<%
					}
				%>
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