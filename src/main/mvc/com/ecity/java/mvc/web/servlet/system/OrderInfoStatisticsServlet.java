package com.ecity.java.mvc.web.servlet.system;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.sql.db.DBTable;
import com.java.sql.SQLCon;

/**
 * Servlet implementation class LeftSideMenuServlet
 */
@WebServlet("/web/system/OrderInfoStatistics.json")
public class OrderInfoStatisticsServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public OrderInfoStatisticsServlet() {
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

    int cycle = 7;

    String[] DateList = new String[cycle];
    java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("MM-dd");

    Date EndDate = new Date();
    Calendar cal = Calendar.getInstance();
    cal.setTime(EndDate);
    for (int i = cycle - 1; i >= 0; i--) {
      Date now = cal.getTime();
      DateList[i] = format.format(now);
      cal.add(Calendar.DATE, -1);
    }

    JSONObject DateListJson = new JSONObject();

    DBTable table = new DBTable(SQLCon.GetConnect(),
        "select CONVERT(nvarchar(10),ebo_paydate,120) as ebo_paydate,count(0) as c   \r\n"
            + "from Ebo_BookingOrder \r\n" + "where ebo_status<>'D' \r\n" + "and DATEDIFF(day,ebo_paydate,GETDATE())<="
            + cycle + "\r\n" + "group by CONVERT(nvarchar(10),ebo_paydate,120)\r\n"
            + "order by CONVERT(nvarchar(10),ebo_paydate,120)");
    try {
      try {
        table.Open();
        while (table.next()) {
          String ebo_paydate = table.getString("ebo_paydate");

          String date = ebo_paydate.substring(5, 10);
          int count = table.getInt("c");
          DateListJson.put(date, count);
        }

        ReturnJson.put("MsgID", "1");
        ReturnJson.put("MsgText", "Success");

        JSONArray DateArray = new JSONArray();
        JSONArray CountArray = new JSONArray();
        for (int i = 0; i < cycle; i++) {
          DateArray.put(DateList[i]);
          String count = DateListJson.getString(DateList[i]) == "" ? "0" : DateListJson.getString(DateList[i]);

          CountArray.put(Integer.parseInt(count));
        }
        ReturnJson.put("date1", DateArray);
        ReturnJson.put("count1", CountArray);

      } catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();

        ReturnJson.put("MsgID", "-1");
        ReturnJson.put("MsgText", e.getMessage());
      }
    } finally {
      table.CloseAndFree();
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
