package com.ecity.java.mvc.web.servlet.visa.ota;

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
import com.ecity.java.mvc.model.visa.ota.BookingOrderPackagePO;
import com.ecity.java.mvc.service.system.SystemService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderPackageService;

/**
 * Servlet implementation class BookingOrderPackageServlet
 */
@WebServlet("/web/visa/ota/BookingOrderPackage.json")
public class BookingOrderPackageServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  /**
   * @see HttpServlet#HttpServlet()
   */
  public BookingOrderPackageServlet() {
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
    int PackageType = Integer.parseInt(params.get("PackageType") == null ? "0" : (String) (params.get("PackageType")[0]));

    BookingOrderPackageService service = new BookingOrderPackageService();
    SystemService systemService = new SystemService();

    ArrayList<BookingOrderPackagePO> list = service.findByeboID(ID);

    JSONObject ReturnJson = new JSONObject();

    ReturnJson.put("MsgID", "1");
    ReturnJson.put("MsgText", "Success");
    JSONArray packageListJson = new JSONArray();

    for (int i = 0; i < list.size(); i++) {
      BookingOrderPackagePO p = list.get(i);
      if (p.get_id_Ept() == PackageType) {
        JSONObject PackageJson = p.toJson();
        PackageJson.put("index", "" + (i + 1));

        String Name = service.Name("" + p.get_id_Ebon());
        String PassPort = service.PassPort("" + p.get_id_Ebon());
        String ProductTypeName = systemService.GetProductTypeName("" + p.get_id_Ept());
        String CountryName = systemService.GetCountryName("" + p.get_id_act());
        String _ebon_id_avg = service.GetAvgID("" + p.get_id_Ebon());

        PackageJson.put("_id_ebon_Name", Name);
        PackageJson.put("_id_ebon_Passpost", PassPort);
        PackageJson.put("_id_ept_name", ProductTypeName);
        PackageJson.put("_id_act_name", CountryName);
        PackageJson.put("_ebon_id_avg", _ebon_id_avg);

        packageListJson.put(PackageJson);
      }
    }
    ReturnJson.put("Data", packageListJson);
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
