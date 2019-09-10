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
@WebServlet("/web/visa/ota/UpdateOrderStatus.json")
public class UpdateOrderStatusServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public UpdateOrderStatusServlet() {
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

    JSONObject DataJson = null;
    try {
      DataJson = new JSONObject(buffer.toString());
    } catch (JSONException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
      WebFunction.WriteMsgText(response, -1, "json错误！");
      return;
    }
    if (!DataJson.has("EboID")) {
      WebFunction.WriteMsgText(response, -1, "缺少【EboID】信息！");
      return;
    }
    if (!DataJson.has("StatusName")) {
      WebFunction.WriteMsgText(response, -1, "缺少【StatusName】信息！");
      return;
    }

    String EboID = DataJson.getString("EboID");
    String StatusName = DataJson.getString("StatusName");
    String UserName = WebFunction.GetUserName(request);

    BookingOrderService service = new BookingOrderService();
    JSONObject ResultJson = service.UpdateStatus(EboID, UserName, StatusName, "");
    if (ResultJson.getString("MsgID").equals("1")) {
      ResultJson.put("SaleName", UserName);
    }

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
