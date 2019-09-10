package com.ecity.java.mvc.web.servlet.system;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.json.JSONObject;
import com.ecity.java.sql.db.DBTable;
import com.ecity.java.web.WebFunction;
import com.java.sql.SQLCon;

/**
 * Servlet implementation class LeftSideMenuServlet
 */
@WebServlet("/web/system/CountryOperationButtonQuery.json")
public class CountryOperationButtonQueryServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public CountryOperationButtonQueryServlet() {
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
    String QueryText = params.get("QueryText") == null ? "" : (String) (params.get("QueryText")[0]);
    String SelectArea = params.get("SelectArea") == null ? "0" : (String) (params.get("SelectArea")[0]);

    if (!QueryText.equals(""))
    {
      QueryText=" and act_name like '%"+QueryText+"%'";
    }
    if (!SelectArea.equals("0"))
    {
      QueryText=" and act_id_aar ="+SelectArea;
    }

    JSONObject ReturnJson = new JSONObject();

    ReturnJson.put("MsgID", "1");
    ReturnJson.put("MsgText", "Success");
    
//    System.out.println(QueryText);
    DBTable table =new DBTable(SQLCon.GetConnect(),"select act_id,act_name from act_country where act_status<>'D' and act_flag=1 "+QueryText);
    try {
      table.Open();

      ReturnJson.put("CountryData",table.toJson());
    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    finally {
      table.CloseAndFree();
    }

    DBTable table2 =new DBTable(SQLCon.GetConnect(),"select acb_id_act,acb_id_sob,acb_flag from acb_country_button,act_country where  acb_status<>'D' and acb_id_act=act_id and act_status<>'D' and act_flag=1 "+QueryText);
    try {
      table2.Open();

      ReturnJson.put("ButtonData",table2.toJson());
    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
    finally {
      table2.CloseAndFree();
    }
    
    
    
    response.getWriter().println(ReturnJson.toString());
    response.getWriter().flush();
  }

  /**
   * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub
    doGet(request, response);
  }

}
