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
@WebServlet("/web/Invoice/BookingInvoiceQuery.json")
public class BookingInvoiceQueryServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public BookingInvoiceQueryServlet() {
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
    String ID = params.get("ID") == null ? "-1" : (String) (params.get("ID")[0]);
    DBTable table= new DBTable(SQLCon.GetConnect(),"select * from aia_InvoiceApply where aia_status<>'D' and aia_id_ebo="+ID);
    
    try {
      table.Open();
      JSONArray Data=table.toJson();
      
      JSONObject ResultJson=WebFunction.WriteMsgToJson(1, "Success！");
      ResultJson.put("Data",Data);
      WebFunction.WriteMsgText(response, ResultJson);
      
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
