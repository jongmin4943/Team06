<%@page import="board.BoardDao"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.*" %>
<%
	//String uploadPath = "//학원컴 절대 path 찾아보기";	
	String uploadPath = application.getRealPath("/img");
	String uploadPath3 = request.getSession().getServletContext().getRealPath("/img");
	//System.out.println(uploadPath3);
	String userName = (String)session.getAttribute("userID");
	int size = 10*1024*1024;
	String name="";
	String filename1="";
	String origfilename1="";
	request.setCharacterEncoding("utf-8");
	String fileName = request.getParameter("partFile1");
	try{
		MultipartRequest multi=new MultipartRequest(request,
							uploadPath,
							size, 
							"UTF-8",
				new DefaultFileRenamePolicy());

		name=multi.getParameter("name");
		
		Enumeration<?> files=multi.getFileNames();
		
		String file1 =(String)files.nextElement();
		filename1=multi.getFilesystemName(file1);
		origfilename1= multi.getOriginalFileName(file1);
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	int idx = uploadPath.indexOf("Team06")+6;
	String realPath = uploadPath.substring(idx,uploadPath.length());
	BoardDao bDao = new BoardDao();
	//bDao.updatePicture(userName,origfilename1);
	//boardwrite.jsp에서 글번호받아오기..
	
	response.sendRedirect("userAccount.jsp");
%>