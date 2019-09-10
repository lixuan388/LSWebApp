package com.ecity.java.mvc.web.servlet.visa.ota;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.mvc.service.visa.ota.OrderStatusSyncService;
import com.ecity.java.web.WebFunction;

/**
 * Servlet implementation class UpdateOrderSalenameServlet
 */
@WebServlet("/web/visa/ota/MailNoRegisterPost.json")
public class MailNoRegisterPostServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public MailNoRegisterPostServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub
    WebFunction.JsonHeaderInit(response);
    JSONObject DataJson = WebFunction.GetRequestJson(request);

    if (!DataJson.has("OrderID")) {
      WebFunction.WriteMsgText(response, -1, "缺少【OrderID】信息！");
      return;
    }
    String OrderID=DataJson.getString("OrderID");
    
    if (!DataJson.has("MailNo")) {
      WebFunction.WriteMsgText(response, -1, "缺少【MailNo】信息！");
      return;
    }
    String MailNo=DataJson.getString("MailNo");

    
    
    BookingOrderService service = new BookingOrderService();
    String UserName=WebFunction.GetUserName(request);
    
    JSONObject ResultJson = service.UpdateMailNo(OrderID,MailNo,UserName);
    if (ResultJson.getInt("MsgID")!=1) {
      WebFunction.WriteMsgText(response,ResultJson);
      return;
    }
    
    OrderStatusSyncService sync=new OrderStatusSyncService();
    sync.UpdateState(11931617,0,"1846548_1","朱钰斌","新加坡-旅游（20城市内）","206237146109984481","1010","1003");
    
    
    response.getWriter().println(ResultJson.toString());
    response.getWriter().flush();

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
