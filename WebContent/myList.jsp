<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>My Journey</title>

<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="apple-touch-icon" href="apple-touch-icon.jpg">

        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap-theme.min.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/fontAwesome.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/light-box.css">
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/templatemo-style.css">
		
        <link href="https://fonts.googleapis.com/css?family=Kanit:100,200,300,400,500,600,700,800,900" rel="stylesheet">

<script src="js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>
<meta charset="UTF-8">
<title>My List</title>
</head>
<style>
a:link{
	text-decoration: none;
}
iframe {
	width: 100%;
	height: 100%;
	padding-top: 80px;

}
.inner a:link{
	text-decoration:none;
}
</style>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	String no = request.getParameter("no");
	String loca = request.getParameter("where");
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
				<h2><a href="myList.jsp?where=mixed" style="text-decoration:none">: : : 전체 목록 : : : </a></h2>
				<br />
				<br />
				<br />
				<h2><a href="boardMyList.jsp?userID="<%=userID%> target="myList" style="text-decoration:none">: : :   내 목록 : : :</a></h2>

				<%if(loca.equals("mixed")) {%>
					<iframe src="boardList2.jsp" name="myList"></iframe>
				<%} else if(loca.equals("myList")){%>
					<iframe src="boardMyList.jsp?userID="<%=userID%> name="myList" ></iframe>
				<%} else if(loca.equals("viewBoard")) {%>
					<iframe src="boardView.jsp?no=<%=no%>"></iframe>
				<%} else {%>
					<iframe src="boardList2.jsp" name="myList"></iframe>
				<%}%>
			</div>
		</div>
		<video autoplay loop muted>
			<source src="img/highway-loop.mp4" type="video/mp4" />
		</video>
	</div>

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


    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
	<script src="js/vendor/bootstrap.min.js"></script>

	<script src="js/plugins.js"></script>
	<script src="js/main.js"></script>
</body>
</html>