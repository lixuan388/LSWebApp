package com.ecity.java.mvc.web.servlet.visa.base;

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
@WebServlet("/web/visa/base/VisaAreaPost.json")
public class VisaAreaPostServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public VisaAreaPostServlet() {
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

    System.out.println("buffer.toString()");
    System.out.println(buffer.toString());
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
      WebFunction.WriteMsgText(resp, -1, "json错误！无数据包！");
      return;
    }

    JSONArray DataRows = DataJson.getJSONArray("DataRows");
    TablePostData table = new TablePostData("Eva_Visa_Area", "Eva_id", DataRows, true);

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
