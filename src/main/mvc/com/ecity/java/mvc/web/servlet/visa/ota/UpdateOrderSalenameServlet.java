package com.ecity.java.mvc.web.servlet.visa.ota;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.web.WebFunction;

/**
 * Servlet implementation class UpdateOrderSalenameServlet
 */
@WebServlet("/web/visa/ota/UpdateOrderSalename.json")
public class UpdateOrderSalenameServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public UpdateOrderSalenameServlet() {
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

    BufferedReader bufferReader = request.getReader();

    StringBuffer buffer = new StringBuffer();
    String line = " ";
    while ((line = bufferReader.readLine()) != null) {
      buffer.append(line);
    }

    JSONArray DataJson = null;
    try {
      DataJson = new JSONArray(buffer.toString());
    } catch (JSONException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
      WebFunction.WriteMsgText(response, -1, "json错误！");
      return;
    }
    String UserName = WebFunction.GetUserName(request);
    BookingOrderService service = new BookingOrderService();

    for (int i=0;i<DataJson.length();i++)
    {
      JSONObject json=DataJson.getJSONObject(i);
      String OrderID =json.getString("OrderID");
      service.UpdateSaleName(OrderID, UserName);
    }
    JSONObject ResultJson=WebFunction.WriteMsgToJson(1,"Success!");
    ResultJson.put("SaleName", UserName);
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
