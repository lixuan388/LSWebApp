package com.ecity.java.mvc.web.servlet.visa.ota;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.ecity.java.json.JSONArray;
import com.ecity.java.mvc.dao.uilts.SQLUilts;
import com.ecity.java.mvc.model.visa.ota.BookingOrderPackagePO;
import com.ecity.java.mvc.service.system.SystemService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderPackageService;
import com.ecity.java.sql.db.DBTable;
import com.ecity.java.web.WebFunction;
import com.java.sql.SQLCon;

/**
 * Servlet implementation class BookingOrderPackageServlet
 */
@WebServlet("/web/visa/ota/BookingOrderNameListByVisa.json")
public class BookingOrderNameListByVisaServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public BookingOrderNameListByVisaServlet() {
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

    
    JSONObject ReturnJson = new JSONObject();

    JSONArray packageListJson = new JSONArray();
    

    DBTable table=new DBTable(SQLCon.GetConnect(),"select Ebon_id,Ebop_id,Ebon_Name,Ebon_PassPort,Ebon_StatusOTA2,Ebon_StatusVisa2,Ebop_ProductCode\r\n" + 
        ",Ebop_id_act,Ebop_ProductName\r\n" + 
        ",Ebop_day,Ebop_Money,Ebop_AddMoney,Ebop_SaleMoney,Ebon_id_ava,Ebon_id_avg,Ebop_id_Ept \r\n" + 
        ",isnull((select convert(nvarchar(10),avg_date_rtn,120) from avg_visa_group where avg_id=ebon_id_avg),'未接单')  as avg_date_rtn\r\n" + 
        "from Ebon_BookingOrder_NameList,Ebop_BookingOrder_Package\r\n" + 
        "where Ebop_id_Ebon=Ebon_id and Ebop_id_Ept=1 and Ebon_id_Ebo="+ID);
    try
    {
      table.Open();
      int index=1;
      while (table.next())
      {
        
        JSONObject PackageJson=SQLUilts.DBToJson(table, "");
        PackageJson.put("index", index);
        packageListJson.put(PackageJson);
        index++;
      }
    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
      WebFunction.WriteMsgText(response, -1, e.getMessage());
      return;
    }
    finally
    {
      table.CloseAndFree();      
    }

    ReturnJson.put("MsgID", "1");
    ReturnJson.put("MsgText", "Success");
    ReturnJson.put("Data", packageListJson);
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
