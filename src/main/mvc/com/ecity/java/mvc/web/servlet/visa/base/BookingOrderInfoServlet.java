package com.ecity.java.mvc.web.servlet.visa.base;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.ecity.java.json.JSONObject;
import com.ecity.java.web.WebFunction;
import com.ecity.java.web.ls.Content.BookingOrder.BookingOrderInfoClass;

/**
 * Servlet implementation class ViewAreaServlet
 */
@WebServlet("/web/visa/base/BookingOrderInfo.json")
public class BookingOrderInfoServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public BookingOrderInfoServlet() {
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
    String ID = params.get("ID") == null ? "0" : (String) (params.get("ID")[0]);
    

    BookingOrderInfoClass BookingOrderInfo=new  BookingOrderInfoClass(ID);
    JSONObject DataJson=BookingOrderInfo.OpenTable();
    JSONObject ResultJson=WebFunction.WriteMsgToJson(1,"Success");
    ResultJson.put("Data", DataJson);
    WebFunction.ResponseJson(response, ResultJson);
    
  }
}
