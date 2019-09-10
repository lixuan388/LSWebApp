<%@page import="com.ecity.java.mvc.service.visa.ota.BookingOrderNameListService"%>
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

select * from Ebo_BookingOrder,Ebon_BookingOrder_NameList where ebo_id=ebon_id_ebo
and isnull(Ebon_ApplyId,'')=''
and ebo_statustype not in ('已发货','已取消','未认领','已完成')
and Ebo_Date_Lst>getdate()-90
and ebo_date_ins>getdate()-90

<%
  BookingOrderNameListService service=new BookingOrderNameListService();         
  service.UpdateApplyIDByOrderID("426404483895889986");
%>
</body>
</html>