<%@page import="board.BoardDao"%>
<%@page import="board.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String no = request.getParameter("no");
out.println("no = "+no);
BoardDao.delete(new BoardDto(no));
response.sendRedirect("boardList.jsp");
%>
