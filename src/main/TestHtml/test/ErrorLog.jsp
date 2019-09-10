<%@page import="com.ecity.java.mvc.dao.uilts.ErrorLog"%>
<%@page import="com.ecity.java.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
  JSONObject json=new JSONObject();
  json.put("ID",1);
  json.put("Text","123123");
  
  System.out.println(json.toString());
  ErrorLog.log(0, "Test", 0,json);

%>
OK
</body>
</html>