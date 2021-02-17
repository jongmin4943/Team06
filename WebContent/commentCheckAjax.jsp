<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="comment.CommentDto"%>
<%@page import="java.util.List"%>
<%@page import="comment.CommentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
%>

<%
String guestID=null;
PrintWriter pr = response.getWriter();
if(session.getAttribute("guestID") != null) {		
	guestID = (String)session.getAttribute("guestID");
}

CommentDao cDao = new CommentDao();
String comment = request.getParameter("comment");
String boardNo = request.getParameter("boardNo");
if("POST".equals(request.getMethod())) {
	if(guestID == null) {
		pr.println("<script>");
		pr.println("alert('잘못된 접근!')");	 
		pr.println("top.location.href = 'signIn.jsp'");
		pr.println("</script>");
	}
	cDao.insertComment(new CommentDto(null,guestID,boardNo,comment,"NOW()"));
}
List<CommentDto> list = cDao.getComment(boardNo);
JSONArray jsArr = new JSONArray();
for(int i = 0; i < list.size() ; i++) {
	JSONObject jsObj = new JSONObject();
	jsObj.put("guestID",list.get(i).getUserID());
	jsObj.put("content",list.get(i).getContent());
	jsObj.put("date",list.get(i).getDate());
	jsArr.put(jsObj);
}
JSONObject sendObj = new JSONObject();
sendObj.put("sent",jsArr);
out.print(sendObj);

%>