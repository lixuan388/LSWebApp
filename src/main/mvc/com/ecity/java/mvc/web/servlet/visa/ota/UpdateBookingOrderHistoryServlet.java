package com.ecity.java.mvc.web.servlet.visa.ota;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.web.WebFunction;

/**
 * Servlet implementation class UpdateOrderSalenameServlet
 */
@WebServlet("/web/visa/ota/UpdateBookingOrderHistory.json")
public class UpdateBookingOrderHistoryServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public UpdateBookingOrderHistoryServlet() {
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

    JSONObject DataJson=null;
    try {
      DataJson = WebFunction.GetRequestJson(request);
    } catch (JSONException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
      WebFunction.WriteMsgText(response, -1, "json错误！");
      return;
    }

    if (!DataJson.has("eboID"))
    {
      WebFunction.WriteMsgText(response, -1, "缺少参数（eboID）！");
      return;
    }
    String eboID=DataJson.getString("eboID");

    if (!DataJson.has("Type"))
    {
      WebFunction.WriteMsgText(response, -1, "缺少参数（Type）！");
      return;
    }
    String Type=DataJson.getString("Type");

    if (!DataJson.has("Remark"))
    {
      WebFunction.WriteMsgText(response, -1, "缺少参数（Remark）！");
      return;
    }
    String Remark=DataJson.getString("Remark");


    String Money="0";
    if (DataJson.has("Remark"))
    {
      Money=DataJson.getString("Money");
    }
    
    String UserName = WebFunction.GetUserName(request);
    BookingOrderService service = new BookingOrderService();   

    JSONObject ResultJson=service.InsertHistory(eboID, UserName, Type, Remark,Money);
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
