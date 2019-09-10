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
import com.ecity.java.mvc.model.visa.ota.BookingOrderNameListPO;
import com.ecity.java.mvc.service.taobao.ota.TaoBaoOTAService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderNameListService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.web.WebFunction;
import com.taobao.api.ApiException;

/**
 * Servlet implementation class BookingOrderNameListPostServlet
 */
@WebServlet("/web/visa/ota/BookingOrderNameListPostServlet.json")
public class BookingOrderNameListPostServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public BookingOrderNameListPostServlet() {
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
    if (!DataJson.has("OrderNo")) {
      WebFunction.WriteMsgText(resp, -1, "缺少OrderNo！");
      return;
    }
    String OrderNo = DataJson.getString("OrderNo");
    if (!DataJson.has("ID")) {
      WebFunction.WriteMsgText(resp, -1, "缺少ID！");
      return;
    }
    String ID = DataJson.getString("ID");

    BookingOrderNameListService nameService = new BookingOrderNameListService();

    JSONObject ResultJson = nameService.PostData(rows);

    if (ResultJson.getString("MsgID").equals("1")) {
      ResultJson=nameService.UpdateVisaApplicantInfo(OrderNo, ID);
      if (ResultJson.getInt("MsgID")==1)
      {
        WebFunction.WriteMsgText(resp, 1, "申请人信息更新成功！");
        BookingOrderService bookingOrderService = new BookingOrderService();
        String UserName = WebFunction.GetUserName(req);
        bookingOrderService.InsertHistory(ID, UserName, "签证状态", "更新申请人信息");
        bookingOrderService.UpdateStatus(ID, UserName, "更新申请人", " and ebo_statustype='已认领'");
      }
      else
      {
        resp.getWriter().println(ResultJson.toString());
        resp.getWriter().flush();
      }
    } else {
      resp.getWriter().println(ResultJson.toString());
      resp.getWriter().flush();
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
