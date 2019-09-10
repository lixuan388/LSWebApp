package com.ecity.java.mvc.web.servlet.SF;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.web.SF.api.SFApi;
import com.ecity.java.web.system.Config;
import com.ecity.java.web.system.SetConfigServlet;

@WebServlet("/web/SF/SetConfig.json")

public class SetSFConfigServlet extends SetConfigServlet {

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException {
    // TODO Auto-generated method stub
    super.doPost(req, resp);

    String tomcatPath = System.getProperty("catalina.home");
    String ConfigPath = tomcatPath + "\\conf\\webConfig.properties";
    System.out.println(ConfigPath);
    try {
      Config c = new Config(ConfigPath);
      c.load();

      // 顺风接口
      SFApi.ClientCode = c.getProperty("ls.SF.ClientCode");// 此处替换为您在丰桥平台获取的顾客编码
      SFApi.CheckWord = c.getProperty("ls.SF.CheckWord");// 此处替换为您在丰桥平台获取的校验码
      SFApi.CustID = c.getProperty("ls.SF.CustID");
      SFApi.J_Province = c.getProperty("ls.SF.J_Province");
      SFApi.J_City = c.getProperty("ls.SF.J_City");
      SFApi.J_County = c.getProperty("ls.SF.J_County");
      SFApi.J_Company = c.getProperty("ls.SF.J_Company");
      SFApi.J_Contact = c.getProperty("ls.SF.J_Contact");
      SFApi.J_Tel = c.getProperty("ls.SF.J_Tel");
      SFApi.J_Address = c.getProperty("ls.SF.J_Address");
      SFApi.ReqURL = c.getProperty("ls.SF.ReqURL");
      SFApi.WayBillPrintURL = c.getProperty("ls.SF.WayBillPrintURL");

    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
      System.err.println("-------------------");
      System.err.println("配置文件读取失败！");
      System.err.println(ConfigPath);

    }
  }

}
