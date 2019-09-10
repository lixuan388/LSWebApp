package com.ecity.java.web.taobao.api;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;


@WebServlet("/taobao/api/alitripTravelTradeQuery.json")

public class alitripTravelTradeQueryServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -3811014699352751541L;

	@Override
	protected void doGet(HttpServletRequest Request, HttpServletResponse Response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		Response.setContentType("application/json;charset=utf-8"); 
		Response.setCharacterEncoding("UTF-8");	
		Response.setHeader("Cache-Control", "no-cache");
		JSONObject ReturnJson =null; 
		try
		{
			Map<String, String[]> params = Request.getParameterMap();
			String OrderID =params.get("OrderID")==null?"":(String)(params.get("OrderID")[0]);
			String IsUpdate =params.get("U")==null?"":(String)(params.get("U")[0]);
			
			if (OrderID.equals(""))
			{
				ReturnJson = new JSONObject(); 
				ReturnJson.put("MsgID","-1");
				ReturnJson.put("MsgText","缺少参数！（OrderID）");
				return ;
			}
			
			ReturnJson =new JSONObject();

			ReturnJson.put("Data",alitripTravelTradeQueryClass.OrderInfo(OrderID, !IsUpdate.equals("")));
			ReturnJson.put("MsgID","1");
			ReturnJson.put("MsgText","Success");
			
		}
		finally
		{
			Response.getWriter().print(ReturnJson.toString());
			Response.getWriter().flush();
		}
		
	}
	
	
}
