<%@page import="comment.CommentDto"%>
<%@page import="comment.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
<%
String no = request.getParameter("no");
CommentDao dao = new CommentDao();
CommentDto member = dao.selectOne(new CommentDto(no));
%>
		confirm("정말로 삭제하시겠습니까?");
		if(confirm == true) {
			<%dao.delete(member);%>
			location.href="list.jsp";
		} else {
			history.back();
		}
</script>
</body>
</html>