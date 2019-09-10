package com.ecity.java.mvc.web.servlet.taobao;

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
import com.ecity.java.mvc.dao.visa.ota.IBookingOrder;
import com.ecity.java.mvc.dao.visa.ota.IBookingOrderNameList;
import com.ecity.java.mvc.model.visa.ota.BookingOrderPO;
import com.ecity.java.mvc.model.visa.ota.BookingOrderNameListPO;
import com.ecity.java.mvc.service.taobao.ota.TaoBaoOTAService;
import com.ecity.java.web.WebFunction;
import com.ecity.java.web.taobao.service.ITaobaoService;
import com.ecity.java.web.taobao.service.TaobaoService;
import com.taobao.api.ApiException;

/**
 * Servlet implementation class AlitripTravelVisaApplicantUpdateServlet
 */
@WebServlet("/web/taobao/AlitripTravelVisaApplicantQuery.json")
public class AlitripTravelVisaApplicantQueryServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public AlitripTravelVisaApplicantQueryServlet() {
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
    String ID = params.get("ID") == null ? "" : (String) (params.get("ID")[0]);

    if (ID.equals("")) {
      WebFunction.WriteMsgText(response, -1, "缺少参数！(ID)");
      return;
    }

    IBookingOrder bookingOrderTable = new BookingOrderImpl();
    BookingOrderPO bookingOrder = bookingOrderTable.find(ID);
    if (bookingOrder == null) {
      WebFunction.WriteMsgText(response, -1, "无订单信息！");
      return;
    }

    String SourceOrderNo = bookingOrder.get_SourceOrderNo();
    IBookingOrderNameList BookingOrderNameListTable = new BookingOrderNameListImpl();
    ArrayList<BookingOrderNameListPO> bookingOrderNameList = BookingOrderNameListTable.findByOrderNo(SourceOrderNo);

    JSONObject ResultJson = new JSONObject();
    try {
      TaoBaoOTAService taobaoService = new TaoBaoOTAService();
      JSONObject taobaoJson = null;
      try {
        taobaoJson = taobaoService.TravelTradeQuery(SourceOrderNo, true);
      } catch (ApiException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
        WebFunction.WriteMsgText(response, -1, "飞猪订单信息刷新失败！");
        return;
      }
      ResultJson.put("taobao", taobaoJson);

      JSONArray NameJson = new JSONArray();
      for (int i = 0; i < bookingOrderNameList.size(); i++) {
        BookingOrderNameListPO name = bookingOrderNameList.get(i);

        JSONObject json = name.toJson();
//				json.put("PassPortNo", name.getPassPortNo());
//				json.put("FirstName", name.getFirstname_e());
//				json.put("LastName", name.getLastname_e());
//				json.put("Mobile", name.getMobile());
//				json.put("ID", name.getId());
//				json.put("ApplyID", name.getApplyId());
        json.put("Index", (i + 1));
        NameJson.put(json);
      }
      ResultJson.put("NameList", NameJson);
      ResultJson.put("OrderNo", SourceOrderNo);
      ResultJson.put("MsgID", 1);
      ResultJson.put("MsgTest", "Success");
    } finally {
      response.getWriter().print(ResultJson.toString());
      response.getWriter().flush();
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
