package com.ecity.java.web.ls.Content.BookingOrder;

import org.bson.Document;
import com.ecity.java.json.JSONObject;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class alitripTravelTradeInfoClass {
  public String ID;

  public alitripTravelTradeInfoClass(String ID) {
    this.ID = ID;
  }

  public JSONObject OpenTable() {

    JSONObject ReturnJson = new JSONObject();

    MongoDatabase database = MongoCon.GetConnect();
    MongoCollection<Document> collection = database.getCollection("alitripTravelTrade");
    FindIterable<Document> findIterable = collection
        .find(Filters.eq("alitrip_travel_trade_query_response.first_result.order_id_string", ID));
    MongoCursor<Document> mongoCursor = findIterable.iterator();
    if (mongoCursor.hasNext()) {
//      System.out.println("mongoCursor.hasNext()");
      Document document = mongoCursor.next();
//      System.out.println(document.toJson());

      JSONObject JsonData = new JSONObject(document.toJson());

      ReturnJson.put("MsgID", "1");
      ReturnJson.put("MsgText", "Success");
      ReturnJson.put("Data", JsonData);

//      System.out.println(ReturnJson.toString());
      return ReturnJson;
    } else {
//      System.out.println("not mongoCursor.hasNext()");
      ReturnJson.put("MsgID", "-1");
      ReturnJson.put("MsgText", "无对应订单记录！");
      return ReturnJson;
    }

  }

}
