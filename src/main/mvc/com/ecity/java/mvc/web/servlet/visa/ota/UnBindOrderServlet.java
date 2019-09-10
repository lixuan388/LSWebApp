package com.ecity.java.mvc.web.servlet.visa.ota;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.web.WebFunction;

/**
 * Servlet implementation class UpdateOrderSalenameServlet
 */
@WebServlet("/web/visa/ota/UnBindOrder.json")
public class UnBindOrderServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public UnBindOrderServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub
    response.setContentType("application/json;charset=utf-8");
    response.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");

    JSONObject DataJson = WebFunction.GetRequestJson(request);
    

    
    if (!DataJson.has("Parent")) {
      WebFunction.WriteMsgText(response, -1, "缺少【Parent】信息！");
      return;
    }
    String Parent=DataJson.getString("Parent");
    if (!DataJson.has("Child")) {
      WebFunction.WriteMsgText(response, -1, "缺少【Child】信息！");
      return;
    }
    String Child=DataJson.getString("Child");
    
    
    BookingOrderService svc=new BookingOrderService();
    String UserName=WebFunction.GetUserName(request);
    WebFunction.WriteMsgText(response, svc.UnBindOrder(UserName, Parent, Child));
    
  }

}
