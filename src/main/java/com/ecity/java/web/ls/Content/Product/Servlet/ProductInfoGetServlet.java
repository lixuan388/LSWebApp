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

@WebServlet("/Content/Product/ProductInfoGet.json")

public class ProductInfoGetServlet extends HttpServlet {

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
      

      Map<String, String[]> params = req.getParameterMap();
      String QueryText =params.get("QueryText")==null?"":(String)(params.get("QueryText")[0]);   
      String type =params.get("type")==null?"0":(String)(params.get("type")[0]);      
      
      JSONArray DataArrayJson = new JSONArray();  
      
      String Sql="select epi_id,epi_status,epi_User_Ins,epi_Date_Ins,epi_User_Lst,\r\n" + 
          "epi_Date_Lst,epi_Code,epi_CodeOutSide,epi_Name,epi_Type,\r\n" + 
          "epi_InSideID,epi_InSideName,epi_CostMoney,epi_SaleMoney,epi_id_esi,epi_id_act,epi_Day \r\n" + 
          "from epi_Product_Info\r\n" + 
          "where epi_status<>'D'";
      if (!QueryText.equals(""))
      {
      	QueryText=URLDecoder.decode(QueryText, "UTF-8");
      	Sql=Sql+" and (epi_Code like '%"+QueryText+"%' or epi_Name like '%"+QueryText+"%' )";
      }
      Sql=Sql+" and epi_Type in ("+type+")";
      
      System.out.println(Sql);

      MySQLTable table=new MySQLTable(Sql);
      try
      {
        table.Open();
        DecimalFormat df = new DecimalFormat ("0.00");
        
        while (table.next())
        {
          JSONObject DataJson = new JSONObject();   
          DataJson.put("epi_id", table.getString("epi_id"));
          DataJson.put("epi_status", table.getString("epi_status"));
          DataJson.put("epi_User_Ins", table.getString("epi_User_Ins"));
          DataJson.put("epi_Date_Ins", table.getString("epi_Date_Ins"));
          DataJson.put("epi_User_Lst", table.getString("epi_User_Lst"));
          DataJson.put("epi_Date_Lst", table.getString("epi_Date_Lst"));
          DataJson.put("epi_Code", table.getString("epi_Code"));
          DataJson.put("epi_CodeOutSide", table.getString("epi_CodeOutSide"));
          DataJson.put("epi_Name", table.getString("epi_Name"));
          DataJson.put("epi_Type", table.getString("epi_Type"));
          DataJson.put("epi_id_esi", table.getString("epi_id_esi"));
          DataJson.put("epi_id_act", table.getString("epi_id_act"));
          DataJson.put("epi_Day", table.getString("epi_Day"));
          DataJson.put("epi_InSideID", table.getString("epi_InSideID"));
          DataJson.put("epi_InSideName", table.getString("epi_InSideName"));
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
