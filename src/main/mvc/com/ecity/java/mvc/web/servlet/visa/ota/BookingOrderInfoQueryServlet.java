package com.ecity.java.mvc.web.servlet.visa.ota;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.dao.visa.ota.BookingOrderImpl;
import com.ecity.java.mvc.dao.visa.ota.BookingOrderNameListImpl;
import com.ecity.java.mvc.model.visa.ota.BookingOrderNameListPO;
import com.ecity.java.mvc.model.visa.ota.BookingOrderPO;
import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.web.WebFunction;

/**
 * Servlet implementation class BookingOrderInfoQueryServlet
 */
@WebServlet("/web/visa/ota/BookingOrderInfoQuery.json")
public class BookingOrderInfoQueryServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public BookingOrderInfoQueryServlet() {
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

    JSONObject ReturnJson = new JSONObject();

    BookingOrderService orderService=new BookingOrderService();
    

    // 读取订单主表信息
    BookingOrderImpl bookingOrderImpl = new BookingOrderImpl();
    BookingOrderPO bookingOrderPO = new BookingOrderPO();
    bookingOrderPO = bookingOrderImpl.findByCode(ID);
    if (bookingOrderPO == null) {
      WebFunction.WriteMsgText(response, -1, "订单记录不存在！");
      return;
    }
    JSONObject OrderJson = bookingOrderPO.toJson();
    
    OrderJson.put("SendGoodsList", orderService.GetTypeHistory(ID, "须寄回材料备注"));
    ReturnJson.put("OrderInfo", OrderJson);

    // 读取名单列表
    BookingOrderNameListImpl nameListImpl = new BookingOrderNameListImpl();
    ArrayList<BookingOrderNameListPO> nameListPO = new ArrayList<BookingOrderNameListPO>();
    nameListPO = nameListImpl.findByOrderNo(ID);
    JSONArray NameListJson = new JSONArray();
    for (int i = 0; i < nameListPO.size(); i++) {
      JSONObject nameJson = nameListPO.get(i).toJson();
      NameListJson.put(nameJson);
    }
    ReturnJson.put("NameList", NameListJson);
    
    ReturnJson.put("contactor", orderService.GetPostAddress(ID));
    
    ReturnJson.put("BindOrder", orderService.GetOrderBindInfo(ID));
    ReturnJson.put("MsgID", 1);
    ReturnJson.put("MsgTest", "Success!");

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
