<%@page import="java.util.List"%>
<%@page import="java.util.Vector"%>
<%@page import="board.BoardDao"%>
<%@page import="board.BoardDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function() {
	$('form').submit(function() {
		if(!this.keyword.value) {
			alert("검색어를 입력해주세요.");
			return false;
		}
		this.method = "GET";
		this.action = "boardSearch.jsp";
		this.submit();
	});
});
</script>
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
	color: gray;
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

div {
	text-align: center;
	margin: 0px;
}
#aa{
margin:0;
}
table{
margin:0px;
}
#keyword, #sel, #gumsaek{
	font-size:13px;
}
.dropbtn {
  background-color: #ea2129;
  color: white;
  padding: 16px;
  font-size: 16px;
  border: none;
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}
.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {background-color: #ddd;}

.dropdown:hover .dropdown-content {display: block;}

.dropdown:hover .dropbtn {background-color: #3e8e41;}
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
				document.getElementById('aa').src='img/nightwrite.png'
			}else{
				document.querySelector('body').style.backgroundColor = 'rgb(238,242,242)';
				document.querySelector('body').style.color = 'black';	
				document.querySelector('table').style.color = 'black';	
				document.querySelector('body').dataset.mode = 'day'
				this.src = 'img/nightbtn.png'
				document.getElementById('aa').src='img/write.png'
			}
		">
	<%
	String cate = request.getParameter("cate");
	String keyword = request.getParameter("keyword");
	BoardDao dao = new BoardDao();
	int count = dao.selectSearchCnt(cate,keyword);
	String tempStart = request.getParameter("page");
	int startPage = 0;
	int onePageCnt = 10;
	count = (int) Math.ceil((double) count / (double) onePageCnt);
	if (tempStart != null) {
		startPage = (Integer.parseInt(tempStart) - 1) * onePageCnt;
	}
	List<BoardDto> v = dao.boardfilter("board","'식당'",startPage, onePageCnt);
	%>
<hr>

		<h1>My Restaurant List</h1>
		<p>기억에 남은 식당을 기록하는 곳.</p>
		<br>
		<br>
		<div style="float:right">
			<form id="searching">
				<select name="cate" id="sel">
					<option value="name">Name</option>
					<option value="title">Title</option>
					<option value="writer">Writer</option>
				</select>
				<input type="text" placeholder="검색" name="keyword" id="keyword" maxlength="20" />
				<input type="submit" value="검색" id="gumsaek" />
			</form>
		</div>
		<br>
		<br>
	<table class="table table-striped table-hover">
		<tr>
			<th id="no">No</th>
			<th id="selector" style="width:55px"><span class="dropdown" style="font-size:13px; color:#00996b">필터▾
					<span class="dropdown-content">
					<a href="boardList2.jsp">모두보기</a>
					<a href="boardLocation.jsp">지역</a>
					<a href="boardRestaurant.jsp">식당</a>
					</span>
				</span>
			</th>
			<th id="name">name</th>
			<th>title</th>
			<th id="writer" style="width:100px">writer</th>
			<th id="date" style="width:130px">date</th>
		</tr>
		<%
		for (int i = 0; i < v.size(); i++) {
		%>
		<tr>
			<td><%=v.get(i).getNo()%></td>
			<td style="font-size:10px">[<%=v.get(i).getSelector()%>]</td>
			<td><a href="boardView.jsp?no=<%=v.get(i).getNo()%>"><%=v.get(i).getName()%></a></td>
			<td><a href="boardView.jsp?no=<%=v.get(i).getNo()%>"><%=v.get(i).getTitle()%></a></td>
			<td><%=v.get(i).getWriter()%></td>
			<td><%=v.get(i).getDate().substring(0, 11)%></td>
		</tr>
		<%
		}
		%>
	</table>
	<div>
		<div style="float:left">
			<a href="boardWrite.jsp" ><input type="image" src="img/write.png" id="aa" style="box-shadow:2px 2px 5px gray"/></a>
		</div>
	</div><br>
	<div>
		<%
		
		for (int i = 1; i <= count; i++) {
		%>
		<a href="boardList2.jsp?page=<%=i%>">[<%=i%>]
		</a>

		<%
		};
		%>
	</div>

</body>

</html>