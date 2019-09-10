package com.ecity.java.mvc.web.servlet.visa.base;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.ecity.java.json.JSONArray;
import com.ecity.java.mvc.dao.visa.base.VisaTypeDao;
import com.ecity.java.mvc.model.visa.base.VisaTypePO;

/**
 * Servlet implementation class ViewTypeServlet
 */
@WebServlet("/web/visa/base/VisaType.json")
public class VisaTypeServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public VisaTypeServlet() {
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

    VisaTypeDao dao = new VisaTypeDao();
    ArrayList<VisaTypePO> list = dao.Find();

    JSONObject ReturnJson = new JSONObject();

    ReturnJson.put("MsgID", "1");
    ReturnJson.put("MsgText", "Success");
    JSONArray ListJson = new JSONArray();

    for (int i = 0; i < list.size(); i++) {
      VisaTypePO po = list.get(i);
      JSONObject poJson = po.toJson();
      ListJson.put(poJson);
    }
    ReturnJson.put("Data", ListJson);
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
