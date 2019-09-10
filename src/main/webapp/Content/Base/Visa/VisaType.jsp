<%@ page isELIgnored="true" %>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN"	style="height: 100%;">
<head>
	<jsp:include page="/layuihead.jsp"/>
	<title>WebApp</title>
</head> 
<body>
<div id="MianDiv"	 style="position: relative;height: 100vh;padding: 10px;">
	 
	<table id='VisaTypeTable' >

	</table>
 
	<script type="text/html" id="barDemo">
		<a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
		<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
	</script>
</div>
<script>
<%@ include file = "/Content/Base/Visa/VisaType.js" %>
</script>
</body>
</html>