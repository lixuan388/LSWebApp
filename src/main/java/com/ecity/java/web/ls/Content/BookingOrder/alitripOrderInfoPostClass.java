package com.ecity.java.web.ls.Content.BookingOrder;

import java.util.Date;
import java.util.Iterator;

import org.bson.Document;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.service.taobao.ota.alitripOrderInfoService;
import com.ecity.java.web.ls.system.SQL.TablePostData;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.UpdateOptions;

public class alitripOrderInfoPostClass {

  public String ID;

  public alitripOrderInfoPostClass(String ID) {
    this.ID = ID;

//		alitripOrderInfoClass Order=new alitripOrderInfoClass(ID);
    alitripOrderInfoService Order = new alitripOrderInfoService(ID);
    JSONObject OrderJson = Order.OpenTable();

//		System.out.println(OrderJson.toString());

    if (OrderJson.getString("MsgID").equals("-1")) {
			System.out.println(OrderJson.getString("MsgText"));
      Msg("-1", OrderJson.getString("MsgText"), "");
      return;
    } else if (OrderJson.getString("MsgID").equals("-11")) {
			System.out.println(OrderJson.getString("MsgText"));
      return;
    }

    JSONObject PostJson = null;

    JSONArray NameListData = OrderJson.getJSONArray("NameList");
    TablePostData NameListTable = new TablePostData("Ebon_BookingOrder_NameList", "Ebon_id", NameListData);
    PostJson = NameListTable.Post();
    if (PostJson.getString("MsgID").equals("-1")) {
      Msg("-1", "客人名单保存失败！", "");
      return;
    }

    JSONArray PackageData = OrderJson.getJSONArray("PackageInfo");
    System.out.println(PackageData.toString());
    TablePostData PackageTable = new TablePostData("Ebop_BookingOrder_Package", "ebop_id", PackageData);
    PostJson = PackageTable.Post();
    if (PostJson.getString("MsgID").equals("-1")) {
      Msg("-1", "产品信息保存失败！", "");
      return;
    }

    JSONArray OrderInfoData = new JSONArray();
    OrderInfoData.put(OrderJson.getJSONObject("OrderInfo"));
    TablePostData OrderInfoTable = new TablePostData("Ebo_BookingOrder", "ebo_id", OrderInfoData);
    PostJson = OrderInfoTable.Post();
    if (PostJson.getString("MsgID").equals("-1")) {
      Msg("-1", "订单信息保存失败！", "");
      return;
    }
    Msg("1", "订单信息保存成功！", OrderJson.getJSONObject("OrderInfo").getString("ebo_id"));

  }

  public void Msg(String MsgID, String MsgText, String OrderID) {
    java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    MongoDatabase database = MongoCon.GetConnect();
    MongoCollection<Document> collection = database.getCollection("alitripTravelTrade");
    Document d = new Document();
    d.put("MsgID", MsgID);
    d.put("MsgText", MsgText);
    d.put("OrderID", OrderID);
    d.put("Update", new Date());
    d.put("UpdateDateStr", format.format(new Date()));
    collection.updateMany(Filters.eq("alitrip_travel_trade_query_response.first_result.order_id_string", ID),
        new Document("$set", d));
  }

}
