package com.ecity.java.mvc.web.servlet.zjun;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.json.JSONObject;
import com.ecity.java.web.zjun.service.IZjunService;
import com.ecity.java.web.zjun.service.ZjunService;

@WebServlet("/zjun/v2smsOverage")

public class v2smsOverage extends HttpServlet {

  /**
   * 
   */
  private static final long serialVersionUID = 3060182914940240820L;

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

    IZjunService service = new ZjunService();
    JSONObject ReturnJson = service.v2smsOverage();
    resp.getWriter().print(ReturnJson.toString());
    resp.getWriter().flush();

  }

}
