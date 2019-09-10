package com.ecity.java.mvc.web.servlet.system;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.ecity.java.json.JSONObject;
import com.ecity.java.mvc.service.system.SystemService;
import com.ecity.java.web.WebFunction;

/**
 * Servlet implementation class GetVisaReturnDateServlet
 */
@WebServlet("/web/system/GetVisaReturnDate.json")
public class GetVisaReturnDateServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public GetVisaReturnDateServlet() {
    super();
    // TODO Auto-generated constructor stub
  }

  /**
   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
   *      response)
   */
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // TODO Auto-generated method stub

    response.setContentType("application/json;charset=utf-8");
    response.setCharacterEncoding("UTF-8");
    response.setHeader("Cache-Control", "no-cache");

    BufferedReader bufferReader = request.getReader();

    StringBuffer buffer = new StringBuffer();
    String line = " ";
    while ((line = bufferReader.readLine()) != null) {
      buffer.append(line);
    }

    JSONObject DataJson = null;
    try {
      DataJson = new JSONObject(buffer.toString());
    } catch (JSONException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
      WebFunction.WriteMsgText(response, -1, "json错误！");
      return;
    }

    if (!DataJson.has("avsID")) {
      WebFunction.WriteMsgText(response, -1, "缺少avsID！");
      return;
    }
    String avsID = DataJson.getString("avsID");

    if (!DataJson.has("actID")) {
      WebFunction.WriteMsgText(response, -1, "缺少actID！");
      return;
    }
    String actID = DataJson.getString("actID");

    if (!DataJson.has("SendDate")) {
      WebFunction.WriteMsgText(response, -1, "缺少SendDate！");
      return;
    }
    String SendDate = DataJson.getString("SendDate");
    SystemService service = new SystemService();
    String ReturnDate = service.GetVisaReturnDate(avsID, actID, SendDate);
    JSONObject ResultJson = new JSONObject();
    ResultJson.put("MsgID", 1);
    ResultJson.put("MsgTest", "Success!");
    ResultJson.put("ReturnDate", ReturnDate);

    response.getWriter().println(ResultJson.toString());
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
