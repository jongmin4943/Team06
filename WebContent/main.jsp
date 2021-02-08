<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
</head>

<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
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
		<div class="container-fluid">
			<div class="col-md-4 col-sm-6">
				<div class="portfolio-item">
					<a href="img/meal5.jpg" data-lightbox="image-1"><div
							class="thumb">
							<a href="myList.jsp">
								<div class="hover-effect">
									<div class="hover-content">
										<h1>
											내 맛집 <em>My restaurant</em>
										</h1>
										<p>내가 가본 맛집 List</p>
									</div>
								</div>
								<div class="image">
									<img src="img/meal5.jpg">
								</div>
						</div></a>
				</div>
			</div>
			<div class="col-md-4 col-sm-6">
				<div class="portfolio-item">
					<a href="img/big_portfolio_item_2.jpg" data-lightbox="image-1"><div
							class="thumb">
							<a href="myList.jsp">
								<div class="hover-effect">
									<div class="hover-content">
										<h1>
											내 여행지 <em>My Trip</em>
										</h1>
										<p>내가 가본 여행지 List</p>
									</div>
								</div>
								<div class="image">
									<img src="img/portfolio_item_2.jpg">
								</div>
						</div></a>
				</div>
			</div>
			<div class="col-md-4 col-sm-6">
				<div class="portfolio-item">
					<a href="img/big_portfolio_item_3.jpg" data-lightbox="image-1"><div
							class="thumb">
							<a href="naverMap.jsp">
								<div class="hover-effect">
									<div class="hover-content">
										<h1>
											검색 <em>Search Places</em>
										</h1>
										<p>관광지, 맛집 검색</p>
									</div>
								</div>
								<div class="image">
									<img src="img/portfolio_item_3.jpg">
								</div>
						</div></a>
				</div>
			</div>

		</div>
	</div>


	<footer>
		<div class="container-fluid">
			<div class="col-md-12">
				<p>Copyright &copy; Team06 | Designed by TemplateMo</p>
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
						<li><a href="myList.jsp">My Trips</a></li>
						<li><a href="aboutUs.jsp">About Us</a></li>
					</ul>
				<%
					} else { 
				%>
					<ul>
						<li><a href="main.jsp">Home</a></li>
						<li><a href="userAccount.jsp">My Account</a></li>
						<li><a href="myList.jsp">My Trips</a></li>
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