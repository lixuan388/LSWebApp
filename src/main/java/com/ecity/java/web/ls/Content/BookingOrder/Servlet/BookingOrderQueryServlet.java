package com.ecity.java.web.ls.Content.BookingOrder.Servlet;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.sql.table.MySQLTable;
import com.ecity.java.web.WebFunction;

import net.sf.json.JSONException;

@WebServlet("/Content/BookingOrder/BookingOrderQuery.json")

public class BookingOrderQueryServlet extends HttpServlet {

  /**
   * 
   */
  private static final long serialVersionUID = -847620041160635539L;
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub
    doPost(request, response);
  }
  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
    resp.setContentType("application/json;charset=utf-8");
    resp.setCharacterEncoding("UTF-8");
    resp.setHeader("Cache-Control", "no-cache");
    JSONObject ReturnJson = new JSONObject();
    try {

      BufferedReader bufferReader = req.getReader();

      StringBuffer buffer = new StringBuffer();
      String line = " ";
      while ((line = bufferReader.readLine()) != null) {
        buffer.append(line);
      }

      JSONObject QueryJson = null;
      try {
        QueryJson = new JSONObject(buffer.toString());
      } catch (JSONException e1) {
        // TODO Auto-generated catch block
        e1.printStackTrace();
        WebFunction.WriteMsgText(resp, -1, "json错误！");
        return;
      }

      String QueryText = QueryJson.getString("QueryText");
      String QueryDateFr = QueryJson.getString("QueryDateFr");
      String QueryDateTo = QueryJson.getString("QueryDateTo");
      String QueryStatus = QueryJson.getString("QueryStatus");
      String QueryBind = QueryJson.getString("QueryBind");

      ReturnJson.put("MsgID", "1");
      ReturnJson.put("MsgText", "Success");
      JSONArray DataArrayJson = new JSONArray();

      String Sql = "select * from ebo_BookingOrder where ebo_status<>'D'\n\r";
      if (!QueryText.equals("")) {
        Sql = Sql + " and (Ebo_SourceOrderNo like '%" + QueryText + "%' or Ebo_SourceGuest like '%" + QueryText
            + "%'\n\r or Ebo_LinkMan like '%" + QueryText + "%' or Ebo_Phone like '%" + QueryText + "%'"
            + "\n\r or ebo_id in (select ebon_id_ebo from Ebon_BookingOrder_NameList where ebon_name='" + QueryText + "' )"
            + "\n\r or ebo_id in (select ebon_id_ebo from Ebon_BookingOrder_NameList where ebon_PassPort='" + QueryText + "')";
        if (!QueryBind.equals("F")) {
          Sql = Sql+ " \n\r or Ebo_SourceOrderNo in (select eod_child from eod_OrderBind where  eod_status<>'D' and  eod_parent in ( "
              
              
              +"\n\r select eod_parent from ebo_BookingOrder,eod_OrderBind where  eod_status<>'D' "
              + "\n\rand eod_child=Ebo_SourceOrderNo and ebo_status<>'D' and "
              + "\n\r(Ebo_SourceOrderNo like '%" + QueryText + "%' or Ebo_SourceGuest like '%" + QueryText
              + "%'\n\r or Ebo_LinkMan like '%" + QueryText + "%' or Ebo_Phone like '%" + QueryText + "%'"
              + "\n\r or ebo_id in (select ebon_id_ebo from Ebon_BookingOrder_NameList where ebon_name='" + QueryText + "' )"
              + "\n\r or ebo_id in (select ebon_id_ebo from Ebon_BookingOrder_NameList where ebon_PassPort='" + QueryText + "')"
              + ")\n\r"
              
              
              +"))\n\r";
              
//          Sql = Sql+ "  or Ebo_SourceOrderNo in ( select eod_child from ebo_BookingOrder,eod_OrderBind where  eod_status<>'D' "
//              + "and eod_parent=Ebo_SourceOrderNo and ebo_status<>'D' and (Ebo_SourceOrderNo like '%" + QueryText + "%' or Ebo_SourceGuest like '%" + QueryText
//              + "%' or Ebo_LinkMan like '%" + QueryText + "%' or Ebo_Phone like '%" + QueryText + "%'"
//              + " or ebo_id in (select ebon_id_ebo from Ebon_BookingOrder_NameList where ebon_name='" + QueryText + "' )"
//              + " or ebo_id in (select ebon_id_ebo from Ebon_BookingOrder_NameList where ebon_PassPort='" + QueryText + "')"
//              + ")"
//              +")";
              
              
          
          
        }
        
        try
        {
          int i=Integer.parseInt(QueryText);
          Sql=Sql+" or ebo_id in (select ebon_id_ebo from Ebon_BookingOrder_NameList where ebon_id_ava=" + i + " )";
        }
        catch (NumberFormatException e) {
          // TODO: handle exception
        }
        Sql=Sql+ ")";
      }
      if (!QueryDateFr.equals("") && !QueryDateTo.equals("")) {
        Sql = Sql + " and ebo_PayDate between '" + QueryDateFr + " 00:00:00' and '" + QueryDateTo + " 23:59:59' ";
      }
      if (!QueryStatus.equals("")) {
        Sql = Sql + " and ebo_StatusType='" + QueryStatus + "'";
      }
      Sql = Sql + " order by ebo_PayDate";
//      System.out.println(Sql);

      MySQLTable table = new MySQLTable(Sql);
      try {
        table.Open();
        DecimalFormat df = new DecimalFormat("0.00");

        int Index = 1;
        while (table.next()) {
          JSONObject DataJson = new JSONObject();
          DataJson.put("ebo_id", table.getString("ebo_id"));
          DataJson.put("ebo_SourceName", table.getString("ebo_SourceName"));
          DataJson.put("ebo_SourceOrderNo", table.getString("ebo_SourceOrderNo"));
          DataJson.put("ebo_StatusType", table.getString("ebo_StatusType"));
          DataJson.put("ebo_SourceGuest", table.getString("ebo_SourceGuest"));
          DataJson.put("ebo_PayDate", WebFunction.FormatDate(WebFunction.Format_YYYYMMDDHHMMSS, table.getDateTime("ebo_PayDate")));
          DataJson.put("ebo_PackageName", table.getString("ebo_PackageName"));
          DataJson.put("ebo_PackageVisa", table.getString("ebo_PackageVisa"));
          DataJson.put("ebo_PayMoney", df.format(table.getDouble("ebo_PayMoney")));
          DataJson.put("ebo_LinkMan", table.getString("ebo_LinkMan"));
          DataJson.put("ebo_Phone", table.getString("ebo_Phone"));
          DataJson.put("ebo_id_Eva", table.getString("ebo_id_Eva"));
          DataJson.put("ebo_SaleName", table.getString("Ebo_SaleName"));
          DataJson.put("ebo_OrderState", table.getString("ebo_OrderState"));
          DataJson.put("Index", Index);
          Index++;

          DataArrayJson.put(DataJson);
        }
      } catch (SQLException e) {
        // TODO Auto-generated catch block

        ReturnJson.put("MsgID", "-1");
        ReturnJson.put("MsgText", e.getMessage());
        e.printStackTrace();
        return;
      } finally {
        table.Close();
      }
      ReturnJson.put("Data", DataArrayJson);
    } finally {
      resp.getWriter().print(ReturnJson.toString());
      resp.getWriter().flush();
    }
  }
}
