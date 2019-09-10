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
import com.ecity.java.mvc.service.taobao.ota.TaoBaoOTAService;
import com.ecity.java.mvc.service.visa.base.OrderStatusService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderNameListService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.web.WebFunction;
import com.ecity.java.web.taobao.api.alitripTravelTradeQueryClass;
import com.taobao.api.ApiException;

/**
 * Servlet implementation class OrderStatusSyncServlet
 */
@WebServlet("/web/visa/ota/OrderStatusSync.json")
public class OrderStatusSyncServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public OrderStatusSyncServlet() {
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

    TaoBaoOTAService taobaoService = new TaoBaoOTAService();
    BookingOrderService bookingOrderService = new BookingOrderService();
    BookingOrderNameListService NameListService = new BookingOrderNameListService();
    String UserName = WebFunction.GetUserName(request);

    OrderStatusService orderStatusService = new OrderStatusService();

    JSONArray ResultDataJson = new JSONArray();
    for (int i = 0; i < DataJson.length(); i++) {
      JSONObject Data = DataJson.getJSONObject(i);
      String alitripCode = Data.getString("alitripCode");
      String ebonID = Data.getString("ebonID");
      String eboID = Data.getString("eboID");
      String ApplyID = Data.getString("ApplyID");
      String OrderCode = Data.getString("OrderCode");
      String currentApplyStatus = Data.getString("currentApplyStatus");
      TaoBaoOTAService service = new TaoBaoOTAService();

      System.out.println("----TravelvisaApplicantUpdate begin----");

      JSONObject Result =NameListService.TravelvisaApplicantUpdate(OrderCode, ApplyID, alitripCode, currentApplyStatus,"","","","","","","");
      if (Result.getInt("MsgID")==1)
      {
        bookingOrderService.InsertHistory(eboID, UserName, "签证状态",
            "更新申请人签证进度,ApplyID:" + ApplyID + ";state:" + alitripCode);
        NameListService.UpdateApplictionStateByApplyID(ApplyID,
            taobaoService.GetVisaStateName(Integer.parseInt(alitripCode)));
        bookingOrderService.UpdateStatus(eboID, UserName, taobaoService.GetVisaStateName(Integer.parseInt(alitripCode)),
            "");
        alitripTravelTradeQueryClass.OrderInfo(OrderCode, true);
        NameListService.UpdateApplyState(OrderCode);
        Result.put("Data", Data);
      }

      System.out.println("----TravelvisaApplicantUpdate end----");
      ResultDataJson.put(Result);
    }

    response.getWriter().println(ResultDataJson.toString());
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
