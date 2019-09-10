package com.ecity.java.web.ls.system.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.ecity.java.sql.table.MySQLTable;


/**
 *登录验证
 */

@WebServlet("/Content/System/SetUserModulePower.json")
public class SetUserModulePowerServlet extends HttpServlet {

	private static final long serialVersionUID = 1221671299145751538L;
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		resp.setContentType("application/json;charset=utf-8"); 
		resp.setCharacterEncoding("UTF-8");  
		resp.setHeader("Cache-Control", "no-cache");
		
		net.sf.json.JSONObject ReturnJson = new net.sf.json.JSONObject();
		
		SetUserModulePower(req,ReturnJson);
		System.out.println(ReturnJson.toString());
        resp.getWriter().print(ReturnJson.toString());
        resp.getWriter().flush();	
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(req,resp);

	}
	
	public static void SetUserModulePower(HttpServletRequest req,net.sf.json.JSONObject ReturnJson) throws IOException
	{
		HttpSession session = req.getSession();
		String UserID=session.getAttribute("UserID")==null?"":(String)(session.getAttribute("UserID"));
		System.out.println("SetUserModulePower:"+UserID);

		net.sf.json.JSONObject PowerJson = new net.sf.json.JSONObject();     

		if (UserID=="")
		{
			ReturnJson.put("MsgID","-1");
			ReturnJson.put("MsgTest","用户未登录！");
		}
		else
		{
			MySQLTable table=new MySQLTable("select m.modulename,m.moduletype,m.moduleid,s.s_module,s.s_insert,s.s_modify,s.s_delete,s.s_query,s.s_print,s.s_approve,s.s_excel \r\n" + 
					"from s_modulepower s,s_module m  \r\n" + 
					"where userid="+UserID+"\r\n" + 
					"and s.s_module=2\r\n" + 
					"and m.moduleid=s.moduleid\r\n" + 
					"order by m.moduletype, m.indexno");
			try
			{
				table.Open();
				if (!table.next())
				{					
					ReturnJson.put("MsgID","-1");
					ReturnJson.put("MsgTest","用户无权限");
				}
				else
				{
					while (table.next())
					{
						net.sf.json.JSONObject PowerInfoJson = new net.sf.json.JSONObject();		
						PowerInfoJson.put("ModuleName",table.getString("modulename"));
						PowerInfoJson.put("ModuleType",table.getString("moduletype"));
						PowerInfoJson.put("ModuleID",table.getString("moduleid"));
						PowerInfoJson.put("s_Module",table.getString("s_module"));
						PowerInfoJson.put("s_Insert",table.getString("s_insert"));
						PowerInfoJson.put("s_Modify",table.getString("s_modify"));
						PowerInfoJson.put("s_Delete",table.getString("s_delete"));
						PowerInfoJson.put("s_Query",table.getString("s_query"));
						PowerInfoJson.put("s_Print",table.getString("s_print"));
						PowerInfoJson.put("s_Approve",table.getString("s_approve"));
						PowerInfoJson.put("s_Excel",table.getString("s_excel"));
						PowerJson.put(table.getString("moduleid"),PowerInfoJson);
					}
			        session.setAttribute("ModulePower", PowerJson);
			        ReturnJson.put("MsgID","1");
					ReturnJson.put("MsgTest","Success");
				}
			}catch (SQLException e) {
        // TODO Auto-generated catch block

        ReturnJson.put("MsgID","-1");
        ReturnJson.put("MsgText",e.getMessage());
        e.printStackTrace();
        return;
      }
			finally
			{
				table.Close();
				
			}
		}
	}
	

}
