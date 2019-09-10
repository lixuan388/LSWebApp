<%@page import="com.ecity.java.mvc.model.visa.base.OrderStatusPO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.ecity.java.mvc.dao.visa.base.OrderStatusDao"%>
<%@ page isELIgnored="true" %>
<%@page import="com.java.version"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN"	style="height: 100%;">
<head>
	<jsp:include page="/layuihead.jsp"/>
	<title>WebApp</title>
	<style type="text/css">
	
	.layui-table-cell {
		height: inherit;
		line-height: inherit;
	}
	.layui-table-view .layui-form-radio > i {
    margin-right: 8px;
    font-size: 22px;
}
	</style>
	
</head> 
<body>
<div id="MianDiv"	 style="position: relative;height: 100vh;padding: 10px;">
	<table id='OrderStatusTable' lay-filter="OrderStatusTable">

	</table>
 
	<script type="text/html" id="barDemo">
<%

OrderStatusDao dao=new OrderStatusDao();
ArrayList<OrderStatusPO> list=dao.Find1();


for (int i =0;i<list.size();i++)
{
	
	OrderStatusPO po=list.get(i);
	%>
		<div style="display: inline-block;margin-right: 20px;">
			<input data-keyid="{{d._id}}" type="radio" name="_MainName{{d._id}}" value="<%=po.get_Name()%>" 
				title="<%=po.get_Name()%>" lay-filter="MainName" {{ d._MainName == '<%=po.get_Name()%>' ? 'checked' : '' }} lay-skin="primary" >
		</div>
	<%
}

%>
	</script>
	<div>
	
	


	
	</div>
</div>
<script>
<%@ include file = "/Content/Base/Visa/OrderStatus.js" %>
</script>
</body>
</html>