package com.ecity.java.web.ls.task;

import java.util.TimerTask;

import org.bson.Document;

import com.ecity.java.web.ls.system.fun.GFunction;
import com.ecity.java.web.taobao.api.alitripTravelTradeQueryClass;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.mongodb.BasicDBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

public class WaitSellerSendGoodsTask extends TimerTask {

  @Override
  public void run() {

    GFunction.TimeTaskLog("WaitSellerSendGoodsTask","刷新WAIT_SELLER_SEND_GOODS状态订单","24小时");
    // TODO Auto-generated method stub
//		WXAccessToken.Reloadtoken();

//		System.out.println("------------WaitSellerSendGoodsTask begin-----------------------");

    java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		System.out.println(format.format(new Date()));
    MongoDatabase database = MongoCon.GetConnect();
    MongoCollection<Document> collection = database.getCollection("alitripTravelTrade");
    BasicDBObject query = new BasicDBObject();
    query.put("alitrip_travel_trade_query_response.first_result.status",
        new BasicDBObject("$eq", "WAIT_SELLER_SEND_GOODS"));
    FindIterable<Document> findIterable = collection.find(query);

    MongoCursor<Document> mongoCursor = findIterable.iterator();
    while (mongoCursor.hasNext()) {
      Document d = mongoCursor.next();
      Document response = (Document) d.get("alitrip_travel_trade_query_response");
      Document first_result = (Document) response.get("first_result");
      String OrderID = first_result.getString("order_id_string");
      alitripTravelTradeQueryClass.OrderInfo(OrderID, true);
//			System.out.println(OrderID);
    }
//		System.out.println("------------WaitSellerSendGoodsTask end-----------------------");
  }

}
