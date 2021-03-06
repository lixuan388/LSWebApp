package com.ecity.java.mvc.web.servlet.zjun;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.json.JSONObject;
import com.ecity.java.web.zjun.service.IZjunService;
import com.ecity.java.web.zjun.service.ZjunService;

@WebServlet("/zjun/v2sms")

public class v2sms extends HttpServlet {

  /**
   * 
   */
  private static final long serialVersionUID = 2137560795309734947L;

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

    IZjunService service = new ZjunService();
    JSONObject ReturnJson = service.v2sms(content, mobile);

    resp.getWriter().print(ReturnJson.toString());
    resp.getWriter().flush();

  }

}
