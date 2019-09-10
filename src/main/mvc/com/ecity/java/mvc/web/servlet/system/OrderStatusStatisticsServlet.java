package com.ecity.java.mvc.web.servlet.system;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;
import org.json.JSONObject;

import com.ecity.java.sql.db.DBTable;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.java.sql.SQLCon;
import com.mongodb.BasicDBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

/**
 * Servlet implementation class LeftSideMenuServlet
 */
@WebServlet("/web/system/OrderStatusStatistics.json")
public class OrderStatusStatisticsServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public OrderStatusStatisticsServlet() {
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

    DBTable table = new DBTable(SQLCon.GetConnect(),
        "select Ebo_StatusType,count(0) as c  from Ebo_BookingOrder where ebo_status<>'D'\r\n"
            + "group by Ebo_StatusType");
    try {
      try {
        table.Open();
        while (table.next()) {
          String Ebo_StatusType = table.getString("Ebo_StatusType");
          switch (Ebo_StatusType) {
          case "未认领":
            ReturnJson.put("WRL", table.getInt("c"));
            break;
          case "未完成":
            ReturnJson.put("WWC", table.getInt("c"));
            break;
          case "已认领":
            ReturnJson.put("YRL", table.getInt("c"));
            break;
          case "已完成":
            ReturnJson.put("YWC", table.getInt("c"));
            break;
          case "已发货":
            ReturnJson.put("YFH", table.getInt("c"));
            break;
          default:
            break;
          }
        }

        ReturnJson.put("ERR", GetErrorCount());
        ReturnJson.put("MsgID", "1");
        ReturnJson.put("MsgText", "Success");
      } catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
        ReturnJson.put("MsgID", "-1");
        ReturnJson.put("MsgText", e.getMessage());
      }
    } finally {
      table.CloseAndFree();
    }

    response.getWriter().println(ReturnJson.toString());
    response.getWriter().flush();
  }

  public long GetErrorCount() {
    long count = 0;
    try {
      MongoDatabase database = MongoCon.GetConnect();
      MongoCollection<Document> collection = database.getCollection("alitripTravelTrade");

      BasicDBObject query = new BasicDBObject();
      query.put("MsgID", new BasicDBObject("$eq", "-1"));
      query.put("alitrip_travel_trade_query_response.first_result.status", new BasicDBObject("$ne", "TRADE_FINISHED"));
      count = collection.count(query);
    } finally {
      return count;
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
