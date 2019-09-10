package com.ecity.java.mvc.web.servlet.system;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.service.system.OperationButtonService;
import com.ecity.java.sql.db.DBTable;
import com.ecity.java.web.WebFunction;
import com.java.sql.SQLCon;

/**
 * Servlet implementation class LeftSideMenuServlet
 */
@WebServlet("/web/system/OperationButtonQuery.json")
public class OperationButtonQueryServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public OperationButtonQueryServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub
    WebFunction.JsonHeaderInit(response);

    Map<String, String[]> params = request.getParameterMap();
    String ID = params.get("ID") == null ? "" : (String) (params.get("ID")[0]);

    
    

    JSONObject ReturnJson = new JSONObject();

    OperationButtonService svc=new OperationButtonService();
    JSONArray DataJson=svc.find(ID);
    ReturnJson.put("MsgID", "1");
    ReturnJson.put("MsgText", "Success");
    ReturnJson.put("Data",DataJson);
    
    
    
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
