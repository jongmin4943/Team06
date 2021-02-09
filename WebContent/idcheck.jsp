<%@page import="data.UserDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<% 
	String userID = request.getParameter("userID");
	UserDao dao = new UserDao();
	List<String> list = dao.selectAllID();
	for(String id : list) {
		if(id.equals(userID)) {
			out.print("사용불가능한 아이디");
		} else {
			out.print("사용 가능한 아이디");
		}
	}
%>