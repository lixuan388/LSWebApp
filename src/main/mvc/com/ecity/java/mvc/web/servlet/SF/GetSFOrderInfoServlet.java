package com.ecity.java.mvc.web.servlet.SF;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.ecity.java.json.JSONArray;
import com.ecity.java.mvc.dao.SF.WayBillOrderDao;
import com.ecity.java.mvc.model.SF.WayBillOrderPO;
import com.ecity.java.mvc.model.visa.ota.BookingOrderPackagePO;
import com.ecity.java.mvc.service.system.SystemService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderPackageService;

/**
 * Servlet implementation class BookingOrderPackageServlet
 */
@WebServlet("/web/SF/GetSFOrderInfo.json")
public class GetSFOrderInfoServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public GetSFOrderInfoServlet() {
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

    Map<String, String[]> params = request.getParameterMap();
    String ID = params.get("ID") == null ? "0" : (String) (params.get("ID")[0]);

    WayBillOrderDao orderDao = new WayBillOrderDao();
    ArrayList<WayBillOrderPO> orderList = orderDao.FindByCode(ID);

    JSONObject ReturnJson = new JSONObject();

    ReturnJson.put("MsgID", "1");
    ReturnJson.put("MsgText", "Success");
    JSONArray orderListJson = new JSONArray();

    for (int i = 0; i < orderList.size(); i++) {
      WayBillOrderPO order = orderList.get(i);
      JSONObject orderJson = order.toJson();
      orderListJson.put(orderJson);
    }
    ReturnJson.put("Data", orderListJson);
    response.getWriter().println(ReturnJson.toString());
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
