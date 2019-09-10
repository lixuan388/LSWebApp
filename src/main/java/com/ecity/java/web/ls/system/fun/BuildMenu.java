package com.ecity.java.web.ls.system.fun;

import javax.servlet.http.HttpServletRequest;

import com.ecity.java.web.ls.system.servlet.SetUserModulePowerServlet;

public class BuildMenu {
	
	public static String MenuJson()
	{
		return "[{\"Name\":\"系统\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"用户权限\",\"BeginGroup\":\"false\",\"ID\":\"1010\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"默认权限\",\"BeginGroup\":\"false\",\"ID\":\"1011\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"密码更改\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"注销用户\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"系统通知\",\"BeginGroup\":\"true\",\"ID\":\"0\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"退出系统\",\"BeginGroup\":\"true\",\"ID\":\"0\",\"dropdown\":\"false\",\"Item\":[]}]},{\"Name\":\"基础资料\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"部门设置\",\"BeginGroup\":\"false\",\"ID\":\"2\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"部门职务\",\"BeginGroup\":\"false\",\"ID\":\"13\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团资料\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"旅行团区域\",\"BeginGroup\":\"false\",\"ID\":\"3\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"等级设置\",\"BeginGroup\":\"false\",\"ID\":\"4\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"联运城市资料\",\"BeginGroup\":\"false\",\"ID\":\"9205\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"签证类型\",\"BeginGroup\":\"false\",\"ID\":\"42\",\"dropdown\":\"false\",\"Item\":[]}]},{\"Name\":\"业务公司资料\",\"BeginGroup\":\"true\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"票务公司\",\"BeginGroup\":\"false\",\"ID\":\"15\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"保险公司\",\"BeginGroup\":\"false\",\"ID\":\"17\",\"dropdown\":\"false\",\"Item\":[]}]},{\"Name\":\"资料库\",\"BeginGroup\":\"true\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"资料库-供应商信息\",\"BeginGroup\":\"false\",\"ID\":\"60\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"资料库-景点资料\",\"BeginGroup\":\"false\",\"ID\":\"63\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"资料库-酒店资料\",\"BeginGroup\":\"false\",\"ID\":\"62\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"门票类型\",\"BeginGroup\":\"false\",\"ID\":\"901\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"酒店房型\",\"BeginGroup\":\"false\",\"ID\":\"11\",\"dropdown\":\"false\",\"Item\":[]}]}]},{\"Name\":\"计调作业\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"线路管理\",\"BeginGroup\":\"false\",\"ID\":\"101\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"计划制订\",\"BeginGroup\":\"false\",\"ID\":\"102\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"在售计划\",\"BeginGroup\":\"false\",\"ID\":\"105\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"计调运作\",\"BeginGroup\":\"true\",\"ID\":\"110\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团操团情况一览\",\"BeginGroup\":\"false\",\"ID\":\"111\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"APP抢购产品\",\"BeginGroup\":\"true\",\"ID\":\"9201\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团汇算\",\"BeginGroup\":\"true\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"旅行团车队信息\",\"BeginGroup\":\"false\",\"ID\":\"4991\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团订车分组\",\"BeginGroup\":\"false\",\"ID\":\"4992\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团订车计调查询\",\"BeginGroup\":\"false\",\"ID\":\"4993\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团订车财务审核\",\"BeginGroup\":\"false\",\"ID\":\"5021\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团地接分组\",\"BeginGroup\":\"true\",\"ID\":\"5000\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团地接计调查询\",\"BeginGroup\":\"false\",\"ID\":\"5001\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团地接财务审核\",\"BeginGroup\":\"false\",\"ID\":\"5002\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团订房分组\",\"BeginGroup\":\"true\",\"ID\":\"4994\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团订房计调查询\",\"BeginGroup\":\"false\",\"ID\":\"4995\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团订房财务审核\",\"BeginGroup\":\"false\",\"ID\":\"4996\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团门票分组\",\"BeginGroup\":\"true\",\"ID\":\"4997\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团门票计调查询\",\"BeginGroup\":\"false\",\"ID\":\"4998\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团门票财务审核\",\"BeginGroup\":\"false\",\"ID\":\"4999\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团票务分组\",\"BeginGroup\":\"true\",\"ID\":\"5015\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团票务查询\",\"BeginGroup\":\"false\",\"ID\":\"133\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团汇算表\",\"BeginGroup\":\"true\",\"ID\":\"492\",\"dropdown\":\"false\",\"Item\":[]}]},{\"Name\":\"行程库文档查询\",\"BeginGroup\":\"true\",\"ID\":\"50200\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"团队需求单计调审核\",\"BeginGroup\":\"false\",\"ID\":\"50108\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"线上需求单查询\",\"BeginGroup\":\"false\",\"ID\":\"336\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"采购申请单\",\"BeginGroup\":\"true\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"酒店采购申请单新增\",\"BeginGroup\":\"false\",\"ID\":\"50102\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"酒店采购申请单查询\",\"BeginGroup\":\"false\",\"ID\":\"50103\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"酒店采购申请单审核\",\"BeginGroup\":\"false\",\"ID\":\"50104\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"景区采购申请单新增\",\"BeginGroup\":\"true\",\"ID\":\"50105\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"景区采购申请单查询\",\"BeginGroup\":\"false\",\"ID\":\"50106\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"景区采购申请单审核\",\"BeginGroup\":\"false\",\"ID\":\"50107\",\"dropdown\":\"false\",\"Item\":[]}]},{\"Name\":\"特殊申请单\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"特殊申请单查询\",\"BeginGroup\":\"false\",\"ID\":\"50109\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"副总经理审核\",\"BeginGroup\":\"false\",\"ID\":\"50113\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"总经理审核\",\"BeginGroup\":\"false\",\"ID\":\"50114\",\"dropdown\":\"false\",\"Item\":[]}]}]},{\"Name\":\"前台作业\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"在售产品\",\"BeginGroup\":\"false\",\"ID\":\"201\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"旅行团补录\",\"BeginGroup\":\"true\",\"ID\":\"206\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"改团纸审核\",\"BeginGroup\":\"false\",\"ID\":\"207\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"团队需求单新增\",\"BeginGroup\":\"false\",\"ID\":\"50101\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"团队需求单查询\",\"BeginGroup\":\"false\",\"ID\":\"50100\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"APP抢购销售查询\",\"BeginGroup\":\"true\",\"ID\":\"9202\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"APP抢购报表\",\"BeginGroup\":\"false\",\"ID\":\"676\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"APP抢购跟进查询\",\"BeginGroup\":\"false\",\"ID\":\"9204\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"自助端订单查询\",\"BeginGroup\":\"true\",\"ID\":\"11028\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"自助端订单管理\",\"BeginGroup\":\"false\",\"ID\":\"9117\",\"dropdown\":\"false\",\"Item\":[]}]},{\"Name\":\"销售作业\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"特殊申请单\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"销售主管审核\",\"BeginGroup\":\"false\",\"ID\":\"50110\",\"dropdown\":\"false\",\"Item\":[]}]}]},{\"Name\":\"财务作业\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"特殊申请单\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"会计审核\",\"BeginGroup\":\"false\",\"ID\":\"50111\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"会计主管审核\",\"BeginGroup\":\"false\",\"ID\":\"50112\",\"dropdown\":\"false\",\"Item\":[]}]}]},{\"Name\":\"窗口\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"true\",\"Item\":[{\"Name\":\"层叠\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"横向平铺\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"纵向平铺\",\"BeginGroup\":\"false\",\"ID\":\"0\",\"dropdown\":\"false\",\"Item\":[]},{\"Name\":\"显示MDI窗口\",\"BeginGroup\":\"true\",\"ID\":\"0\",\"dropdown\":\"false\",\"Item\":[]}]}]";
	}

	public static String BuildChildMenu(net.sf.json.JSONArray ChildArray)	
	{
		StringBuffer Menu = new StringBuffer();		
		for (int i=0;i<ChildArray.size();i++)
		{			
			net.sf.json.JSONObject Child21=ChildArray.getJSONObject(i);
			if (Child21.getString("dropdown").equals("true"))
			{
//				Menu.append("<li class=\"dropdown-submenu dropdown\">");
				Menu.append("<li class=\"dropdown\">");
				Menu.append("<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"false\">");
				Menu.append(Child21.getString("Name")+"</span>");
				Menu.append("</a>");
				Menu.append("<ul class=\"dropdown-menu\">");				
				net.sf.json.JSONArray ChildArray2=Child21.getJSONArray("Item");
				Menu.append(BuildChildMenu(ChildArray2));				
				Menu.append("</ul>");
				Menu.append("</li>");
			}
			else
			{
				if (Child21.getString("BeginGroup").equals("true")) 
				{
					Menu.append("<li role=\"separator\" class=\"divider\"></li>");
				}
				Menu.append("<li><a href=\""+Child21.getString("ID")+"\">"+Child21.getString("Name")+"</a></li>");
			}
		}
		return Menu.toString();
	}
	public static String Build(HttpServletRequest req)
	{
		net.sf.json.JSONArray ModulePowerJson =net.sf.json.JSONArray.fromObject(MenuJson());
		StringBuffer Menu = new StringBuffer();
		for (int i=0;i<ModulePowerJson.size();i++)
		{	
			net.sf.json.JSONObject Child=ModulePowerJson.getJSONObject(i);
			if (Child.getString("dropdown").equals("true"))
			{
				Menu.append("<li class=\"dropdown\">");
				Menu.append("<a href=\"#\" class=\"dropdown-toggle\" data-toggle=\"dropdown\" role=\"button\" aria-haspopup=\"true\" aria-expanded=\"false\">");
				Menu.append(Child.getString("Name")+"<span class=\"caret\"></span>");
				Menu.append("</a>");
				Menu.append("<ul class=\"dropdown-menu\">");
				net.sf.json.JSONArray ChildArray=Child.getJSONArray("Item");
				Menu.append(BuildChildMenu(ChildArray));		
				Menu.append("</ul>");
				Menu.append("</li>");
			}
			else
			{
				Menu.append("<li><a href=\""+Child.getString("ID")+"\">"+Child.getString("Name")+"></a></li>");
			}
		}
		return Menu.toString();
	}
}
