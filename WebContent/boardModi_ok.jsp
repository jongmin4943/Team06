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

BoardDao.modify(new BoardDto(title,name,textarea,writer,no));

response.sendRedirect("boardView.jsp?no="+no);
%>