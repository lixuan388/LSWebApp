package com.ecity.java.mvc.web.servlet.visa.ota.system;

import java.io.BufferedReader;
import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.text.DecimalFormat;
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
import com.ecity.java.mvc.dao.visa.ota.system.MessageTemplateDao;
import com.ecity.java.mvc.model.visa.ota.system.MessageTemplatePO;
import com.ecity.java.mvc.model.visa.ota.system.ProductInfoPO;
import com.ecity.java.mvc.service.taobao.ota.TaoBaoOTAService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderNameListService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.mvc.service.visa.ota.system.ProductInfoService;
import com.ecity.java.sql.table.MySQLTable;
import com.ecity.java.web.WebFunction;
import com.taobao.api.ApiException;

/**
 * Servlet implementation class GetProductInfoByIDServlet
 */
@WebServlet("/web/visa/ota/system/MessageTemplatePost.json")
public class MessageTemplatePostServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public MessageTemplatePostServlet() {
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
    JSONObject ReturnJson = new JSONObject();

    ReturnJson.put("MsgID", "-1");
    ReturnJson.put("MsgText", "无对应记录！");

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

    MessageTemplateDao dao = new MessageTemplateDao();

    JSONObject ResultJson = dao.Post(rows);
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
