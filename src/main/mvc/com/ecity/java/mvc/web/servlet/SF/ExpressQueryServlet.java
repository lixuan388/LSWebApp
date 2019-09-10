package com.ecity.java.mvc.web.servlet.SF;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.web.WebFunction;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

/**
 * Servlet implementation class BookingOrderPackageServlet
 */
@WebServlet("/web/SF/ExpressQuery.json")
public class ExpressQueryServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public ExpressQueryServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub
    WebFunction.JsonHeaderInit(response);
    
    JSONObject RequestJson=WebFunction.GetRequestJson(request);
    
    
    MongoDatabase database = MongoCon.GetConnect();
    MongoCollection<Document> collection = database.getCollection("OrderSendGoods");


    BasicDBObject  query = new BasicDBObject();
    boolean HasDate=false;
    String DateEndDef=WebFunction.FormatDate(WebFunction.Format_YYYYMMDD,new Date())+" 23:59:59";

    if (RequestJson.has("QueryText") && (!RequestJson.getString("QueryText").equals(""))) {
      String QueryText=RequestJson.getString("QueryText");
      DBObject Query = new BasicDBObject();
      BasicDBList QueryList = new BasicDBList();
      QueryList.add(new BasicDBObject("SourceOrderNo", new BasicDBObject("$eq",QueryText)));
      QueryList.add(new BasicDBObject("MailNo", new BasicDBObject("$eq",QueryText)));
      Query.put("$and", QueryList);
      query.putAll(Query);
    }

    if (RequestJson.has("PrintDateFr") && (!RequestJson.getString("PrintDateFr").equals(""))) {
      DBObject Query = new BasicDBObject();
      BasicDBList QueryList = new BasicDBList();
      
      String DateBegin=RequestJson.getString("PrintDateFr");
      String DateEnd=RequestJson.has("PrintDateTo")?RequestJson.getString("PrintDateTo")+" 23:59:59":DateEndDef;

      QueryList.add(new BasicDBObject("PrintDateStr", new BasicDBObject("$gt",DateBegin)));
      QueryList.add(new BasicDBObject("PrintDateStr", new BasicDBObject("$lt",DateEnd)));
      Query.put("$and", QueryList);
      query.putAll(Query);
    }

    if (RequestJson.has("CreateDateFr") && (!RequestJson.getString("CreateDateFr").equals(""))) {
      DBObject Query = new BasicDBObject();
      BasicDBList QueryList = new BasicDBList();      
      String DateBegin=RequestJson.getString("CreateDateFr");
      String DateEnd=RequestJson.has("CreateDateTo")?RequestJson.getString("CreateDateTo")+" 23:59:59":DateEndDef;

      QueryList.add(new BasicDBObject("CreateDateStr", new BasicDBObject("$gt",DateBegin)));
      QueryList.add(new BasicDBObject("CreateDateStr", new BasicDBObject("$lt",DateEnd)));
      Query.put("$and", QueryList);
      query.putAll(Query);
    }

    if (RequestJson.has("ReceiveDateFr")&& (!RequestJson.getString("ReceiveDateFr").equals(""))) {
      DBObject Query = new BasicDBObject();
      BasicDBList QueryList = new BasicDBList();      
      String DateBegin=RequestJson.getString("ReceiveDateFr");
      String DateEnd=RequestJson.has("ReceiveDateTo")?RequestJson.getString("ReceiveDateTo")+" 23:59:59":DateEndDef;

      QueryList.add(new BasicDBObject("ReceiveDateStr", new BasicDBObject("$gt",DateBegin)));
      QueryList.add(new BasicDBObject("ReceiveDateStr", new BasicDBObject("$lt",DateEnd)));
      Query.put("$and", QueryList);
      query.putAll(Query);
    }

    if (RequestJson.has("PrintState")&& (!RequestJson.getString("PrintState").equals(""))) {
      query.put("PrintState", new BasicDBObject("$eq",RequestJson.getString("PrintState")));
    }

    if (RequestJson.has("Valid")&& (!RequestJson.getString("Valid").equals(""))) {
      query.put("Valid", new BasicDBObject("$eq",RequestJson.getString("Valid")));
    }

    if (RequestJson.has("ReceiveName")&& (!RequestJson.getString("ReceiveName").equals(""))) {
      query.put("ReceiveName", new BasicDBObject("$eq",RequestJson.getString("ReceiveName")));
    }

    if (RequestJson.has("CreateUserName")&& (!RequestJson.getString("CreateUserName").equals(""))) {
      query.put("CreateUserName", new BasicDBObject("$eq",RequestJson.getString("CreateUserName")));
    }
    
    System.out.println("query:");
    System.out.println(query.toJson());
    
      
//    
//    DBObject dateQuery = new BasicDBObject();
//    BasicDBList dateQueryList = new BasicDBList();
//    dateQueryList.add(new BasicDBObject("alitrip_travel_trade_query_response.first_result.created_time", new BasicDBObject("$gt",StartDate+" 00:00:00")));
//    dateQueryList.add(new BasicDBObject("alitrip_travel_trade_query_response.first_result.created_time", new BasicDBObject("$lt",EndDate+" 23:00:00")));
//    dateQuery.put("$and", dateQueryList);
//    
//    query.putAll(dateQuery);
//    if (!NoOrderStatus.equals(""))
//    {
//      query.put("alitrip_travel_trade_query_response.first_result.status", new BasicDBObject("$ne",NoOrderStatus));
//    }
//    if (!Status.equals(""))
//    {
//      query.put("MsgText", new BasicDBObject("$eq",Status));
//    }
//    if (!MsgID.equals(""))
//    {
//      query.put("MsgID", new BasicDBObject("$eq",MsgID));
//    }
//
//    System.out.println("OrderID:"+OrderID);
//    if (!OrderID.equals(""))
//    {
//      query.put("alitrip_travel_trade_query_response.first_result.order_id_string", new BasicDBObject("$eq",OrderID));
//    }
    
    
    JSONArray ResultData=new JSONArray();
    FindIterable<Document> findIterable = collection.find(query);
    
    MongoCursor<Document> mongoCursor = findIterable.iterator();
    while (mongoCursor.hasNext()) {
      Document document = mongoCursor.next();
      JSONObject JsonData = new JSONObject(document.toJson());
      ResultData.put(JsonData);
    }
    JSONObject ReturnJson=new JSONObject();   

    ReturnJson.put("Data",ResultData);
    ReturnJson.put("MsgID","1");
    ReturnJson.put("MsgText","Success");    
    WebFunction.WriteMsgText(response, ReturnJson);
  }

}
