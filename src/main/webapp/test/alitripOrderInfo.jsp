<%@page import="com.ecity.java.web.ls.task.CreateViewOrderTask"%>
<%@page import="com.ecity.java.web.ls.task.GetAlitripTravelTradeInfoTask"%>
<%@page import="com.ecity.java.web.ls.Content.BookingOrder.alitripOrderInfoPostClass"%>
<%@page import="com.ecity.java.web.ls.Content.BookingOrder.alitripOrderInfoClassXXX"%>
<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div>
	<%
		//alitripOrderInfoClass orderInfo=new alitripOrderInfoClass("208235560896044921");
	//new GetAlitripTravelTradeInfoTask().run();
	//alitripOrderInfoPostClass Post=new alitripOrderInfoPostClass("211121297352072559");
	new CreateViewOrderTask().run();
	%>
	
</div>

</body>
</html>