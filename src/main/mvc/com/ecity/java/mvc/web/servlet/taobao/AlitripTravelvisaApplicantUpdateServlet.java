package com.ecity.java.mvc.web.servlet.taobao;

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
import com.ecity.java.mvc.service.visa.ota.BookingOrderNameListService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.web.WebFunction;
import com.ecity.java.web.taobao.service.ITaobaoService;
import com.ecity.java.web.taobao.service.TaobaoService;
import com.taobao.api.ApiException;

/**
 * Servlet implementation class AlitripTravelVisaApplicantUpdateServlet
 */
@WebServlet("/web/taobao/AlitripTravelvisaApplicantUpdate.json")
public class AlitripTravelvisaApplicantUpdateServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public AlitripTravelvisaApplicantUpdateServlet() {
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
    if (!DataJson.has("DataRows")) {
      WebFunction.WriteMsgText(resp, -1, "缺少DataRows！");
      return;
    }
    JSONArray rows = DataJson.getJSONArray("DataRows");

    TaoBaoOTAService taobaoService = new TaoBaoOTAService();
    JSONObject ResultJson = null;

    BookingOrderService bookingOrderService = new BookingOrderService();
    BookingOrderNameListService NameListService = new BookingOrderNameListService();
    String UserName = WebFunction.GetUserName(req);

    String OrderNo = "";
    String eboID = "";
    String ApplyID = "";
    String state = "";

    for (int i = 0; i < rows.length(); i++) {
      JSONObject stateJson = rows.getJSONObject(i);
      OrderNo = stateJson.getString("OrderNo");
      eboID = stateJson.getString("eboID");
      ApplyID = stateJson.getString("ApplyID");
      state = stateJson.getString("state");

      try {
        ResultJson = taobaoService.TravelvisaApplicantUpdate(OrderNo, ApplyID, state);
      } catch (ApiException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
        WebFunction.WriteMsgText(resp, -1, "申请人签证进度更新失败！");
        return;
      }
      bookingOrderService.InsertHistory(eboID, UserName, "签证状态", "更新申请人签证进度,ApplyID:" + ApplyID + ";state:" + state);
      NameListService.UpdateApplictionStateByApplyID(ApplyID, taobaoService.GetVisaStateName(Integer.parseInt(state)));
    }
    bookingOrderService.UpdateStatus(eboID, UserName, taobaoService.GetVisaStateName(Integer.parseInt(state)), "");

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
