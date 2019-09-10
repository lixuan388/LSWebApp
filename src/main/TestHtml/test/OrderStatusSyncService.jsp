<%@page import="java.util.Date"%>
<%@page import="com.ecity.java.web.WebFunction"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.java.sql.SQLCon"%>
<%@page import="com.ecity.java.web.taobao.api.alitripTravelTradeQueryClass"%>
<%@page import="com.ecity.java.sql.db.DBTable"%>
<%@page import="com.ecity.java.mvc.service.visa.ota.OrderStatusSyncService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div><%=WebFunction.FormatDate(WebFunction.Format_YYYYMMDDHHMMSS,new Date()) %></div>
<%
OrderStatusSyncService svc=new OrderStatusSyncService();
svc.Synchronization();
//svc.ReloadOrderInfo();
%>
<div><%=WebFunction.FormatDate(WebFunction.Format_YYYYMMDDHHMMSS,new Date()) %></div>
<%
/*
    DBTable table =new DBTable(SQLCon.GetConnect(),"select ebo_sourceorderno \r\n" + 
        "from Ebon_BookingOrder_NameList,Ebo_BookingOrder\r\n" + 
        "where ebon_id_ebo=ebo_id and ebon_date_ins>'2019-01-01'  and ebon_nextapplystatus<>'[]' ");
    try {
      table.Open();
      while (table.next())
      {
        String OrderID=table.getString("ebo_sourceorderno");
        alitripTravelTradeQueryClass.OrderInfo(OrderID, true);
      }
    }catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }finally {
      // TODO: handle finally clause
      table.CloseAndFree();
    }
    */
%>
OK
<div><%=WebFunction.FormatDate(WebFunction.Format_YYYYMMDDHHMMSS,new Date()) %></div>
</body>
</html>