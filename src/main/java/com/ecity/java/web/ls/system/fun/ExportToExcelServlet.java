package com.ecity.java.web.ls.system.fun;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ecity.java.sql.table.MySQLTable;


@WebServlet("/Content/System/ExportToExcel")



public class ExportToExcelServlet extends HttpServlet {

	private static final long serialVersionUID = 1221671299145751538L;
	
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("ExportToExcelServlet");


//		BufferedReader reader = new BufferedReader(new InputStreamReader(req.getInputStream()));

		resp.reset();

        resp.setContentType("application/vnd.ms-excel;charset=utf-8");
        
        OutputStream toClient = new BufferedOutputStream(resp.getOutputStream());
	    String line = "";        

		Map<String, String[]> params = req.getParameterMap();
		String DataTable =params.get("DataTable")==null?"":(String)(params.get("DataTable")[0]);//    	System.out.println(DataTable);	    
		line=URLDecoder.decode(DataTable);

		
//		
//	    StringBuffer buffer = new StringBuffer();
//	    while ((line = reader.readLine()) != null) {
//	    	buffer.append(line);
//	    }
//    	
//    	line=URLDecoder.decode(buffer.toString());

//	    BufferedReader bufferReader = req.getReader();//获取头部参数信息
//	    StringBuffer buffer = new StringBuffer();
//	    while ((line = bufferReader.readLine()) != null) {
//	        buffer.append(line);
//	    }
	    
	    
//    	System.out.println(line);	    

        Date ss = new Date();  
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
        String TempFile = format.format(ss.getTime());//这个就是把时间戳经过处理得到期望格式的时间  
	    
	    resp.addHeader("Content-Disposition", "attachment;filename=" +TempFile+".xls");
//	    resp.addHeader("Content-Length", "" + line.length());	    
	    
    	toClient.write(line.getBytes());    		
        toClient.flush();
        toClient.close();        
        
	}
	

}

