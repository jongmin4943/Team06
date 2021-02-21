<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="board.BoardDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String currentNo = request.getParameter("currentNo");
int no = Integer.parseInt(currentNo);
List<BoardDto> list = new ArrayList<BoardDto>();
BoardDao bDao = new BoardDao();
list = bDao.selectAll();
JSONArray jsArr = new JSONArray();
JSONObject sendObj = new JSONObject();
if (no == Integer.parseInt(list.get(list.size()-1).getNo())) {
	for(int j = list.size()-2; j<list.size(); j++) {
		JSONObject jsObj = new JSONObject();
		jsObj.put("no", list.get(j).getNo());
		jsObj.put("title", list.get(j).getTitle());
		jsObj.put("name", list.get(j).getName());
		jsObj.put("textarea", list.get(j).getTextarea());
		jsObj.put("writer", list.get(j).getWriter());
		jsObj.put("date", list.get(j).getDate());
		jsObj.put("selector", list.get(j).getSelector());
		jsObj.put("countCom", list.get(j).getCountCom());
		jsObj.put("picUrl", list.get(j).getPicUrl());
		jsArr.put(jsObj);
	}
	sendObj.put("preBoard",jsArr);
} else if (no == Integer.parseInt(list.get(0).getNo())) {
	for(int j = 0; j<2; j++) {
		JSONObject jsObj = new JSONObject();
		jsObj.put("no", list.get(j).getNo());
		jsObj.put("title", list.get(j).getTitle());
		jsObj.put("name", list.get(j).getName());
		jsObj.put("textarea", list.get(j).getTextarea());
		jsObj.put("writer", list.get(j).getWriter());
		jsObj.put("date", list.get(j).getDate());
		jsObj.put("selector", list.get(j).getSelector());
		jsObj.put("countCom", list.get(j).getCountCom());
		jsObj.put("picUrl", list.get(j).getPicUrl());
		jsArr.put(jsObj);
	}
	sendObj.put("nextBoard",jsArr);
} else {
	for(int i = 0; i<list.size(); i++) {
		 if (no == Integer.parseInt(list.get(i).getNo())) {
			for(int j = i-1; j<=i+1; j++) {
				JSONObject jsObj = new JSONObject();
				jsObj.put("no", list.get(j).getNo());
				jsObj.put("title", list.get(j).getTitle());
				jsObj.put("name", list.get(j).getName());
				jsObj.put("textarea", list.get(j).getTextarea());
				jsObj.put("writer", list.get(j).getWriter());
				jsObj.put("date", list.get(j).getDate());
				jsObj.put("selector", list.get(j).getSelector());
				jsObj.put("countCom", list.get(j).getCountCom());
				jsObj.put("picUrl", list.get(j).getPicUrl());
				jsArr.put(jsObj);
			}
		}
	}
	sendObj.put("preNextBoard",jsArr);
}
	out.println(sendObj);
%>