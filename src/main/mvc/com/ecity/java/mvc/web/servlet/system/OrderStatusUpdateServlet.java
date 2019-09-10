package com.ecity.java.mvc.web.servlet.system;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.dao.visa.ota.BookingOrderImpl;
import com.ecity.java.mvc.dao.visa.ota.BookingOrderNameListImpl;
import com.ecity.java.mvc.dao.visa.ota.IBookingOrder;
import com.ecity.java.mvc.dao.visa.ota.IBookingOrderNameList;
import com.ecity.java.mvc.model.visa.ota.BookingOrderPO;
import com.ecity.java.mvc.model.visa.ota.BookingOrderNameListPO;
import com.ecity.java.mvc.service.taobao.ota.TaoBaoOTAService;
import com.ecity.java.mvc.service.visa.base.OrderStatusService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderNameListService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.web.WebFunction;
import com.ecity.java.web.taobao.service.ITaobaoService;
import com.ecity.java.web.taobao.service.TaobaoService;
import com.taobao.api.ApiException;

/**
 * Servlet implementation class AlitripTravelVisaApplicantUpdateServlet
 */
@WebServlet("/web/system/OrderStatusUpdate.json")
public class OrderStatusUpdateServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public OrderStatusUpdateServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub

    resp.setContentType("application/json;charset=utf-8");
    resp.setCharacterEncoding("UTF-8");
    resp.setHeader("Cache-Control", "no-cache");

    BufferedReader bufferReader = req.getReader();

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
      WebFunction.WriteMsgText(resp, -1, "json错误！");
      return;
    }
    if (!DataJson.has("id")) {
      WebFunction.WriteMsgText(resp, -1, "缺少id！");
      return;
    }
    String id = DataJson.getString("id");
    if (!DataJson.has("value")) {
      WebFunction.WriteMsgText(resp, -1, "缺少value！");
      return;
    }
    String value = DataJson.getString("value");
    if (!DataJson.has("type")) {
      WebFunction.WriteMsgText(resp, -1, "缺少type！");
      return;
    }
    String type = DataJson.getString("type");

    OrderStatusService service = new OrderStatusService();
    JSONObject ResultJson = null;
    switch (type) {
    case "Main":
      ResultJson = service.UpdateMainName(id, value);
      break;
    case "_ERPName":
      ResultJson = service.UpdateERPName(id, value);
      break;
    case "_state":
      ResultJson = service.UpdateState(id, value);
      break;
    default:
      break;
    }

    resp.getWriter().println(ResultJson.toString());
    resp.getWriter().flush();
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
