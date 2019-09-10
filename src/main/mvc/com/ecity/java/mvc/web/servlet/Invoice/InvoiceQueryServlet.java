package com.ecity.java.mvc.web.servlet.Invoice;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.sql.db.DBTable;
import com.ecity.java.web.WebFunction;
import com.java.sql.SQLCon;

/**
 * Servlet implementation class BookingOrderPackageServlet
 */
@WebServlet("/web/Invoice/InvoiceQuery.json")
public class InvoiceQueryServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public InvoiceQueryServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub
    WebFunction.JsonHeaderInit(response);
    
    JSONObject RequestJson=WebFunction.GetRequestJson(request);
    
    String Sql="select aia_InvoiceApply.*,Ebo_SourceOrderNo,ebo_statustype,Ebo_SourceName from aia_InvoiceApply,ebo_BookingOrder where aia_status<>'D' and aia_id_ebo=ebo_id ";
    if (RequestJson.has("QueryText")) {
      String QueryText=RequestJson.getString("QueryText");

      Sql= Sql+"and ((aia_id_ebo in (select ebo_id from ebo_BookingOrder where ebo_status<>'D'";
      if (!QueryText.equals("")) {
        Sql = Sql + " and (Ebo_SourceOrderNo like '%" + QueryText + "%' or Ebo_SourceGuest like '%" + QueryText
            + "%' or Ebo_LinkMan like '%" + QueryText + "%' or Ebo_Phone like '%" + QueryText + "%'"
            + " or ebo_id in (select ebon_id_ebo from Ebon_BookingOrder_NameList where ebon_name='" + QueryText + "' )"
            + " or ebo_id in (select ebon_id_ebo from Ebon_BookingOrder_NameList where ebon_PassPort='" + QueryText + "')";
        //if (!QueryBind.equals("F")) {
        Sql = Sql+ " \n\r or Ebo_SourceOrderNo in (select eod_child from eod_OrderBind where  eod_status<>'D' and  eod_parent in ( "
            
            
              +"\n\r select eod_parent from ebo_BookingOrder,eod_OrderBind where  eod_status<>'D' "
              + "\n\rand eod_child=Ebo_SourceOrderNo and ebo_status<>'D' and "
              + "\n\r(Ebo_SourceOrderNo like '%" + QueryText + "%' or Ebo_SourceGuest like '%" + QueryText
              + "%'\n\r or Ebo_LinkMan like '%" + QueryText + "%' or Ebo_Phone like '%" + QueryText + "%'"
              + "\n\r or ebo_id in (select ebon_id_ebo from Ebon_BookingOrder_NameList where ebon_name='" + QueryText + "' )"
              + "\n\r or ebo_id in (select ebon_id_ebo from Ebon_BookingOrder_NameList where ebon_PassPort='" + QueryText + "')"
              + ")\n\r"
              
              
              +"))\n\r";
        //}
        
        try
        {
          int i=Integer.parseInt(QueryText);
          Sql=Sql+" or ebo_id in (select ebon_id_ebo from Ebon_BookingOrder_NameList where ebon_id_ava=" + i + " )";
        }
        catch (NumberFormatException e) {
          // TODO: handle exception
        }
        Sql=Sql+ "))";
      }
      Sql=Sql+") or (aia_company  like '%"+QueryText+"%') or (aia_Content like '%"+QueryText+"%')";
      

      try
      {
        int i=Integer.parseInt(QueryText);
        Sql=Sql+" or (aia_Money="+i+")";
      }
      catch (NumberFormatException e) {
        // TODO: handle exception
      }      
      Sql=Sql+")";
    }    

    if (RequestJson.has("Status")&& (!RequestJson.getString("Status").equals(""))) {
      String Status=RequestJson.getString("Status");
//      if (Status.equals("待开发票")) {
//        Sql=Sql+" and aia_StatusType not in ('已开具')"; 
//      }
//      else {
        Sql=Sql+" and aia_StatusType = '"+Status+"'";
//      }
//      Sql=Sql+" and aia_User_Take<>''";      
    }
    else {
      Sql=Sql+" and aia_StatusType not in ('未接单')";
    }

    String DateEndDef=WebFunction.FormatDate(WebFunction.Format_YYYYMMDD,new Date())+" 23:59:59";

    if (RequestJson.has("CreateDateFr") && (!RequestJson.getString("CreateDateFr").equals(""))) {
      String DateBegin=RequestJson.getString("CreateDateFr");
      String DateEnd=RequestJson.has("CreateDateTo")?RequestJson.getString("CreateDateTo")+" 23:59:59":DateEndDef;
      Sql=Sql+" and aia_Date_OP between '"+DateBegin+"' and '"+DateEnd+"'";
    }    

    if (RequestJson.has("CreateUserName")&& (!RequestJson.getString("CreateUserName").equals(""))) {
      String CreateUserName=RequestJson.getString("CreateUserName");
      Sql=Sql+" and aia_User_OP ='"+CreateUserName+"'";      
    }

    if (RequestJson.has("CWDateFr") && (!RequestJson.getString("CWDateFr").equals(""))) {
      String DateBegin=RequestJson.getString("CWDateFr");
      String DateEnd=RequestJson.has("CWDateTo")?RequestJson.getString("CWDateTo")+" 23:59:59":DateEndDef;
      Sql=Sql+" and aia_Date_KP between '"+DateBegin+"' and '"+DateEnd+"'";
    }    

    if (RequestJson.has("CWUserName")&& (!RequestJson.getString("CWUserName").equals(""))) {
      String CreateUserName=RequestJson.getString("CWUserName");
      Sql=Sql+" and aia_User_KP ='"+CreateUserName+"'";      
    }
    
    if (RequestJson.has("CWStatus")&& (!RequestJson.getString("CWStatus").equals(""))) {
      String CWStatus=RequestJson.getString("CWStatus");
//      Sql=Sql+" and aia_User_KP<>''";      
      if (CWStatus.equals("已开具")) {
        Sql=Sql+" and aia_StatusType='已开具'";
      }
    }
    
    if (RequestJson.has("TakeDateFr") && (!RequestJson.getString("TakeDateFr").equals(""))) {
      String DateBegin=RequestJson.getString("TakeDateFr");
      String DateEnd=RequestJson.has("TakeDateTo")?RequestJson.getString("TakeDateTo")+" 23:59:59":DateEndDef;
      Sql=Sql+" and aia_Date_Take between '"+DateBegin+"' and '"+DateEnd+"'";
    }    

    if (RequestJson.has("TakeUserName")&& (!RequestJson.getString("TakeUserName").equals(""))) {
      String CreateUserName=RequestJson.getString("TakeUserName");
      Sql=Sql+" and aia_User_Take ='"+CreateUserName+"'";      
    }



    if (RequestJson.has("TakeStatus")&& (!RequestJson.getString("TakeStatus").equals(""))) {
      String TakeStatus=RequestJson.getString("TakeStatus");
      if (TakeStatus.equals("未处理")) {
        Sql=Sql+" and isnull(aia_User_Take,'')='' and aia_StatusType='已开具'";
      }
      else if (TakeStatus.equals("已处理")) {
        Sql=Sql+" and aia_User_Take<>'' and aia_StatusType='已开具'";
      }
        
      TakeStatus.replace("\\", "/");
        
            
    }
    
    
    
    System.out.println(Sql);
    DBTable table=new DBTable(SQLCon.GetConnect(),Sql);
    try {
      table.Open();
      JSONArray Data=table.toJson();
      JSONObject ResultJson=WebFunction.WriteMsgToJson(1, "Success");
      ResultJson.put("Data", Data);
      WebFunction.WriteMsgText(response, ResultJson);
      return;
    }catch (SQLException e) {
      // TODO: handle exception
      e.printStackTrace();
      WebFunction.WriteMsgText(response, -1,e.getMessage());
      return;
      
    } finally {
      // TODO: handle finally clause
      table.Close();
    }
  }

}
