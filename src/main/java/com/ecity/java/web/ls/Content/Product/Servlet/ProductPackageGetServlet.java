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
import com.microsoft.sqlserver.jdbc.SQLServerException;

@WebServlet("/Content/Product/ProductPackageGet.json")

public class ProductPackageGetServlet extends HttpServlet {

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

      Map<String, String[]> params = req.getParameterMap();
      String ID =params.get("ID")==null?"":(String)(params.get("ID")[0]);


      String QueryText =params.get("QueryText")==null?"":(String)(params.get("QueryText")[0]);      
      
      
      JSONArray DataArrayJson = new JSONArray();  

      JSONArray DetilDataArrayJson = new JSONArray();  
      
      String Sql="select * from epgm_Product_Package_M\r\n" + 
          "where epgm_status<>'D'";
      if (!ID.equals(""))
      {
        Sql=Sql+" and epgm_id="+ID;
      }
      
      if (!QueryText.equals(""))
      {
      	QueryText=URLDecoder.decode(QueryText, "UTF-8");
      	Sql=Sql+" and (Epgm_CodeOutSide like '%"+QueryText+"%' or epgm_Name like '%"+QueryText+"%' )";
      }
      
      

      ReturnJson.put("MsgID","1");
      ReturnJson.put("MsgText","Success");
      
      MySQLTable table=new MySQLTable(Sql);
      try
      {
        table.Open();
        DecimalFormat df = new DecimalFormat ("0.00");
        
        while (table.next())
        {
          JSONObject DataJson = new JSONObject();   
          DataJson.put("epgm_id", table.getString("epgm_id"));
          DataJson.put("epgm_status", table.getString("epgm_status"));
          DataJson.put("epgm_User_Ins", table.getString("epgm_User_Ins"));
          DataJson.put("epgm_Date_Ins", table.getString("epgm_Date_Ins"));
          DataJson.put("epgm_User_Lst", table.getString("epgm_User_Lst"));
          DataJson.put("epgm_Date_Lst", table.getString("epgm_Date_Lst"));
          DataJson.put("epgm_Code", table.getString("epgm_Code"));
          DataJson.put("epgm_CodeOutSide", table.getString("epgm_CodeOutSide"));
          DataJson.put("epgm_Name", table.getString("epgm_Name"));
          DataJson.put("epgm_Remark", table.getString("epgm_Remark"));
          DataJson.put("epgm_ManNum", table.getString("epgm_ManNum"));
          DataJson.put("epgm_CostMoney", df.format(table.getDouble("epgm_CostMoney")));
          DataJson.put("epgm_SaleMoney", df.format(table.getDouble("epgm_SaleMoney")));
          
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
      
      if (!ID.equals(""))
      {
        Sql="select * from epgd_Product_Package_d,Epi_Product_Info \r\n" + 
            "where epgd_status<>'D' and epgd_id_epi=epi_id and epgd_id_epgm="+ID;
        
        MySQLTable DetilTable=new MySQLTable(Sql);
        try
        {
          DetilTable.Open();
          DecimalFormat df = new DecimalFormat ("0.00");
          
          while (DetilTable.next())
          {
            JSONObject DataJson = new JSONObject();   
            
            DataJson.put("epgd_id", DetilTable.getString("epgd_id"));
            DataJson.put("epgd_status", DetilTable.getString("epgd_status"));
            DataJson.put("epgd_User_Ins", DetilTable.getString("epgd_User_Ins"));
            DataJson.put("epgd_Date_Ins", DetilTable.getString("epgd_Date_Ins"));
            DataJson.put("epgd_User_Lst", DetilTable.getString("epgd_User_Lst"));
            DataJson.put("epgd_Date_Lst", DetilTable.getString("epgd_Date_Lst"));
            DataJson.put("epgd_id_epgm", DetilTable.getString("epgd_id_epgm"));
            DataJson.put("epgd_Name", DetilTable.getString("epgd_Name"));
            DataJson.put("epi_id_act", DetilTable.getString("epi_id_act"));
            DataJson.put("epi_id_esi", DetilTable.getString("epi_id_esi"));
            DataJson.put("epi_Day", DetilTable.getString("epi_Day"));
            DataJson.put("epgd_Num", DetilTable.getString("epgd_Num"));
            DataJson.put("epgd_id_epi", DetilTable.getString("epgd_id_epi"));
            DataJson.put("epgd_CostMoney", df.format(DetilTable.getDouble("epgd_CostMoney")));
            DataJson.put("epgd_SaleMoney", df.format(DetilTable.getDouble("epgd_SaleMoney")));
            
            DetilDataArrayJson.put(DataJson);
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
          DetilTable.Close();
        }
        
      }
      
      ReturnJson.put("Data",DataArrayJson);
      ReturnJson.put("DetilData",DetilDataArrayJson);
      
    }
    finally
    { 
      resp.getWriter().print(ReturnJson.toString());
      resp.getWriter().flush();
    }        
  }
}
