package com.ecity.java.mvc.web.servlet.SF;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.ecity.java.json.JSONArray;
import com.ecity.java.mvc.dao.SF.WayBillOrderDao;
import com.ecity.java.mvc.model.SF.WayBillOrderPO;
import com.ecity.java.mvc.model.visa.ota.BookingOrderPackagePO;
import com.ecity.java.mvc.service.system.SystemService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderPackageService;
import com.ecity.java.web.SF.api.RouteService;
import com.ecity.java.web.SF.api.RouteService.Route;

/**
 * Servlet implementation class BookingOrderPackageServlet
 */
@WebServlet("/web/SF/GetSFOrderRoute.json")
public class GetSFOrderRouteServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public GetSFOrderRouteServlet() {
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

    Map<String, String[]> params = request.getParameterMap();
    String ID = params.get("ID") == null ? "0" : (String) (params.get("ID")[0]);

    JSONObject ReturnJson = new JSONObject();

    RouteService routeList = new RouteService(ID);
    try {
      routeList.GetXml(routeList.Send());
    } catch (Exception e) {
      // TODO: handle exception

      ReturnJson.put("MsgID", "-1");
      ReturnJson.put("MsgText", "信息获取失败！");
      response.getWriter().println(ReturnJson.toString());
      response.getWriter().flush();
      e.printStackTrace();
      return;
    }

    if (routeList.Head.equals("ERR")) {
      ReturnJson.put("MsgID", "-1");
      ReturnJson.put("MsgText", "ERROR:" + routeList.ERROR + ";" + "ERROR code:" + routeList.ERRORCode);
    } else {
//			System.out.println("RouteResponse_mailno:"+order.RouteResponse_mailno);

      ReturnJson.put("MsgID", "1");
      ReturnJson.put("MsgText", "Success");

      JSONArray routeListJson = new JSONArray();

      for (int i = 0; i < routeList.RouteList.size(); i++) {
        Route route = routeList.RouteList.get(i);

        JSONObject routeJson = new JSONObject();

//				System.out.println("----route----");
//				System.out.println("remark:"+route.remark);
//				System.out.println("accept_time:"+route.accept_time);
//				System.out.println("accept_address:"+route.accept_address);
//				System.out.println("opcode:"+route.opcode);
        routeJson.put("remark", route.remark);
        routeJson.put("accept_time", route.accept_time);
        routeJson.put("accept_address", route.accept_address);
        routeJson.put("opcode", route.opcode);
        routeListJson.put(routeJson);

      }
      ReturnJson.put("Data", routeListJson);
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
