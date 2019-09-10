package com.ecity.java.mvc.web.servlet.taobao;

import java.io.BufferedReader;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.BSONObject;
import org.bson.Document;
import org.json.JSONException;

import com.ecity.java.json.JSONObject;
import com.ecity.java.web.WebFunction;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.UpdateOptions;
import com.mongodb.util.JSON;

/**
 * Servlet implementation class alitripTravelTradesUpdateSUKIDServlet
 */
@WebServlet("/web/taobao/AlitripTravelTradesUpdateSUKID.json")
public class AlitripTravelTradesUpdateSUKIDServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public AlitripTravelTradesUpdateSUKIDServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub

    BufferedReader bufferReader = request.getReader();

    StringBuffer buffer = new StringBuffer();
    String line = " ";
    while ((line = bufferReader.readLine()) != null) {
      buffer.append(line);
    }

    JSONObject DataJson = null;
    try {
      DataJson = new JSONObject(buffer.toString());
    } catch (JSONException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
      WebFunction.WriteMsgText(response, -1, "json错误！");
      return;
    }

    if (!DataJson.has("item_id")) {
      WebFunction.WriteMsgText(response, -1, "缺少item_id！");
      return;
    }

    String item_id = DataJson.getString("item_id");
    if (!DataJson.has("out_sku_id")) {
      WebFunction.WriteMsgText(response, -1, "缺少out_sku_id！");
      return;
    }
    String out_sku_id = DataJson.getString("out_sku_id");

    try {
      // 连接到数据库
      MongoDatabase mongoDatabase = MongoCon.GetConnect();

      MongoCollection<Document> collection = mongoDatabase.getCollection("alitripTravelTrade");

      BasicDBObject query = new BasicDBObject();
      query.put("alitrip_travel_trade_query_response.first_result.sub_orders.sub_order_info.0.buy_item_info.item_id",
          new BasicDBObject("$eq", Long.parseLong(item_id)));
      query.put("MsgID", new BasicDBObject("$eq", "-1"));

      SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      Date now = new Date();

      BasicDBObject bson = new BasicDBObject();
      bson.put("out_sku_id", out_sku_id);
      bson.put("MsgID", "0");
      bson.put("Update", now);
      bson.put("UpdateDateStr", format.format(now));

      collection.updateMany(query, new Document("$set", bson));
      WebFunction.WriteMsgText(response, 1, "Success！");

    } catch (Exception e) {
      WebFunction.WriteMsgText(response, -1, "产品绑定失败！");
      return;
    }

  }

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub
    doGet(request, response);
  }

}
