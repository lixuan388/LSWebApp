<%@page import="com.java.sql.MongoCon"%>
<%@page import="com.ecity.java.mvc.service.visa.ota.BookingOrderNameListService"%>
<%@page import="com.ecity.java.sql.db.DBQuery"%>
<%@page import="com.java.sql.SQLCon"%>
<%@page import="com.ecity.java.sql.db.DBTable"%>
<%@page import="com.mongodb.client.MongoCursor"%>
<%@page import="com.mongodb.client.FindIterable"%>
<%@page import="com.mongodb.BasicDBObject"%>
<%@page import="org.bson.Document"%>
<%@page import="com.mongodb.client.MongoCollection"%>
<%@page import="com.mongodb.client.MongoDatabase"%>
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

<%
JspWriter buffer = pageContext.getOut();

BookingOrderNameListService service =new BookingOrderNameListService();

System.out.println("------------UpdateTradeFinished begin-----------------------");
buffer.append("------------UpdateTradeFinished begin-----------------------<br>");

MongoDatabase database = MongoCon.GetConnect();
MongoCollection<Document> collection = database.getCollection("alitripTravelTrade");

BasicDBObject  query1 = new BasicDBObject();
query1.put("MsgID", new BasicDBObject("$eq","1"));
FindIterable<Document> findIterable1=collection.find(query1);

MongoCursor<Document> mongoCursor1 = findIterable1.iterator();

while (mongoCursor1.hasNext())
{
	Document d=mongoCursor1.next();
	Document resp=(Document) d.get("alitrip_travel_trade_query_response");
	Document first_result=(Document) resp.get("first_result");
	String OrderID=first_result.getString("order_id_string");

	System.out.println("OrderID:"+OrderID+"<br>");
	buffer.append("OrderID:"+OrderID+"<br>");
	service.UpdateApplyState(OrderID);
}


System.out.println("------------UpdateTradeFinished end-----------------------");

%>
<%
/*
BookingOrderNameListService service =new BookingOrderNameListService();
service.UpdateApplyState("237984352673892034");
*/
%>
</body>
</html>