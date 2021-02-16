<%@page import="comment.CommentDto"%>
<%@page import="java.util.List"%>
<%@page import="comment.CommentDao"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="board.BoardDao"%>
<%@page import="board.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
String guestID=null;
PrintWriter pr = response.getWriter();
if(session.getAttribute("guestID") != null) {		
	guestID = (String)session.getAttribute("guestID");
}%>
<script src="https://code.jquery.com/jquery.js"></script>
<script>
var guestID = "<%=guestID%>";
$(function() {
	$('form').submit(function() {
		console.log(guestID);	
		if(guestID == 'null') {
			var c = confirm('로그인 하시겠습니까?.');
			if(c) {
				this.action = 'signIn.jsp';
				this.method = 'POST';
				return this.submit();
			} else {
				return false;
			}
		} else {
			event.preventDefault();
			if(!this.textarea.value) {
				alert("댓글을 입력해주세요.");
				return false;
			}
		}
		this.action = "commentCheck.jsp";
		this.method = "GET";
		this.submit();
	});
});
</script>
</head>
​
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
	padding: 0px 10px;
	border: 1px solid gray;
	width: 1000px;
}

#comment {
	height: 500px;
}

a {
	margin: 2px;
}
.reply{
	border-bottom:1px solid lightgray; 
}
</style>
<body data-mode="day">
	<input type="image" src="img/nightbtn.png" id="changebtn" align="right"
		onclick="
	if(document.querySelector('body').dataset.mode ==='day'){
		document.querySelector('body').style.backgroundColor = 'gray';
		document.querySelector('body').style.color = 'white';	
		document.querySelectorAll('.menu2').style.color = 'white';	
		document.querySelectorAll('.menu').style.color = 'black';	
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
	String userID = null;
	String switching = "inline-block";
	String no = request.getParameter("no");
	/* 	out.println("no => " + no); */
	BoardDto board = BoardDao.selectOne(new BoardDto(no));
/* 	out.println("board => " + board); */
	CommentDao cDao = new CommentDao();
	List<CommentDto> list = cDao.getComment(no);
	
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID==null||!userID.equals((String)board.getWriter())) {
		switching = "none";
	}
	if (board != null) {
		
	%>
	<form>
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
				<td class="menu">writer</td>
				<td class="menu2"><%=board.getWriter()%></td>
			</tr>
			<tr>
				<td class="menu">name</td>
				<td colspan="3" class="menu2"><%=board.getName()%></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td class="menu" id="comment">comment</td>
				<td colspan="3" class="menu2"><%=board.getTextarea()%></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		<table style="backgroundColor=lightgray; margin:10px; width:1080px;">
			<tr>
				<th style="width:100px">ID</th>
				<th colspan="3">comment</th>
				<th style="width:700px"></th>
				<th style="text-align:left; width:150px; ">date</th>
			</tr>
			<%for(int i=0; i<list.size(); i++){%>
			<tr class="reply">
				<td><%=list.get(i).getUserID()%></td>
				<td colspan="3"><%=list.get(i).getContent()%></td>
				<%if(guestID != null && guestID.equals(list.get(i).getUserID())){%>
					<td style="width:200px"><a href="commentModify.jsp">수정</a><a href="commentDelete.jsp">삭제</a></td>
				<%} else {%>
					<td style="text-align:right"></td>
				<%};%>
					
				<td style="text-align:left"><%=list.get(i).getDate().substring(0, 11)+list.get(i).getDate().substring(11, 19)%></td>
			</tr>
			<%};%>
			<tr>
				
				<td colspan="4" >
					<textarea class = "form-control" name="textarea" id="textarea" rows="2" cols="50" style="width:900px"></textarea>
					<input type="hidden" name="no" id="no" value=<%=no%>>
				</td>
				<td></td>
				<td>
					<input type="submit" value="댓글 등록" />
				</td>
			</tr>
		</table>
	</form>
	<span style="align:right"><a href="boardList2.jsp">목록</a><span id="non" style="display:<%=switching%>"><a href="boardDelete.jsp?no=<%=board.getNo()%>">삭제</a><a href="boardModi.jsp?no=<%=board.getNo()%>">수정</a></span></span>
	<%
	}
	%>
</body>
</html>