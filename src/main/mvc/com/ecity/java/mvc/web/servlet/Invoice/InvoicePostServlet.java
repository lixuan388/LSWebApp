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
@WebServlet("/web/Invoice/InvoicePost.json")
public class InvoicePostServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public InvoicePostServlet() {
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

    JSONObject Data=RequestJson.getJSONObject("Data");
    if (!Data.has("_id")) {
      WebFunction.WriteMsgText(response, -1,"缺少参数（_id）！");
      return;
    }
    String _id=Data.getString("_id");
    String UserName=WebFunction.GetUserName(request);
    DBTable table= new DBTable(SQLCon.GetConnect(),"select * from aia_InvoiceApply where aia_id="+_id);
    
    try {
      table.Open();
      if (table.next()) {

        table.UpdateValue("aia_status", "E");
        table.UpdateValue("aia_User_Lst", UserName);
        table.UpdateDate("aia_Date_Lst", new Date().getTime());
      }
      else {
        table.insertRow();
        table.UpdateValue("aia_status", "I");
        table.UpdateValue("aia_User_Ins", UserName);
        table.UpdateDate("aia_Date_Ins", new Date().getTime());
        table.UpdateValue("aia_User_OP", UserName);
        table.UpdateDate("aia_Date_OP", new Date().getTime());
      }
      Iterator<String> keys = Data.keys();

      while(keys.hasNext()){
        // 获得key
        String key = keys.next();
        //根据key获得value, value也可以是JSONObject,JSONArray,使用对应的参数接收即可
        String value = Data.getString(key);
        System.out.println("key:"+key+"/value:"+value);
        table.UpdateValue("aia"+key, value);

      }
      if (table.PostRow()) {

        JSONObject ResultJson=WebFunction.WriteMsgToJson(1, "Success！");
        ResultJson.put("_id",_id);
        WebFunction.WriteMsgText(response, ResultJson);
        
        SQLUilts.UpdateInvoiceStatusType();
        return;
      }
      
    } catch (SQLException e) {
      // TODO: handle exception
      WebFunction.WriteMsgText(response, -1, e.getMessage());
      return;
    } finally {
      // TODO: handle finally clause
      table.Close();
    }
    
    
    
  }

}
