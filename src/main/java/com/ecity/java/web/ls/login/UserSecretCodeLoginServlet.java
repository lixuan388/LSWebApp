package com.ecity.java.web.ls.login;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.service.system.LoginService;
import com.ecity.java.sql.db.DBTable;
import com.ecity.java.sql.table.MySQLTable;
import com.ecity.java.web.WebFunction;
import com.java.sql.SQLCon;

/**
 * 登录验证
 */

@WebServlet("/Login/UserSecretCodeLogin")
public class UserSecretCodeLoginServlet extends HttpServlet {

  private static final long serialVersionUID = 1221671299145751538L;

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
//        System.out.println("doPost begin");
    Map<String, String[]> params = req.getParameterMap();
    String SecretCode = params.get("SecretCode") == null ? "" : (String) (params.get("SecretCode")[0]);
    String Redirect = params.get("Redirect") == null ? "" : (String) (params.get("Redirect")[0]);
    CheckLogin(req, resp, SecretCode, Redirect);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
    doGet(req, resp);

  }

  public void CheckLogin(HttpServletRequest req, HttpServletResponse resp, String SecretCode, String Redirect)
      throws IOException {

    SecretCode = URLDecoder.decode(SecretCode, "UTF-8");

    Redirect = URLDecoder.decode(Redirect, "UTF-8");

    JSONObject ReturnJson = new JSONObject();

    if (SecretCode.equals("")) {
      ReturnJson.put("MsgID", "-1");
      ReturnJson.put("MsgTest", "请输入用户名！");
    } else {
      DBTable table =new DBTable(SQLCon.GetConnect(),"select aus_id from aus_users where aus_SecretCode='"+SecretCode+"'");

      try {
        table.Open();
        if (!table.next()) {
          ReturnJson.put("MsgID", "-1");
          ReturnJson.put("MsgTest", "用户名不存在");
          ReturnJson.put("Key", SecretCode);
        } else {
          String UserID=table.getString("aus_id");
          LoginService loginSvc=new LoginService();
          loginSvc.CreateSession(req, UserID);

          ReturnJson.put("MsgID", "1");
          ReturnJson.put("MsgTest", "Success");

          if (!Redirect.equals("")) {
            resp.sendRedirect(Redirect);
            return;
          }
        }
      } catch (SQLException e) {
        // TODO Auto-generated catch block
        ReturnJson.put("MsgID", "-1");
        ReturnJson.put("MsgText", e.getMessage());
        e.printStackTrace();
      } finally {
        table.Close();
      }
    }
    WebFunction.JsonHeaderInit(resp);
    resp.getWriter().print(ReturnJson.toString());
    resp.getWriter().flush();
  }

}
