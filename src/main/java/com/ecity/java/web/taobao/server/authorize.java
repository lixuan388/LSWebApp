package com.ecity.java.web.taobao.server;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bson.Document;
import org.json.JSONException;

import com.ecity.java.json.JSONObject;
import com.ecity.java.web.taobao.service.TaobaoService;
import com.ecity.java.web.taobao.Variable;
import com.java.sql.MongoCon;
import com.java.sql.MongoConnect;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.UpdateOptions;
import com.taobao.api.ApiException;
import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.TopAuthTokenCreateRequest;
import com.taobao.api.response.TopAuthTokenCreateResponse;

@WebServlet("/Server/authorize")

public class authorize extends HttpServlet {

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
//http://ls.17ecity.cc:18888/testls/Server/authorize?state=1212&code=4V48761Adr0rIf7IOJr39nkJ4357263&state=

    // resp.setContentType("application/json;charset=utf-8");
    resp.setContentType("text/html;charset=utf-8");

    resp.setCharacterEncoding("UTF-8");
    resp.setHeader("Cache-Control", "no-cache");

    System.out.println("-------------------------authorize-------------------------");
    Map<String, String[]> params = req.getParameterMap();

    for (String fieldName : params.keySet()) {
      System.out.println(fieldName + ":" + params.get(fieldName)[0]);
    }
    String Code = params.get("code")[0];

    TaobaoClient client = new DefaultTaobaoClient(Variable.url, Variable.appkey, Variable.appsecret);
    TopAuthTokenCreateRequest req2 = new TopAuthTokenCreateRequest();
    req2.setCode(Code);
    TopAuthTokenCreateResponse rsp2 = null;
    try {
      rsp2 = client.execute(req2);
    } catch (ApiException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    JSONObject ResultJson = null;
    System.out.println(rsp2.getBody());
    System.out.println(rsp2.getSubMsg());
    if (rsp2.getSubMsg() == null) {

      System.out.println(rsp2.getTokenResult());
      try {
        ResultJson = new JSONObject(rsp2.getTokenResult());
      } catch (JSONException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
      }
      System.out.println(rsp2.getBody());
      Variable.Sessionkey = ResultJson.getString("access_token");
      TaobaoService.Sessionkey = Variable.Sessionkey;

      MongoCollection<Document> collection = MongoCon.GetConnect().getCollection("api");
      Document document = new Document();
      document.put("Value", ResultJson.getString("access_token"));
      collection.updateMany(Filters.eq("Type", "Sessionkey"), new Document("$set", document),
          new UpdateOptions().upsert(true));

      resp.getWriter().println("<div>Sessionkey刷新成功</div>");
      resp.getWriter().println("<div>access_token:" + ResultJson.getString("access_token") + "</div>");
      resp.getWriter().flush();
    } else {
      resp.getWriter().println("<div style='color:red'>Sessionkey刷新失败</div>");
      resp.getWriter().println("<div>失败原因:" + rsp2.getSubMsg() + "</div>");
      resp.getWriter().flush();
    }

    System.out.println("-----------------------------------------------------------");

  }

}
