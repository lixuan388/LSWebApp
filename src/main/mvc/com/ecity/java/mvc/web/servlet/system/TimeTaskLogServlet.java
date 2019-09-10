package com.ecity.java.mvc.web.servlet.system;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;
import org.json.JSONObject;

import com.ecity.java.json.JSONArray;
import com.ecity.java.web.WebFunction;
import com.ecity.java.web.taobao.Variable;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.mongodb.BasicDBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.taobao.api.ApiException;
import com.taobao.api.request.AlitripTravelTradesSearchRequest;
import com.taobao.api.response.AlitripTravelTradesSearchResponse;

/**
 * 
 */
@WebServlet("/web/system/TimeTaskLog.json")
public class TimeTaskLogServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public TimeTaskLogServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub
    response.setContentType("application/json;charset=utf-8");
    response.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");

    JSONObject ReturnJson = new JSONObject();

    ReturnJson.put("MsgID", "1");
    ReturnJson.put("MsgText", "Success");

    try {
      // 连接到 mongodb 服务
      MongoDatabase mongoDatabase = MongoCon.GetConnect();
      MongoCollection<Document> collection = mongoDatabase.getCollection("TimeTaskLog");


      FindIterable<Document> findIterable = collection.find();
      MongoCursor<Document> mongoCursor = findIterable.iterator();
      JSONArray DataArray = new JSONArray();

      while (mongoCursor.hasNext()) {
        Document document = mongoCursor.next();
        String jsonStr = document.toJson();
        JSONObject json = new JSONObject(jsonStr);
        DataArray.put(json);
      }
      ReturnJson.put("Data", DataArray);
    } catch (Exception e) {
      e.printStackTrace();
      WebFunction.WriteMsgText(response, -1, "数据读取失败！");
      return;
    }


    response.getWriter().println(ReturnJson.toString());
    response.getWriter().flush();

  }


}
