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

@WebServlet("/taobao/api/alitripTravelTradesSearch.json")

public class alitripTravelTradesSearchServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6970525338096805017L;

	@Override
	protected void doGet(HttpServletRequest Request, HttpServletResponse Response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		Response.setContentType("application/json;charset=utf-8"); 
		Response.setCharacterEncoding("UTF-8");  
		Response.setHeader("Cache-Control", "no-cache");
		
		Map<String, String[]> params = Request.getParameterMap();
		String StartDate =params.get("StartDate")==null?"2018-09-01":(String)(params.get("StartDate")[0]);
		String EndDate =params.get("EndDate")==null?"2018-09-01":(String)(params.get("EndDate")[0]);
		String PageSize =params.get("PageSize")==null?"20":(String)(params.get("PageSize")[0]);    
		//订单状态 过滤。1-等待买家付款，2-等待卖家发货（买家已付款），3-等待买家确认收货，4-交易关闭（买家发起的退款），6-交易成功，8-交易关闭（订单超时 自动关单） 
		String Status =params.get("Status")==null?"1":(String)(params.get("Status")[0]); 
		String CurrentPage =params.get("CurrentPage")==null?"1":(String)(params.get("CurrentPage")[0]);
		
		TaobaoService service=new TaobaoService();
		JSONObject ResultJson = null;
		try {
			ResultJson=service.alitripTravelTradesSearch(StartDate, EndDate, PageSize, Status,CurrentPage);
		} catch (ApiException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		Response.getWriter().print(ResultJson.toString());
		Response.getWriter().flush();
		
	}
	
	
}
