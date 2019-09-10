<%@ page isELIgnored="true" %>
<%@page import="com.java.version"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN"	style="height: 100%;">
<head>
	<jsp:include page="/layuihead.jsp"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/res/js/alitrip.js?d=<%=version.Version%>"></script>
	<title>WebApp</title>
	
	<style type="text/css">
.layui-table-cell {
    height: inherit;
}	
	.layui-btn{
		margin-right: 10px;
	}
	</style>
</head> 
<body>
<div  style="position: relative;height: 100vh;padding: 10px;">
	<div id="OrderStatusSyncDiv"	 class="layui-btn-group demoTable" style="margin-bottom: 10px;">
		<button class="layui-btn layui-btn-primary" data-type="QueryData">刷新</button>
		<button class="layui-btn layui-btn-normal" data-type="getCheckData">推送状态</button>
	</div>
	<table id='OrderStatusSyncTable' lay-filter="OrderStatusSyncTable">

	</table>

</div>
<script type="text/html" id="EosCodeTpl">
	<div style="line-height: 1.5em;display: inline-block;">
		<div>{{d.ebon_currentApplyStatus}}</div>
		<div>{{d.ebon_statustype}}</div>
	</div>
	<i class="layui-icon layui-icon-next"></i>
	<div style="line-height: 1.5em;display: inline-block;">
		<div>{{d.eos_code}}</div>
		<div>{{VisaStateName[d.eos_code]}}</div>
	</div>
</script>
<script type="text/html" id="avaStatustypeTpl">
	<div style="line-height: 1.5em;">
		<div>{{d.ava_statustype}}</div>
	</div>
</script>

<script type="text/html" id="eosMainNameTpl">
	<div style="line-height: 1.5em;">
		<div>{{d.ebo_statustype}}<i class="layui-icon layui-icon-next"></i>{{d.eos_mainName}}</div>
	</div>
</script>

<script type="text/html" id="eboSourceordernoTpl">
	<div style="line-height: 1.5em;">
		<a href="javascript:;" lay-event="OpenOrder" title="打开订单">
			<span>{{d.ebo_sourceorderno}}</span>
			<i class="layui-icon layui-icon-search"></i>
		</a>
	</div>
</script>


<script type="text/html" id="ebonIDTpl">
	<div style="line-height: 1.5em;">
		<div>{{d.ebon_id}}</div>
		<div>applyid:{{d.ebon_applyid}}</div>
	</div>
</script>



<script>
<%@ include file = "/Content/System/OrderStatusSyncQuery.js" %>
</script>
</body>
</html>