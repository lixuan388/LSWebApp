package com.ecity.java.web.ls.Content.VisaSign.Servlet;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.web.WebFunction;
import com.ecity.java.web.ls.system.SQL.TablePostData;

@WebServlet("/Content/VisaSign/VisaSignPost.json")

public class VisaSignPostServlet extends HttpServlet {



  /**
   * 
   */
  private static final long serialVersionUID = 759429559533955068L;

  @Override
  protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
    resp.setContentType("application/json;charset=utf-8"); 
    resp.setCharacterEncoding("UTF-8");  
    resp.setHeader("Cache-Control", "no-cache");
    
    
    BufferedReader bufferReader = req.getReader();

    
    StringBuffer buffer = new StringBuffer();
    String line = " ";
    while ((line = bufferReader.readLine()) != null) {
        buffer.append(line);
    }
  
//    System.out.println(buffer.toString());

    JSONObject DataJson=null;
    try {
      DataJson=new JSONObject(buffer.toString());
    } catch (JSONException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
      WebFunction.WriteMsgText(resp, -1, "json错误！");
      return ;
    }
        

    if (!DataJson.has("DataRows"))
    {
    	WebFunction.WriteMsgText(resp, -1, "json错误！无数据包(DataRows)！");
      return ;
    }
    if (!DataJson.has("DataSignRows"))
    {
    	WebFunction.WriteMsgText(resp, -1, "json错误！无数据包(DataSignRows)！");
      return ;
    }
    if (!DataJson.has("DataEbonRows"))
    {
    	WebFunction.WriteMsgText(resp, -1, "json错误！无数据包(DataEbonRows)！");
      return ;
    }

    JSONArray  DataSignRows =  DataJson.getJSONArray("DataSignRows"); 
    TablePostData Signtable=new TablePostData("ava_visa_application","ava_id",DataSignRows,"ava_id",false);
    Signtable.Post();
    
    JSONArray  DataEbonRows =  DataJson.getJSONArray("DataEbonRows"); 
    TablePostData Ebontable=new TablePostData("Ebon_BookingOrder_NameList","ebon_id",DataEbonRows,"ebon_id",false);
    Ebontable.Post();
    
    JSONArray  DataRows =  DataJson.getJSONArray("DataRows"); 
    TablePostData table=new TablePostData("avg_visa_group","avg_id",DataRows,"avg_id",false);
    
    JSONObject  ReturnJson=table.Post();
		resp.getWriter().print(ReturnJson.toString());
		resp.getWriter().flush();
  }
  
}
