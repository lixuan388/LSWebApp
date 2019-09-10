package com.ecity.java.mvc.web.servlet.visa.ota;

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
import com.ecity.java.mvc.model.visa.ota.BookingOrderHistoryPO;
import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.web.WebFunction;

/**
 * Servlet implementation class BookingOrderHistoryServlet
 */
@WebServlet("/web/visa/ota/BookingOrderHistory.json")
public class BookingOrderHistoryServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public BookingOrderHistoryServlet() {
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

    BookingOrderService service = new BookingOrderService();

    ArrayList<BookingOrderHistoryPO> list = service.GetHistoryList(ID);

    JSONObject ReturnJson = new JSONObject();

    ReturnJson.put("MsgID", "1");
    ReturnJson.put("MsgText", "Success");
    JSONArray historyListJson = new JSONArray();

    for (int i = 0; i < list.size(); i++) {
      BookingOrderHistoryPO history = list.get(i);
      JSONObject historyJson = new JSONObject();

//			System.out.println("id:"+ history.get_id());
      historyJson.put("index", "" + (i + 1));
      historyJson.put("id", history.get_id());

      String date = WebFunction.FormatDate(WebFunction.Format_YYYYMMDDHHMMSS, history.get_Date_op());
      historyJson.put("date", date);

      historyJson.put("type", history.get_type());
      historyJson.put("OpName", history.get_User_op());
      historyJson.put("Remark", history.get_remark());

      historyListJson.put(historyJson);
    }
    ReturnJson.put("Data", historyListJson);
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
