package com.ecity.java.mvc.web.servlet.visa.ota;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.dao.uilts.SQLUilts;
import com.ecity.java.sql.db.DBTable;
import com.ecity.java.web.WebFunction;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.java.sql.SQLCon;
import com.mongodb.BasicDBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

/**
 * Servlet implementation class OrderStatusSyncQueryServlet
 */
@WebServlet("/web/visa/ota/OrderStatusSyncLogDetilQuery.json")
public class OrderStatusSyncLogDetilQueryServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public OrderStatusSyncLogDetilQueryServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub


//    String DateFrom = WebFunction.FormatDate(WebFunction.Format_YYYYMMDDHHMMSS, new Date(base.getTimeInMillis()));
//    String DateTo = WebFunction.FormatDate(WebFunction.Format_YYYYMMDDHHMMSS,
//        new Date(base.getTimeInMillis() + 1000 * 60 * 60 * 24));

    Map<String, String[]> params = request.getParameterMap();
    String Ebon_id = params.get("Ebon_id") == null ? "" : (String) (params.get("Ebon_id")[0]);


    try {
      // 连接到 mongodb 服务
      MongoDatabase mongoDatabase = MongoCon.GetConnect();
      MongoCollection<Document> collection = mongoDatabase.getCollection("OrderStatusSyncLog");

      // 查询两个时间范围
      BasicDBObject query = new BasicDBObject();
      query.put("ebon_id", Integer.parseInt(Ebon_id));
      

      FindIterable<Document> findIterable = collection.find(query).sort(new Document("SyncDate", 1));
      MongoCursor<Document> mongoCursor = findIterable.iterator();
      JSONArray DataArray = new JSONArray();

      while (mongoCursor.hasNext()) {
        Document document = mongoCursor.next();
        String jsonStr = document.toJson();
        JSONObject json = new JSONObject(jsonStr);
        DataArray.put(json);
      }
      JSONObject ResultJson = WebFunction.WriteMsgToJson(1, "Success!");
      ResultJson.put("Data", DataArray);
      WebFunction.ResponseJson(response, ResultJson);
    } catch (Exception e) {
      e.printStackTrace();
      System.err.println(e.getClass().getName() + ": " + e.getMessage());
      WebFunction.WriteMsgText(response, -1, "数据读取失败！");
      return;
    }

  }

}
