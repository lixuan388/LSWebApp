package com.ecity.java.mvc.web.servlet.Invoice;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
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
@WebServlet("/web/Invoice/InvoiceApplyOpen.json")
public class InvoiceApplyOpenServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public InvoiceApplyOpenServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub
    WebFunction.JsonHeaderInit(response);

    Map<String, String[]> params = request.getParameterMap();
    String ID = params.get("ID") == null ? "" : (String) (params.get("ID")[0]);
    if (ID.equals("-1")) {

      String OrderID = params.get("OrderID") == null ? "" : (String) (params.get("OrderID")[0]);
      if (OrderID.equals("")) {
        WebFunction.WriteMsgText(response, -1, "缺少参数（OrderID）！");
        return;
      }
      
      JSONObject DataJson=new JSONObject();
      try {
        DataJson.put("_id", SQLUilts.GetMaxID(SQLCon.GetConnect(), "ava_id"));
      } catch (JSONException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      } catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
        WebFunction.WriteMsgText(response, -1, "ID获取失败，请重试！");
      }
      DataJson.put("_id_ebo", OrderID);
      DataJson.put("_InvoiceType", "3");
      DataJson.put("_Content", "旅游签证费");
      DataJson.put("_Money", "0");
      DataJson.put("_Company", "");
      DataJson.put("_GuestIDCode", "");
      DataJson.put("_GuestAddr", "");
      DataJson.put("_GuestTel", "");
      DataJson.put("_GuestBankName", "");
      DataJson.put("_GuestBankCode", "");
      DataJson.put("_GuestEMail", "");
      DataJson.put("_Remark", "");
      DataJson.put("_StatusType", "未接单");

      JSONObject ResultJson=WebFunction.WriteMsgToJson(1, "Success！");
      ResultJson.put("Data", DataJson);
      WebFunction.WriteMsgText(response,ResultJson);
      return;
    }
    else {
      WebFunction.WriteMsgText(response, 1,  "Success！");
      return;
    }
  }

}
