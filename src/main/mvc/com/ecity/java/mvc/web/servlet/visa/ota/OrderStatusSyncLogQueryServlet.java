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
@WebServlet("/web/visa/ota/OrderStatusSyncLogQuery.json")
public class OrderStatusSyncLogQueryServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public OrderStatusSyncLogQueryServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub

    Calendar base = Calendar.getInstance();

    Date now = new Date();
    // Date InsertDate=base.getTime();
    base.setTime(now);
    base.set(base.HOUR, 0);
    base.set(base.MINUTE, 0);
    base.set(base.SECOND, 0);
    base.set(base.MILLISECOND, 0);

//    String DateFrom = WebFunction.FormatDate(WebFunction.Format_YYYYMMDDHHMMSS, new Date(base.getTimeInMillis()));
//    String DateTo = WebFunction.FormatDate(WebFunction.Format_YYYYMMDDHHMMSS,
//        new Date(base.getTimeInMillis() + 1000 * 60 * 60 * 24));

    Map<String, String[]> params = request.getParameterMap();
    String DateFrom = params.get("DateFrom") == null ? "" : (String) (params.get("DateFrom")[0]);
    String DateTo = params.get("DateTo") == null ? "" : (String) (params.get("DateTo")[0]);
    String State = params.get("State") == null ? "" : (String) (params.get("State")[0]);

    if (DateFrom.equals(""))
    {
      DateFrom = WebFunction.FormatDate(WebFunction.Format_YYYYMMDDHHMMSS, new Date(base.getTimeInMillis()));
    }
    else
    {
      DateFrom = DateFrom+" 00:00:00";
    }
    if (DateTo.equals(""))
    {
      DateTo = WebFunction.FormatDate(WebFunction.Format_YYYYMMDDHHMMSS,new Date(base.getTimeInMillis() + 1000 * 60 * 60 * 24));
    }
    else
    {
      DateTo = DateTo+" 23:59:59";
    }
    
    String sqlStr = "select ebon_id,ebo_id,ebon_applyid,ebon_name,ebo_packagename,ebo_sourceorderno,ebon_currentApplyStatus,Ebon_SyncState,Ebon_SyncFlag,CONVERT(nvarchar(20),Ebon_SyncDate,120) as Ebon_SyncDate\r\n" + 
        "from Ebon_BookingOrder_NameList,Ebo_BookingOrder\r\n" + 
        "where ebon_id_ebo=ebo_id and ebon_syncdate between '"+DateFrom+"' and '"+DateTo+"' and isnull(ebon_syncstate,'') <>''";
    if (!State.equals(""))
    {
      sqlStr=sqlStr+" and ebon_syncflag="+State;
    }
    sqlStr=sqlStr+" order by Ebon_SyncDate";
    
//    System.out.println(sqlStr);

    DBTable table = new DBTable(SQLCon.GetConnect(), sqlStr);
    JSONObject ReturnJson = new JSONObject();
    JSONArray DataJson = new JSONArray();
    try {
      table.Open();
      while (table.next()) {
        JSONObject data = SQLUilts.DBToJson(table, "");
        DataJson.put(data);
      }
      
    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();

    }
    finally {
      table.CloseAndFree();
    }

    ReturnJson.put("MsgID", "1");
    ReturnJson.put("MsgText", "Success");
    ReturnJson.put("Data", DataJson);
    WebFunction.JsonHeaderInit(response);
    response.getWriter().println(ReturnJson.toString());
    response.getWriter().flush();
//    try {
//      // 连接到 mongodb 服务
//      MongoDatabase mongoDatabase = MongoConnect.GetConnect();
//      MongoCollection<Document> collection = mongoDatabase.getCollection("OrderStatusSyncLog");
//
//      // 查询两个时间范围
//      BasicDBObject query = new BasicDBObject();
//
//      BasicDBObject queryDate = new BasicDBObject();
//      queryDate.put("$gt", DateFrom);
//      queryDate.put("$lt", DateTo);
//      query.put("SyncDate", queryDate);
//      if (!State.equals(""))
//      {
//        query.put("Result", State);
//        
//      }  
//
//      FindIterable<Document> findIterable = collection.find(query).sort(new Document("ebon_id", 1).append("SyncDate", 1));
//      MongoCursor<Document> mongoCursor = findIterable.iterator();
//      JSONArray DataArray = new JSONArray();
//
//      while (mongoCursor.hasNext()) {
//        Document document = mongoCursor.next();
//        String jsonStr = document.toJson();
//        JSONObject json = new JSONObject(jsonStr);
//        DataArray.put(json);
//      }
//      JSONObject ResultJson = WebFunction.WriteMsgToJson(1, "Success!");
//      ResultJson.put("Data", DataArray);
//      WebFunction.ResponseJson(response, ResultJson);
//    } catch (Exception e) {
//      e.printStackTrace();
//      System.err.println(e.getClass().getName() + ": " + e.getMessage());
//      WebFunction.WriteMsgText(response, -1, "数据读取失败！");
//      return;
//    }

  }

}
