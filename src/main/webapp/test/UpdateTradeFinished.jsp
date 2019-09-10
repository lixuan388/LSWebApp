<%@page import="com.java.sql.MongoCon"%>
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

System.out.println("------------UpdateTradeFinished begin-----------------------");
buffer.append("------------UpdateTradeFinished begin-----------------------<br>");

MongoDatabase database = MongoCon.GetConnect();
MongoCollection<Document> collection = database.getCollection("alitripTravelTrade");

BasicDBObject  query1 = new BasicDBObject();
query1.put("alitrip_travel_trade_query_response.first_result.status", new BasicDBObject("$eq","TRADE_FINISHED"));
FindIterable<Document> findIterable1=collection.find(query1);

MongoCursor<Document> mongoCursor1 = findIterable1.iterator();
buffer.append("------------TRADE_FINISHED------------<br>");

while (mongoCursor1.hasNext())
{
	Document d=mongoCursor1.next();
	Document resp=(Document) d.get("alitrip_travel_trade_query_response");
	Document first_result=(Document) resp.get("first_result");
	String OrderID=first_result.getString("order_id_string");

buffer.append("OrderID:"+OrderID+"<br>");
	System.out.println("OrderID:"+OrderID);
	DBQuery table=new DBQuery(SQLCon.GetConnect());
	table.Execute("update Ebo_BookingOrder set Ebo_User_Lst='Finished',Ebo_Date_Lst=getdate(),Ebo_StatusType='已完成' where Ebo_StatusType='未认领' and Ebo_SourceOrderNo='"+OrderID+"'");
	table.CloseAndFree();
}

BasicDBObject  query2 = new BasicDBObject();
query2.put("alitrip_travel_trade_query_response.first_result.status", new BasicDBObject("$eq","TRADE_CLOSED"));
FindIterable<Document> findIterable2=collection.find(query2);

MongoCursor<Document> mongoCursor2 = findIterable2.iterator();
buffer.append("------------TRADE_CLOSED------------"+"<br>");
while (mongoCursor2.hasNext())
{
	Document d=mongoCursor2.next();
	Document resp=(Document) d.get("alitrip_travel_trade_query_response");
	Document first_result=(Document) resp.get("first_result");
	String OrderID=first_result.getString("order_id_string");

buffer.append("OrderID:"+OrderID+"<br>");
	System.out.println("OrderID:"+OrderID);
	DBQuery table=new DBQuery(SQLCon.GetConnect());
	table.Execute("update Ebo_BookingOrder set Ebo_User_Lst='Finished',Ebo_Date_Lst=getdate(),Ebo_StatusType='已取消' where Ebo_StatusType='未认领' and Ebo_SourceOrderNo='"+OrderID+"'");
	table.CloseAndFree();
}



BasicDBObject  query3 = new BasicDBObject();
query3.put("alitrip_travel_trade_query_response.first_result.status", new BasicDBObject("$eq","WAIT_BUYER_CONFIRM_GOODS"));
FindIterable<Document> findIterable3=collection.find(query3);

MongoCursor<Document> mongoCursor3 = findIterable3.iterator();
buffer.append("------------WAIT_BUYER_CONFIRM_GOODS------------"+"<br>");
while (mongoCursor3.hasNext())
{
	Document d=mongoCursor3.next();
	Document resp=(Document) d.get("alitrip_travel_trade_query_response");
	Document first_result=(Document) resp.get("first_result");
	String OrderID=first_result.getString("order_id_string");

buffer.append("OrderID:"+OrderID+"<br>");
	System.out.println("OrderID:"+OrderID);
	DBQuery table=new DBQuery(SQLCon.GetConnect());
	table.Execute("update Ebo_BookingOrder set Ebo_User_Lst='Finished',Ebo_Date_Lst=getdate(),Ebo_StatusType='已发货' where Ebo_StatusType='未认领' and Ebo_SourceOrderNo='"+OrderID+"'");
	table.CloseAndFree();
}


System.out.println("------------UpdateTradeFinished end-----------------------");
%>

</body>
</html>