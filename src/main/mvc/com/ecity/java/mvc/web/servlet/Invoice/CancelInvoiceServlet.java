package com.ecity.java.mvc.web.servlet.Invoice;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;
import org.json.JSONException;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.dao.uilts.SQLUilts;
import com.ecity.java.sql.db.DBQuery;
import com.ecity.java.sql.db.DBTable;
import com.ecity.java.web.WebFunction;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.java.sql.SQLCon;
import com.mongodb.BasicDBList;
import com.mongodb.BasicDBObject;
import com.mongodb.DBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;

/**
 * Servlet implementation class BookingOrderPackageServlet
 */
@WebServlet("/web/Invoice/CancelInvoice.json")
public class CancelInvoiceServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public CancelInvoiceServlet() {
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

    if (!RequestJson.has("Data")) {
      WebFunction.WriteMsgText(response, -1,"缺少参数（Data）！");
      return;
    }


    JSONArray Data=RequestJson.getJSONArray("Data");
    String UserName=WebFunction.GetUserName(request);
    
    for (int i =0;i<Data.length();i++) {

      String id=Data.getString(i);
      DBQuery update=new DBQuery(SQLCon.GetConnect());
//      update.Execute("update aia_InvoiceApply set aia_StatusType='待开发票',aia_User_lst='"+UserName+"',aia_date_lst=getdate() where aia_id= "+id);
      update.Execute("update aia_InvoiceApply set aia_StatusType='已撤销',aia_User_lst='"+UserName+"',aia_date_lst=getdate() where aia_id= "+id+" and aia_StatusType <>'已开具'");
      
      update.Close();        
    }
    WebFunction.WriteMsgText(response, 1, "Success！");
  }

}
