package com.ecity.java.mvc.web.servlet.SF;

import java.io.IOException;
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
import org.bson.types.ObjectId;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.web.WebFunction;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
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
@WebServlet("/web/SF/ExpressInvalid.json")
public class ExpressInvalidServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public ExpressInvalidServlet() {
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
    JSONArray List=RequestJson.getJSONArray("List");
    
    
    MongoDatabase database = MongoCon.GetConnect();
    MongoCollection<Document> collection = database.getCollection("OrderSendGoods");


    String UserName=WebFunction.GetUserName(request);
    

    Date ValidDateValue=new Date();
    
    
    String ValidDateDateStr=WebFunction.FormatDate(WebFunction.Format_YYYYMMDDHHMMSS,ValidDateValue);
    Long ValidDate=ValidDateValue.getTime();
    
    
    for (int i =0;i<List.length();i++) {
      String id=List.getString(i);

      //update 修改数据
      BasicDBObject query = new BasicDBObject("_id", new ObjectId(id));

      //更新多条数据
      BasicDBObject updateData = new BasicDBObject("$set", new BasicDBObject("Valid", "无效").append("ValidDateDateStr",ValidDateDateStr).append("ValidDate",ValidDate).append("ValidName",UserName)); 
      collection.updateMany(query, updateData);
      
    }
    WebFunction.WriteMsgText(response, 1, "Success");
    return;
  }

}
