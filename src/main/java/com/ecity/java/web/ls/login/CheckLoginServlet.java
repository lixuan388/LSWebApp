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
import com.ecity.java.sql.table.MySQLTable;
import com.ecity.java.web.WebFunction;
import com.java.version;

/**
 * 登录验证
 */

@WebServlet("/Login/CheckLogin")
public class CheckLoginServlet extends HttpServlet {

  private static final long serialVersionUID = 1221671299145751538L;

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
    Map<String, String[]> params = req.getParameterMap();
    String UserCode = params.get("UserCode") == null ? "" : (String) (params.get("UserCode")[0]);
    String PassWord = params.get("PassWord") == null ? "" : (String) (params.get("PassWord")[0]);
    CheckLogin(req, resp, UserCode, PassWord);
  }

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
    doGet(req, resp);
  }

  public void CheckLogin(HttpServletRequest req, HttpServletResponse resp, String UserCode, String PassWord)
      throws IOException {
    resp.setContentType("application/json;charset=utf-8");
    resp.setCharacterEncoding("UTF-8");
    resp.setHeader("Cache-Control", "no-cache");
    UserCode = URLDecoder.decode(UserCode, "UTF-8");
    JSONObject ReturnJson = new JSONObject();
    
    if (UserCode.equals("")) {
      ReturnJson.put("MsgID", "-1");
      ReturnJson.put("MsgTest", "请输入用户名！");
    } else {
      MySQLTable table = new MySQLTable(
          "select AUs_ID,AUs_UserName,AUs_UserCode,isnull(aus_temp3,'')  as aus_password,aco_id,aco_chn_name,aus_depart \r\n"
              + "from aus_users,aco_company \r\n" + "where aus_status<>'D' \r\n" + "and aus_id_aco=aco_id \r\n"
              + "and aus_UserCode='" + UserCode + "'");
      try {
        table.Open();
        if (!table.next()) {
          ReturnJson.put("MsgID", "-1");
          ReturnJson.put("MsgTest", "用户名不存在");
        } else {

          String PassWord3 = PassWord;
          String PassWord2 = table.getString("aus_password");
          if (!PassWord2.equals(PassWord3)) {
            ReturnJson.put("MsgID", "-2");
            ReturnJson.put("MsgTest", "密码错误！");
          } else {
            
            String UserID=table.getString("AUs_ID");
            LoginService loginSvc=new LoginService();
            loginSvc.CreateSession(req, UserID);
            
            ReturnJson.put("MsgID", "1");
            ReturnJson.put("MsgTest", "Success");
            
            JSONObject ConfigJson=new JSONObject();
            ConfigJson.put("ServerName", WebFunction.GetServerNameUrl(req));
            ConfigJson.put("ContextPath", WebFunction.GetContextPath(req));
            ConfigJson.put("Version", version.Version);
            ReturnJson.put("Config",ConfigJson);
          }
        }
      } catch (SQLException e) {
        // TODO Auto-generated catch block
        ReturnJson.put("MsgID", "-1");
        ReturnJson.put("MsgText", e.getMessage());
        e.printStackTrace();
        return;
      } finally {
        table.Close();
      }
    }
    System.out.println(ReturnJson.toString());
    resp.getWriter().print(ReturnJson.toString());
    resp.getWriter().flush();
  }

}
