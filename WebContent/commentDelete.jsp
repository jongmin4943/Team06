<%@page import="comment.CommentDto"%>
<%@page import="comment.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
<%
String no = request.getParameter("no");
CommentDao dao = new CommentDao();
CommentDto member = dao.selectOne(no);
dao.delete(member);
%>
alert("삭제 되었습니다.");
location.href="boardView.jsp?no=<%=no%>";
</script>
