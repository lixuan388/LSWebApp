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
import com.ecity.java.web.WebFunction;

/**
 * Servlet implementation class UpdateOrderSalenameServlet
 */
@WebServlet("/web/visa/ota/UpdateOrderPostAddress.json")
public class UpdateOrderPostAddressServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public UpdateOrderPostAddressServlet() {
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

    BookingOrderService service = new BookingOrderService();
    String UserName=WebFunction.GetUserName(request);
    JSONObject ResultJson = service.UpdatePostaddress(OrderID,UserName);

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
