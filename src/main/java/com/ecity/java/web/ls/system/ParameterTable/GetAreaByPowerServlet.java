package com.ecity.java.web.ls.system.ParameterTable;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ecity.java.sql.table.MySQLTable;


@WebServlet("/Content/System/GetAreaByPower.json")



public class GetAreaByPowerServlet extends HttpServlet {

	private static final long serialVersionUID = 1221671299145751538L;
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		resp.setContentType("application/json;charset=utf-8"); 
		resp.setCharacterEncoding("UTF-8");  
		resp.setHeader("Cache-Control", "no-cache");
		
		net.sf.json.JSONArray ReturnJson = new net.sf.json.JSONArray();
		
		GetAreaByPower(req,ReturnJson);
//		System.out.println(ReturnJson.toString());
        resp.getWriter().print(ReturnJson.toString());
        resp.getWriter().flush();	
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req,resp);

	}
	
	public static void GetAreaByPower(HttpServletRequest req,net.sf.json.JSONArray RootJson) throws IOException
	{
		HttpSession session = req.getSession();
		String UserID=session.getAttribute("UserID")==null?"":(String)(session.getAttribute("UserID"));
//		System.out.println("GetAreaByPower:"+UserID);

			
		MySQLTable ParentTable=new MySQLTable("select aar_id,aar_name from aar_area where aar_status<>'D' and aar_parentid=-1 order by aar_id");

//		net.sf.json.JSONArray RootJson = new net.sf.json.JSONArray();	

		net.sf.json.JSONObject FirstParentJson = new net.sf.json.JSONObject();	
		
		FirstParentJson.put("text", "全部");
		FirstParentJson.put("href", "-1");

		net.sf.json.JSONArray ParentArrayJson = new net.sf.json.JSONArray();	
		
		try
		{
			ParentTable.Open();
			while (ParentTable.next())
			{

				net.sf.json.JSONObject ParentJson = new net.sf.json.JSONObject();	
				ParentJson.put("text", ParentTable.getString("aar_name"));
				ParentJson.put("href", ParentTable.getString("aar_id"));
				

				net.sf.json.JSONArray ChildArrayJson = new net.sf.json.JSONArray();	
				
				
				
				MySQLTable ChildTable=new MySQLTable("select aar_id,aar_name from aar_area where aar_status<>'D' and aar_parentid="+ParentTable.getString("aar_id")+" order by aar_id");
				
				try
				{
					ChildTable.Open();
					while (ChildTable.next())
					{
						net.sf.json.JSONObject ChildJson = new net.sf.json.JSONObject();	
						ChildJson.put("text", ChildTable.getString("aar_name"));
						ChildJson.put("href", ChildTable.getString("aar_id"));
						ChildArrayJson.add(ChildJson);
						
					}
				}catch (SQLException e) {
	        // TODO Auto-generated catch block

	        e.printStackTrace();
	        return;
	      }
				finally
				{
					ChildTable.Close();
				}

				ParentJson.put("nodes", ChildArrayJson);
				ParentArrayJson.add(ParentJson);
				
			}
			
		}catch (SQLException e) {
      // TODO Auto-generated catch block

      e.printStackTrace();
      return;
    }
		finally
		{
			ParentTable.Close();
			
		}
		FirstParentJson.put("nodes", ParentArrayJson);
		RootJson.add(FirstParentJson);
			
	}
	

}

