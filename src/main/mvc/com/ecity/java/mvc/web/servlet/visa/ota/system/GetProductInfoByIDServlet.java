package com.ecity.java.mvc.web.servlet.visa.ota.system;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.model.visa.ota.system.ProductInfoPO;
import com.ecity.java.mvc.service.visa.ota.system.ProductInfoService;
import com.ecity.java.sql.table.MySQLTable;

/**
 * Servlet implementation class GetProductInfoByIDServlet
 */
@WebServlet("/web/visa/ota/system/GetProductInfoByID.json")
public class GetProductInfoByIDServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public GetProductInfoByIDServlet() {
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
    JSONObject ReturnJson = new JSONObject();

    ReturnJson.put("MsgID", "-1");
    ReturnJson.put("MsgText", "无对应记录！");

    try {

      Map<String, String[]> params = request.getParameterMap();
      String ID = params.get("ID") == null ? "" : (String) (params.get("ID")[0]);

      ProductInfoService service = new ProductInfoService();
      ProductInfoPO p = service.find(ID);

      if (p != null) {
        ReturnJson.put("Data", p.toJson("Epi"));
        ReturnJson.put("MsgID", "1");
        ReturnJson.put("MsgText", "Success");
      }
    } finally {
      response.getWriter().print(ReturnJson.toString());
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
