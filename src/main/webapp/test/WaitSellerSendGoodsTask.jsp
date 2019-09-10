<%@page import="com.ecity.java.web.ls.task.WaitSellerSendGoodsTask"%>
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
new WaitSellerSendGoodsTask().run();
%>
</body>
</html>