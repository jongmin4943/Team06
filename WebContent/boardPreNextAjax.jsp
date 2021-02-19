<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="board.BoardDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.BoardDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String currentNo = request.getParameter("cuorrentN");
int no = Integer.parseInt(currentNo);
List<BoardDto> list = new ArrayList<BoardDto>();
BoardDao bDao = new BoardDao();
list = bDao.selectAll();
JSONArray jsArr = new JSONArray();
for(int i = 0; i<list.size(); i++) {
	if(no == Integer.parseInt(list.get(i).getNo())) {
		for(int j = i-1; j<=i+1; j++) {
			JSONObject jsObj = new JSONObject();
			jsObj.put("no", list.get(j).getNo());
			jsObj.put("title", list.get(j).getNo());
			jsObj.put("name", list.get(j).getNo());
			jsObj.put("textarea", list.get(j).getNo());
			jsObj.put("writer", list.get(j).getNo());
			jsObj.put("date", list.get(j).getNo());
			jsObj.put("selector", list.get(j).getNo());
			jsObj.put("countCom", list.get(j).getNo());
			jsArr.put(jsObj);
		}
	}
}
JSONObject sendObj = new JSONObject();
sendObj.put("allList",jsArr);
out.println(sendObj);
%>