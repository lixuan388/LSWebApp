package com.ecity.java.mvc.web.servlet.visa.ota;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.dao.visa.ota.BookingOrderNameListImpl;
import com.ecity.java.mvc.model.visa.ota.BookingOrderNameListPO;
import com.ecity.java.sql.db.DBTable;
import com.ecity.java.web.WebFunction;
import com.java.sql.SQLCon;

/**
 * Servlet implementation class UpdateOrderSalenameServlet
 */
@WebServlet("/web/visa/ota/BookingMailNoBruchQuery.json")
public class BookingMailNoBruchQueryServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public BookingMailNoBruchQueryServlet() {
    super();
    // TODO Auto-generated constructor stub
  }


  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub
    // TODO Auto-generated method stub
    WebFunction.JsonHeaderInit(response);
    JSONObject DataJson = WebFunction.GetRequestJson(request);

    if (!DataJson.has("Data")) {
      WebFunction.WriteMsgText(response, -1, "缺少【Data】信息！");
      return;
    }
    
    JSONArray Data=DataJson.getJSONArray("Data");
    
    JSONObject ResultJson = new JSONObject();

    JSONArray ResultData=new JSONArray();
    
    int NullNameListCount=0;
    
    BookingOrderNameListImpl NameList=new BookingOrderNameListImpl();
    for (int i =0;i<Data.length();i++) {
      JSONObject json=Data.getJSONObject(i);
      String OrderID=json.getString("OrderID");
      String MailNo=json.getString("MailNo");

      ArrayList<BookingOrderNameListPO> NameListPO=NameList.findByOrderNo(OrderID);
      
      JSONArray NameListData=new JSONArray();
      for (int j=0;j<NameListPO.size();j++) {
        JSONObject NameJson=new JSONObject();
        String _ApplyId=NameListPO.get(j).get_ApplyId();
        
        if (_ApplyId==null) {
          NullNameListCount++;
          _ApplyId="";
        }
        NameJson.put("_ApplyId",_ApplyId);
        NameJson.put("_currentApplyStatus",NameListPO.get(j).get_currentApplyStatus());
        NameJson.put("_nextApplyStatus",NameListPO.get(j).get_nextApplyStatus());
        NameJson.put("_passPortNo",NameListPO.get(j).get_passPortNo());
        NameJson.put("_Name",NameListPO.get(j).get_Name());
        NameJson.put("_name_e",NameListPO.get(j).get_name_e());
        NameJson.put("_id",NameListPO.get(j).get_id());
        NameListData.put(NameJson);
      }
      json.put("NameList", NameListData);
      ResultData.put(json);
    }
    
    DBTable table=new DBTable(SQLCon.GetConnect(),"select top "+NullNameListCount+" * from ava_visa_application_Temp\r\n" + 
        " where ava_status='I' order by ava_id");
    try {
      table.Open();      
      for (int i =0;i<ResultData.length();i++) {
        JSONObject json=ResultData.getJSONObject(i);
        JSONArray NameListData=json.getJSONArray("NameList");        
        for (int j=0;j<NameListData.length();j++) {          
          JSONObject NameJson=NameListData.getJSONObject(j);
          if (NameJson.getString("_ApplyId").equals("")) {
            if (table.next())
            {
              NameJson.put("_passPortNo",table.getString("ava_passportno"));
              NameJson.put("_Name",table.getString("ava_name_c"));
              NameJson.put("_name_e",table.getString("ava_name_e"));
              table.UpdateValue("ava_status","E");
              table.PostRow();
            }            
          }                  
        }        
      }      
    }catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      // TODO: handle finally clause
      table.CloseAndFree();
    }
    
    ResultJson.put("MsgID", 1);
    ResultJson.put("MsgText", "Success!");
    ResultJson.put("Data", ResultData);

    response.getWriter().println(ResultJson.toString());
    response.getWriter().flush();

  }

}
