<%@page import="com.ecity.java.mvc.model.utils.DeleteMongodbTable"%>
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
DeleteMongodbTable delete=new DeleteMongodbTable();
delete.Delete("OrderStatusSyncLog");
%>

</body>
</html>