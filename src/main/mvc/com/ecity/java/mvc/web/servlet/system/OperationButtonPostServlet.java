package com.ecity.java.mvc.web.servlet.system;

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
import com.ecity.java.web.ls.system.SQL.TablePostData;
import com.taobao.api.ApiException;

/**
 * Servlet implementation class BookingOrderNameListPostServlet
 */
@WebServlet("/web/system/OperationButtonPost.json")
public class OperationButtonPostServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public OperationButtonPostServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
    WebFunction.JsonHeaderInit(resp);


    JSONObject DataJson = WebFunction.GetRequestJson(req);


    if (!DataJson.has("DataRows")) {
      WebFunction.WriteMsgText(resp, -1, "json错误！无数据包！");
      return;
    }

    JSONArray DataRows = DataJson.getJSONArray("DataRows");
    TablePostData table = new TablePostData("sob_Operation_button", "sob_id", DataRows, true);

    JSONObject ReturnJson = table.Post();
    resp.getWriter().print(ReturnJson.toString());
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
