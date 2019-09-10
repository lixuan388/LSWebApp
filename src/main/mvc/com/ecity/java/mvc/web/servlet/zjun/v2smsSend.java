package com.ecity.java.mvc.web.servlet.zjun;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;
import org.json.JSONObject;

import com.ecity.java.mvc.service.visa.ota.BookingOrderService;
import com.ecity.java.web.WebFunction;
import com.ecity.java.web.zjun.service.IZjunService;
import com.ecity.java.web.zjun.service.ZjunService;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;

@WebServlet("/zjun/v2smsSend")

public class v2smsSend extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
    super.doPost(req, resp);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
    resp.setContentType("application/json;charset=utf-8");
    resp.setCharacterEncoding("UTF-8");
    resp.setHeader("Cache-Control", "no-cache");
    

    Map<String, String[]> params = req.getParameterMap();
    String content = params.get("content") == null ? "" : (String) (params.get("content")[0]);
    String mobile = params.get("mobile") == null ? "" : (String) (params.get("mobile")[0]);
    String EboID = params.get("EboID") == null ? "0" : (String) (params.get("EboID")[0]);

    IZjunService service = new ZjunService();
    JSONObject ReturnJson = service.v2smsSend(content, mobile);

    MongoDatabase database = MongoCon.GetConnect();
    MongoCollection<Document> collection = database.getCollection("sms");
    Document document = Document.parse(ReturnJson.toString());
    document.put("mobile", mobile);
    document.put("content", content);
    document.put("EboID", EboID);
    List<Document> documents = new ArrayList<Document>();
    documents.add(document);
    collection.insertMany(documents);

    BookingOrderService orderService = new BookingOrderService();
    orderService.InsertHistory(EboID, WebFunction.GetUserName(req), "短信", "号码：" + mobile + "；内容：" + content);

    resp.getWriter().print(ReturnJson.toString());
    resp.getWriter().flush();

  }

}
