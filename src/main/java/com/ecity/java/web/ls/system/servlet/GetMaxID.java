package com.ecity.java.web.ls.system.servlet;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.java.sql.SQLCon;


@WebServlet("/System/GetMaxID.json")


public class GetMaxID extends HttpServlet {
  
  /**
   * 
   */
  private static final long serialVersionUID = 5204472921266077804L;

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
    resp.setContentType("application/json;charset=utf-8"); 
    resp.setCharacterEncoding("UTF-8");  
    resp.setHeader("Cache-Control", "no-cache");
    JSONObject ReturnJson = new JSONObject(); 
    
    try
    {
      try{
        Connection conn = SQLCon.GetConnect();
        CallableStatement c=conn.prepareCall("{call uspGetMaxId(?,?)}");//调用带参的存储过程
        //给存储过程的参数设置值
        c.setString(1,"5");   //将第一个参数的值设置成测试
        c.registerOutParameter(2,java.sql.Types.VARCHAR);//第二个是返回参数  返回未Integer类型
        //执行存储过程
        c.execute();
        String MaxID=c.getString(2);

        ReturnJson.put("MsgID","1");
        ReturnJson.put("MsgText","Success");
        ReturnJson.put("MaxID",MaxID);
        conn.close();
      }catch(Exception e){
          e.printStackTrace();
          ReturnJson.put("MsgID","-1");
          ReturnJson.put("MsgText",e.getMessage());
      }
    }
    finally
    {
      resp.getWriter().print(ReturnJson.toString());
      resp.getWriter().flush();
    }
  }
}
