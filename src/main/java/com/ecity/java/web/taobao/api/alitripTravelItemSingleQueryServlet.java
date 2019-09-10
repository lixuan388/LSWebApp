package com.ecity.java.web.taobao.api;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.json.JSONObject;
import com.ecity.java.web.taobao.service.TaobaoService;
import com.taobao.api.ApiException;

@WebServlet("/taobao/api/alitripTravelItemSingleQuery.json")

public class alitripTravelItemSingleQueryServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8290393593549983572L;

	@Override
	protected void doGet(HttpServletRequest Request, HttpServletResponse Response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		Response.setContentType("application/json;charset=utf-8"); 
		Response.setCharacterEncoding("UTF-8");  
		Response.setHeader("Cache-Control", "no-cache");

		Map<String, String[]> params = Request.getParameterMap();
		String ItemId =params.get("ItemId")==null?"0":(String)(params.get("ItemId")[0]);
		

		TaobaoService service=new TaobaoService();
		JSONObject ResultJson = null;
		try {
			ResultJson=service.alitripTravelItemSingleQuery(ItemId);
		} catch (ApiException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Response.getWriter().print(ResultJson.toString());
		Response.getWriter().flush();
		
	}
	
	
}
