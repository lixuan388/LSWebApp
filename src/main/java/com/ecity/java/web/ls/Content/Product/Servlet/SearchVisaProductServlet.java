package com.ecity.java.web.ls.Content.Product.Servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ecity.java.sql.table.MySQLTable;



@WebServlet("/Content/Product/SearchVisaProduct.json")

public class SearchVisaProductServlet extends HttpServlet {

  /**
   * 
   */
  private static final long serialVersionUID = 8890414456843544029L;

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
      Map<String, String[]> params = req.getParameterMap();
      String ID =params.get("ID")==null?"-1":(String)(params.get("ID")[0]);

      if (ID.equals("-1"))
      {
        ReturnJson.put("MsgID","-1");
        ReturnJson.put("MsgTest","缺少国家ID！");
        return;
      }
      JSONArray DataArrayJson = new JSONArray();  
      
      String Sql="select avs_id,avs_name,avs_day,avs_money,avs_cost,avs_THMoney,act_name \r\n" + 
          "from avs_visa_speed,dbo.act_country\r\n" + 
          "where avs_id_act="+ID+"\r\n" + 
          "and avs_id_act=act_id\r\n" + 
          "and avs_flag=1\r\n" + 
          "and avs_status<>'D'\r\n" + 
          "order by avs_Name\r\n" ;

      MySQLTable table=new MySQLTable(Sql);
      try
      {
        table.Open();
        while (table.next())
        {
          JSONObject DataJson = new JSONObject();   
          DataJson.put("avs_id", table.getString("avs_id"));
          DataJson.put("avs_name", table.getString("avs_name"));
          DataJson.put("avs_day", table.getString("avs_day"));
          DataJson.put("avs_money", table.getString("avs_money"));
          DataJson.put("avs_cost", table.getString("avs_cost"));
          DataJson.put("avs_THMoney", table.getString("avs_THMoney"));
          DataJson.put("act_name", table.getString("act_name"));
          
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
