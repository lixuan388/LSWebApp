package com.ecity.java.mvc.web.servlet.visa.ota;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.ecity.java.json.JSONArray;
import com.ecity.java.mvc.dao.uilts.SQLUilts;
import com.ecity.java.sql.db.DBTable;
import com.java.sql.SQLCon;

/**
 * Servlet implementation class OrderStatusSyncQueryServlet
 */
@WebServlet("/web/visa/ota/OrderStatusSyncQuery.json")
public class OrderStatusSyncQueryServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public OrderStatusSyncQueryServlet() {
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

    String sqlStr = "select ava_statustype,eos_code,eos_mainName,ebon_id,ebon_statustype,ebon_name,ebo_packagename,ebo_sourceorderno,ebo_statustype,eos_Name,ebo_id,ebon_applyid,ebon_currentApplyStatus \r\n"
        + "from Ebon_BookingOrder_NameList ,ava_visa_application,Ebo_BookingOrder,eos_orderstatus\r\n"
        + "where ebon_id_ava=ava_id and ebon_id_ebo=ebo_id\r\n" + "and eos_ERPName=ava_statustype\r\n"
        + "and ebo_statustype not in ('已取消')\r\n" + "and ebo_statustype in ('未完成')\r\n"
        + "and ebon_statustype<>eos_Name\r\n" + " and ebon_applyid<>'' and Ebon_currentApplyStatus<>'' and ebon_nextapplystatus<>'[]'  and ebon_nextapplystatus<>'' \r\n "
        + "order by Ebo_BookingOrder.ebo_paydate desc,Ebo_BookingOrder.ebo_sourceorderno,ava_visa_application.ava_statustype";

    DBTable table = new DBTable(SQLCon.GetConnect(), sqlStr);
    JSONObject ReturnJson = new JSONObject();
    JSONArray DataJson = new JSONArray();
    try {
      try {
        table.Open();
        while (table.next()) {
          JSONObject data = SQLUilts.DBToJson(table, "");
          DataJson.put(data);
        }
      } catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();

      }
    } finally {
      table.CloseAndFree();
    }

    ReturnJson.put("MsgID", "1");
    ReturnJson.put("MsgText", "Success");
    ReturnJson.put("Data", DataJson);
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
