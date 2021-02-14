<%@page import="board.BoardDao"%>
<%@page import="board.BoardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
	crossorigin="anonymous">
<style>
#changebtn {
	align: right;
}

#name {
	width: 200px;
}

#writer {
	width: 200px;
}

p {
	color: lightgray;
}

#no {
	width: 30px;
}

body {
	width: 1300px;
	padding: 100px;
	background-color: rgb(238, 242, 242);
}

a:link {
	text-decoration: none;
	color: black;
}

a:visited {
	text-decoration: none;
		color: black;
}
</style>
<body data-mode="day">
	<input type="image" src="img/nightbtn.png" id="changebtn" align="right"
		onclick="
	if(document.querySelector('body').dataset.mode ==='day'){
		document.querySelector('body').style.backgroundColor = 'gray';
		document.querySelector('body').style.color = 'white';	
		document.querySelector('table').style.color = 'white';	
		document.querySelector('body').dataset.mode = 'night'
		this.src = 'img/daybtn.png'
	}else{
		document.querySelector('body').style.backgroundColor = 'rgb(238,242,242)';
		document.querySelector('body').style.color = 'black';	
		document.querySelector('table').style.color = 'black';	
		document.querySelector('body').dataset.mode = 'day'
		this.src = 'img/nightbtn.png'	
	}
">
	<table class="table table-striped table-hover">
		<hr>

		<h1>My Restaurant List</h1>
		<p>기억에 남은 식당을 기록하는 곳.</p>
		<br>
		<br>
		<br>

		<tr>
			<th id="no">No</th>
			<th id="name">name</th>
			<th>title</th>
			<th id="writer">writer</th>
		</tr>
		<%
		List<BoardDto> list = BoardDao.SelectAll();
		for (int i = 0; i < list.size(); i++) {
			BoardDto board = list.get(i);
		%>
		<tr>
			<td><%=board.getNo()%></td>
			<td><a href="boardView.jsp?no=<%=board.getNo()%>"><%=board.getName()%></a></td>
			<td><a href="boardView.jsp?no=<%=board.getNo()%>"><%=board.getTitle()%></a></td>
			<td><%=board.getWriter()%></td>
		</tr>
		<%
		}
		%>
	</table>
	<a href="boardWrite.html"> 새 게시글 작성 </a>
</body>

</html>