<%@page import="board.BoardDto"%>
<%@page import="board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String no= request.getParameter("no");
String name= request.getParameter("name");
String title= request.getParameter("title");
String writer= request.getParameter("writer");
String textarea= request.getParameter("textarea");
String selector= request.getParameter("selector");
BoardDao.modify(new BoardDto(no,title,name,textarea,writer,"NOW()",selector));

response.sendRedirect("boardView.jsp?no="+no);
%>