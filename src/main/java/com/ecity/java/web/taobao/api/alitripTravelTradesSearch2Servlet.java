	package com.ecity.java.web.taobao.api;

import java.io.BufferedReader;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;
import org.json.JSONException;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.web.WebFunction;
import com.ecity.java.web.taobao.service.TaobaoService;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.taobao.api.ApiException;

@WebServlet("/taobao/api/alitripTravelTradesSearch2.json")

public class alitripTravelTradesSearch2Servlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6970525338096805017L;

	@Override
	protected void doPost(HttpServletRequest Request, HttpServletResponse Response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		Response.setContentType("application/json;charset=utf-8"); 
		Response.setCharacterEncoding("UTF-8");  
		Response.setHeader("Cache-Control", "no-cache");
		

  	BufferedReader bufferReader = Request.getReader();

    
    StringBuffer buffer = new StringBuffer();
    String line = " ";
    while ((line = bufferReader.readLine()) != null) {
        buffer.append(line);
    }

    JSONObject QueryJson=null;
    try {
    	QueryJson=new JSONObject(buffer.toString());
    } catch (JSONException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
      WebFunction.WriteMsgText(Response, -1, "json错误！");
      return ;
    }
      
		String StartDate =QueryJson.getString("StartDate")==""?"2018-09-01":QueryJson.getString("StartDate");
		String EndDate =QueryJson.getString("EndDate")==""?"2018-09-01":QueryJson.getString("EndDate");
		//订单状态 过滤。1-等待买家付款，2-等待卖家发货（买家已付款），3-等待买家确认收货，4-交易关闭（买家发起的退款），6-交易成功，8-交易关闭（订单超时 自动关单） 
    String Status =QueryJson.getString("Status")==""?"":QueryJson.getString("Status");
    String NoOrderStatus =QueryJson.getString("NoOrderStatus")==""?"":QueryJson.getString("NoOrderStatus");
		String OrderID =QueryJson.getString("OrderID")==""?"":QueryJson.getString("OrderID");
		
		String MsgID =QueryJson.getString("MsgID")==""?"":QueryJson.getString("MsgID");
		
		System.out.println("Status:"+Status);
		
		BasicDBObject  query = new BasicDBObject();
		
		DBObject dateQuery = new BasicDBObject();
    BasicDBList dateQueryList = new BasicDBList();
    dateQueryList.add(new BasicDBObject("alitrip_travel_trade_query_response.first_result.created_time", new BasicDBObject("$gt",StartDate+" 00:00:00")));
    dateQueryList.add(new BasicDBObject("alitrip_travel_trade_query_response.first_result.created_time", new BasicDBObject("$lt",EndDate+" 23:00:00")));
    dateQuery.put("$and", dateQueryList);
    
    query.putAll(dateQuery);
    if (!NoOrderStatus.equals(""))
    {
      query.put("alitrip_travel_trade_query_response.first_result.status", new BasicDBObject("$ne",NoOrderStatus));
    }
    if (!Status.equals(""))
    {
      query.put("MsgText", new BasicDBObject("$eq",Status));
    }
    if (!MsgID.equals(""))
    {
    	query.put("MsgID", new BasicDBObject("$eq",MsgID));
    }

    System.out.println("OrderID:"+OrderID);
    if (!OrderID.equals(""))
    {
    	query.put("alitrip_travel_trade_query_response.first_result.order_id_string", new BasicDBObject("$eq",OrderID));
    }
		
		
		MongoDatabase database = MongoCon.GetConnect();

		MongoCollection<Document> collection = database.getCollection("alitripTravelTrade");
		System.out.println(query.toJson());
		
    FindIterable<Document> findIterable=collection.find(query).sort(new Document("alitrip_travel_trade_query_response.first_result.pay_info.pay_time",1));

		MongoCursor<Document> mongoCursor = findIterable.iterator();
		JSONArray data=new JSONArray();
		while(mongoCursor.hasNext()){	
	
			Document d=mongoCursor.next();
			JSONObject json=new JSONObject(d.toJson());
			data.put(json);
		}

		JSONObject ReturnJson =new JSONObject(); 
		ReturnJson.put("Data",data);
		ReturnJson.put("MsgID","1");
		ReturnJson.put("MsgText","Success");
		
		Response.getWriter().print(ReturnJson.toString());
		Response.getWriter().flush();
		
	}
	
	
}
