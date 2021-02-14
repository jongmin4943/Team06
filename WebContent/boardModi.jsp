<%@page import="board.BoardDao"%>
<%@page import="board.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script>
	$(function() {
		$('form').submit(function() {
			event.preventDefault();
			if (this.name.value == "") {
				alert("식당이름을 입력해주세요");
				this.name.focus();
				return;
			}
			if (this.title.value == "") {
				alert("제목을 입력해주세요");
				this.title.focus();
				return;
			}
			if (this.textarea.value == "") {
				alert("내용를 입력해주세요");
				this.textarea.focus();
				return;
			}
			if (this.writer.value == "") {
				alert("작성자를 입력해주세요");
				this.writer.focus();
				return;
			}
			this.action = "boardModi_ok.jsp";
			this.method = "GET";
			this.submit();
		});
	});
</script>
<style>
#changebtn {
	align: right;
}

p {
	color: rgb(209, 209, 209);
}

body {
	width: 1300px;
	padding: 100px;
	background-color: rgb(238, 242, 242);
}

.nameth {
	width: 130px;
}

.numth {
	width: 40px;
}

hr {
	color: black;
}

.init {
	width: 800px;
	margin: 10px;
}

#writer {
	width: 100px;
}
</style>
</head>
<body data-mode="day" align="center">
	<input type="image" src="img/nightbtn.png" id="changebtn" align="right"
		onclick="
	if(document.querySelector('body').dataset.mode ==='day'){
		document.querySelector('body').style.backgroundColor = 'gray';
		document.querySelector('body').style.color = 'white';	
		document.querySelector('table').style.color = 'white';	
		document.querySelector('.init').style.color = 'black';	
		document.querySelector('#writer').style.color = 'black';	
		document.querySelector('#name').style.color = 'black';	
		document.querySelector('textarea').style.color = 'black';	
		document.querySelector('#submit').style.color = 'black';	
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
	<form>
		<table align="center">
			<hr>

			<h1>작성하기</h1>
			<p>기억에 남은 식당을 기록하는 곳.</p>
			<br>
			<br>
			<br>
<%
String no= request.getParameter("no");
BoardDto dto = BoardDao.selectOne(new BoardDto(no));
%>

			<tr>
				<td><label for="title">title</label></td>
				<td><input type="text" name="title" id="title" value="<%=dto.getTitle()  %>"
					class="init" /></td>
			</tr>
			<tr>
				<td><label for="name">restaurant name</label></td>
				<td><input type="text" name="name" id="name" value="<%=dto.getName() %>"
					class="init" /></td>
			</tr>
			<tr>
				<td><label for="textarea">comment</label></td>
				<td><textarea name="textarea" id="textarea" cols="30" rows="10"
						class="init"><%=dto.getTextarea()%></textarea></td>
			</tr>
			<tr>
				<td><label for="writer">writer</label></td>
				<td align="left"><input type="text" name="writer" id="writer"
					value="<%=dto.getWriter() %>" class="init" /> <input type="hidden" name="no" id="no" value="<%=dto.getNo() %>"/>
				</td>
			</tr>
			<tr>
				<td align="right" colspan="2"><input type="submit"
					value="수정하기" /></td>
			</tr>
		</table>
	</form>
</body>
</html>