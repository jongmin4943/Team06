<%@page import="org.json.JSONObject"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="data.UserDao"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%!
%>
<% 
if("POST".equals(request.getMethod())) {
	String userID = request.getParameter("userID");
	UserDao dao = new UserDao();
	List<String> list = dao.selectAllID();
	JSONObject jsObj = new JSONObject();
	if(userID.length()>4 && list.size() == 0 && Pattern.matches("^[a-zA-Z0-9]*$", userID)) {
		jsObj.put("possible", "Yes");
	} else if(userID.length()<5) {
		jsObj.put("possible", "Nolength");
	} else if(!(Pattern.matches("^[a-zA-Z0-9]*$", userID))) {
		jsObj.put("possible", "NoReg");
	} else {
		for(int i=0; i<list.size();i++) {
			String id = list.get(i);
			if(id.equals(userID)){
				jsObj.put("possible", "No");
				break;
			} else if(i == list.size()-1){
				jsObj.put("possible", "Yes");
			}
		}
	}
	out.print(jsObj);
}
%>