<%@page import="board.BoardDao"%>
<%@page import="board.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
	crossorigin="anonymous">
<style>
body {
	width: 1300px;
	padding: 100px;
	background-color: rgb(238, 242, 242);
}

table {
	width: 1100px;
	board: 1px;
}

.menu {
	width: 100px;
	background-color: lightgray;
	padding: 2px;
	border: 1px;
	text-align: center;
}

.menu2 {
	padding:0px 10px;
	border:1px solid gray;
	width:1000px;
}

#comment {
	height: 500px;
}
a{
margin:2px;
}
</style>
<body data-mode="day">
	<input type="image" src="img/nightbtn.png" id="changebtn" align="right"
		onclick="
	if(document.querySelector('body').dataset.mode ==='day'){
		document.querySelector('body').style.backgroundColor = 'gray';
		document.querySelector('body').style.color = 'white';	
		document.querySelectorAll('.menu2').style.color = 'white';	
		document.querySelectorAll('.menu').style.color = 'white';	
		document.querySelector('body').dataset.mode = 'night'
		this.src = 'img/daybtn.png'
	}else{
		document.querySelector('body').style.backgroundColor = 'rgb(238,242,242)';
		document.querySelector('body').style.color = 'black';	
		document.querySelector('.menu2').style.color = 'black';			
		document.querySelector('body').dataset.mode = 'day'
		this.src = 'img/nightbtn.png'	
	}
">
	<%
	String no = request.getParameter("no");
/* 	out.println("no => " + no); */
	BoardDto board = BoardDao.selectOne(new BoardDto(no));
/* 	out.println("board => " + board); */
	if (board != null) {
	%>
	<table align="center">
		<hr>

		<h1>맛집보기</h1>
		<p>기억에 남은 식당을 기록하는 곳.</p>
		<br>
		<br>
		<br>


		<tr>
			<td class="menu">title</td>
			<td class="menu2"><%=board.getTitle()%></td>
		</tr>
		<tr>
			<td class="menu">restaurant</td>
			<td class="menu2"><%=board.getName()%></td>
		</tr>
		<tr>
			<td class="menu" id="comment">comment</td>
			<td class="menu2"><%=board.getTextarea()%></td>
		</tr>
		<tr>
			<td class="menu">writer</td>
			<td class="menu2"><%=board.getWriter()%></td>
		</tr>
		<tr>
			<th></th>
			<td><a href="boardList2.jsp">목록</a><a href="boardDelete.jsp?no=<%=board.getNo()%>">삭제</a><a href="boardModi.jsp?no=<%=board.getNo()%>">수정</a></td>
		</tr>
	</table>
	<%
	}
	%>
</body>
</html>