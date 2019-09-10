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
import com.ecity.java.mvc.service.taobao.ota.TaoBaoOTAService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.mvc.service.visa.ota.OrderStatusSyncService;
import com.ecity.java.sql.db.DBTable;
import com.ecity.java.web.WebFunction;
import com.java.sql.SQLCon;
import com.taobao.api.ApiException;

/**
 * Servlet implementation class UpdateOrderSalenameServlet
 */
@WebServlet("/web/visa/ota/BookingMailNoBruchPost.json")
public class BookingMailNoBruchPostServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public BookingMailNoBruchPostServlet() {
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

    if (!DataJson.has("StateCode")) {
      WebFunction.WriteMsgText(response, -1, "缺少【StateCode】信息！");
      return;
    }
    String StateCode=DataJson.getString("StateCode");
    
    JSONArray Data=DataJson.getJSONArray("Data");
    
    JSONObject ResultJson = new JSONObject();
    JSONArray ResultData=new JSONArray();

    TaoBaoOTAService taoBaoSvc=new TaoBaoOTAService();
    String State1013=taoBaoSvc.GetOrderStatusText(StateCode);
    
    
    for (int i =0;i<Data.length();i++) {
      JSONObject json=Data.getJSONObject(i);
      
      String OrderID=json.getString("OrderID");
      String MailNo=json.getString("MailNo");
            
      
      
      if (!MailNo.equals("")) {
        BookingOrderService service = new BookingOrderService();
        String UserName=WebFunction.GetUserName(request);
        
        JSONObject ResultJson2 = service.UpdateMailNo(OrderID,MailNo,UserName);
        if (ResultJson2.getInt("MsgID")!=1) {
  
          json.put("ErrText",ResultJson2.getString("MsgText"));
          ResultData.put(json);
          break;
        }
      }
      
      JSONArray NameListData=json.getJSONArray("NameList");

      JSONObject BruchResultJson = new JSONObject();
      
      
      
      OrderStatusSyncService SyncSvc=new OrderStatusSyncService();
      
      if (State1013.equals("")) {
      
        SyncSvc.UpdateNameNotApplyID(NameListData);
        
        try {
          taoBaoSvc.UpdateVisaApplicantInfo(OrderID);

          SyncSvc.ReloadOrderInfo(OrderID);
        } catch (ApiException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
          json.put("ErrText", e.getMessage());

          ResultData.put(json);
          break;
        }
      }
      else {

        Boolean UpdateResult=true;
        while (UpdateResult) {
          SyncSvc.ReloadOrderInfo(OrderID);
          for (int j=0;j<NameListData.length();j++) {
            JSONObject NameJson=NameListData.getJSONObject(j);
            String _id=NameJson.getString("_id");
            if (!SyncSvc.UPdateStateByOrderID(_id,State1013)) {
              UpdateResult=false;
            }
          }
        }
      }
      ResultData.put(json);
    }
    ResultJson.put("MsgID", 1);
    ResultJson.put("MsgText", "Success!");
    ResultJson.put("Data", ResultData);
    
    response.getWriter().println(ResultJson.toString());
    response.getWriter().flush();

  }

}
