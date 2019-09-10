package com.ecity.java.mvc.web.servlet.visa.base;

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
import com.ecity.java.mvc.dao.visa.base.VisaAreaDao;
import com.ecity.java.mvc.model.visa.base.VisaAreaPO;

/**
 * Servlet implementation class ViewAreaServlet
 */
@WebServlet("/web/visa/base/VisaAreaByID.json")
public class VisaAreaByIDServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public VisaAreaByIDServlet() {
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

    VisaAreaDao dao = new VisaAreaDao();
    VisaAreaPO po = dao.FindByID(ID);

    JSONObject ReturnJson = new JSONObject();

    if (po == null) {
      ReturnJson.put("MsgID", "-1");
      ReturnJson.put("MsgText", "记录不存在！");
    } else {

      ReturnJson.put("MsgID", "1");
      ReturnJson.put("MsgText", "Success");
      JSONObject poJson = po.toJson();
      ReturnJson.put("Data", poJson);
    }

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
