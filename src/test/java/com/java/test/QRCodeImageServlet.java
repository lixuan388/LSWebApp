package com.java.test;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ecity.java.weixin.jssdk.Class.WXQRCodeCreateXXX;


@WebServlet("/test/QRCodeImage")
public class QRCodeImageServlet extends HttpServlet {

	private static final long serialVersionUID = 1221671299145751538L;
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		resp.setCharacterEncoding("UTF-8");  
		resp.setHeader("Cache-Control", "no-cache");
		
		
		WXQRCodeCreateXXX QR=new WXQRCodeCreateXXX("testurl");

        resp.getWriter().print("ticket:"+QR.ticket);
        resp.getWriter().print("expire_seconds:"+QR.expire_seconds);
        resp.getWriter().print("url:"+QR.url);
        resp.getWriter().flush();	
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req,resp);

	}
	

}
