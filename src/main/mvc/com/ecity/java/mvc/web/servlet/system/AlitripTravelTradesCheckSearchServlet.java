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

import com.ecity.java.web.taobao.Variable;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.taobao.api.ApiException;
import com.taobao.api.request.AlitripTravelTradesSearchRequest;
import com.taobao.api.response.AlitripTravelTradesSearchResponse;

/**
 * Servlet implementation class AlitripTravelTradesCheckSearchServlet
 */
@WebServlet("/web/system/AlitripTravelTradesCheckSearch.json")
public class AlitripTravelTradesCheckSearchServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public AlitripTravelTradesCheckSearchServlet() {
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

    ReturnJson.put("Alitrip", GetAlitripTradesCount());
    ReturnJson.put("Local", GetLocalCount());
    ReturnJson.put("LocalErr", GetLocalCountErr());

    response.getWriter().println(ReturnJson.toString());
    response.getWriter().flush();

  }

  public Long GetAlitripTradesCount() {
    Date EndDate = new Date();
    Calendar cal = Calendar.getInstance();
    cal.setTime(EndDate);

    cal.set(Calendar.AM_PM, Calendar.PM);
    cal.set(Calendar.HOUR, 11);
    cal.set(Calendar.MINUTE, 59);
    cal.set(Calendar.SECOND, 59);
    EndDate = cal.getTime();

    cal.add(Calendar.DATE, -1);
    Date StartDate = cal.getTime();

    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    Long TotalOrders = 0l;
    Long PageSize = 1l;
    // 订单状态
    // 过滤。1-等待买家付款，2-等待卖家发货（买家已付款），3-等待买家确认收货，4-交易关闭（买家发起的退款），6-交易成功，8-交易关闭（订单超时
    // 自动关单）
    Long order_status = 2l;
    AlitripTravelTradesSearchRequest req = new AlitripTravelTradesSearchRequest();

    req.setPageSize(PageSize);
    req.setStartCreatedTime(StartDate);
    req.setEndCreatedTime(EndDate);

    AlitripTravelTradesSearchResponse rsp = null;
//    System.out.println("------------AlitripTravelTradesCheckSearchServlet begin-----------------------");
//    System.out.println(fmt.format(StartDate));
//    System.out.println(fmt.format(EndDate));
    try {
      req.setCurrentPage(1l);
      order_status = 0l;
      req.setOrderStatus(order_status);
      rsp = Variable.Client().execute(req, Variable.Sessionkey);
    } catch (ApiException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
//    System.out.println(rsp.getBody());
    TotalOrders = TotalOrders + rsp.getTotalOrders();
//		try {
//			req.setCurrentPage(1l);
//			order_status=2l;//2-等待卖家发货（买家已付款）
//			req.setOrderStatus(order_status);
//			rsp = Variable.Client().execute(req, Variable.Sessionkey);
//		} catch (ApiException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		System.out.println(rsp.getBody());		
//		TotalOrders=TotalOrders+rsp.getTotalOrders();
//		try {
//			req.setCurrentPage(1l);
//			order_status=3l;//3-等待买家确认收货，
//			req.setOrderStatus(order_status);
//			rsp = Variable.Client().execute(req, Variable.Sessionkey);
//		} catch (ApiException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		System.out.println(rsp.getBody());		
//		TotalOrders=TotalOrders+rsp.getTotalOrders();
//		try {
//			req.setCurrentPage(1l);
//			order_status=4l;//4-交易关闭（买家发起的退款）
//			req.setOrderStatus(order_status);
//			rsp = Variable.Client().execute(req, Variable.Sessionkey);
//		} catch (ApiException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		System.out.println(rsp.getBody());
//		TotalOrders=TotalOrders+rsp.getTotalOrders();
//		try {
//			req.setCurrentPage(1l);
//			order_status=6l;//6-交易成功
//			req.setOrderStatus(order_status);
//			rsp = Variable.Client().execute(req, Variable.Sessionkey);
//		} catch (ApiException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		System.out.println(rsp.getBody());
//		TotalOrders=TotalOrders+rsp.getTotalOrders();
    return TotalOrders;
  }

  public long GetLocalCount() {
    Date EndDate = new Date();
    Calendar cal = Calendar.getInstance();
    cal.setTime(EndDate);

    cal.set(Calendar.AM_PM, Calendar.PM);
    cal.set(Calendar.HOUR, 11);
    cal.set(Calendar.MINUTE, 59);
    cal.set(Calendar.SECOND, 59);

    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    String EndDateStr = fmt.format(cal.getTime());

    cal.add(Calendar.DATE, -1);
    String StartDateStr = fmt.format(cal.getTime());
    long Count = 0;

    try {
      MongoDatabase database = MongoCon.GetConnect();
      MongoCollection<Document> collection = database.getCollection("alitripTravelTrade");

      BasicDBObject query = new BasicDBObject();
      query.put("alitrip_travel_trade_query_response.first_result.created_time",
          new BasicDBObject("$gt", StartDateStr).append("$lt", EndDateStr));
      //System.out.println(query.toJson());
      Count = collection.count(query);
    } finally {
      return Count;
    }
  }

  public long GetLocalCountErr() {
    Date EndDate = new Date();
    Calendar cal = Calendar.getInstance();
    cal.setTime(EndDate);

    cal.set(Calendar.AM_PM, Calendar.PM);
    cal.set(Calendar.HOUR, 11);
    cal.set(Calendar.MINUTE, 59);
    cal.set(Calendar.SECOND, 59);

    SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    String EndDateStr = fmt.format(cal.getTime());

    cal.add(Calendar.DATE, -1);
    String StartDateStr = fmt.format(cal.getTime());
    long Count = 0;

    try {
      MongoDatabase database = MongoCon.GetConnect();
      MongoCollection<Document> collection = database.getCollection("alitripTravelTrade");

      BasicDBObject query = new BasicDBObject();
      query.put("alitrip_travel_trade_query_response.first_result.created_time",
          new BasicDBObject("$gt", StartDateStr).append("$lt", EndDateStr));
      query.put("MsgID", new BasicDBObject("$eq", "-1"));
      Count = collection.count(query);
    } finally {
      return Count;
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
