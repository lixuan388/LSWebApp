package com.ecity.java.web.ls.Content.Product.Servlet;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ecity.java.sql.table.MySQLTable;



@WebServlet("/Content/Product/SearchProductPackageDetil.json")

public class SearchProductPackageDetilServlet extends HttpServlet {

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
      String Name =params.get("Name")==null?"":(String)(params.get("Name")[0]);

      if (Name.equals(""))
      {
        ReturnJson.put("MsgID","-1");
        ReturnJson.put("MsgText","缺少产品名称！");
        return;
      }
      Name=URLDecoder.decode(Name, "utf-8");
      JSONArray DataArrayJson = new JSONArray();  
      
      String Sql="select * from epi_Product_Info where epi_status<>'D' and epi_name like '%"+Name+"%'" ;

      //System.out.println(Sql); 
      MySQLTable table=new MySQLTable(Sql);
      try
      {
        table.Open();

        DecimalFormat df = new DecimalFormat ("0.00");
        while (table.next())
        {
          JSONObject DataJson = new JSONObject();   
          DataJson.put("epi_id", table.getString("epi_id"));
          DataJson.put("epi_Code", table.getString("epi_Code"));
          DataJson.put("epi_Name", table.getString("epi_Name"));
          DataJson.put("epi_id_act", table.getString("epi_id_act"));
          DataJson.put("epi_id_esi", table.getString("epi_id_esi"));
          DataJson.put("epi_Day", table.getString("epi_Day"));
          DataJson.put("epi_CostMoney", df.format(table.getDouble("epi_CostMoney")));
          DataJson.put("epi_SaleMoney", df.format(table.getDouble("epi_SaleMoney")));          
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
