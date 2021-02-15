<%@page import="board.BoardDto"%>
<%@page import="board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
%>

<%
String title = request.getParameter("title");
String name = request.getParameter("name");
String textarea = request.getParameter("textarea");
String writer = request.getParameter("writer");
String no = request.getParameter("no");
BoardDto dto = new BoardDto(title,name,textarea,writer,no);
BoardDao.insert(dto);

response.sendRedirect("boardList2.jsp");
%>
