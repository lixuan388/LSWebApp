package com.ecity.java.web.ls.Content.Base.Servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DecimalFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ecity.java.sql.table.MySQLTable;

@WebServlet("/Content/Base/SupplierInfoGet.json")

public class SupplierInfoGetServlet extends HttpServlet {

  /**
   * 
   */
  private static final long serialVersionUID = -847620041160635539L;

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
    resp.setContentType("application/json;charset=utf-8"); 
    resp.setCharacterEncoding("UTF-8");  
    resp.setHeader("Cache-Control", "no-cache");
    JSONObject ReturnJson = new JSONObject(); 
    try
    { 

      ReturnJson.put("MsgID","1");
      ReturnJson.put("MsgText","Success");
      JSONArray DataArrayJson = new JSONArray();  
      
      String Sql="select * from esi_Supplier_Info where esi_status<>'D'";

      MySQLTable table=new MySQLTable(Sql);
      try
      {
        table.Open();
        while (table.next())
        {
          JSONObject DataJson = new JSONObject();   
          DataJson.put("esi_id", table.getString("esi_id"));
          DataJson.put("esi_status", table.getString("esi_status"));
          DataJson.put("esi_User_Ins", table.getString("esi_User_Ins"));
          DataJson.put("esi_Date_Ins", table.getString("esi_Date_Ins"));
          DataJson.put("esi_User_Lst", table.getString("esi_User_Lst"));
          DataJson.put("esi_Date_Lst", table.getString("esi_Date_Lst"));
          DataJson.put("esi_Name", table.getString("esi_Name"));
          
          DataArrayJson.put(DataJson);
        }
      }catch (SQLException e) {
        // TODO Auto-generated catch block

        ReturnJson.put("MsgID","-1");
        ReturnJson.put("MsgText",e.getMessage());
        e.printStackTrace();
        return;
      }
      finally
      {
        table.Close();
      }
      ReturnJson.put("Data",DataArrayJson);
    }
    finally
    {
          resp.getWriter().print(ReturnJson.toString());
          resp.getWriter().flush();
    }        
  }
}
