<%@page import="com.ecity.java.web.ls.Content.BookingOrder.alitripOrderInfoPostClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String OrderID=request.getParameter("OrderID")==null?"280907885786681709":request.getParameter("OrderID");


alitripOrderInfoPostClass Post=new alitripOrderInfoPostClass(OrderID);

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">

	<jsp:include page="/head.jsp"/>
	<link href="<%=request.getContextPath()	%>/res/js/jsoneditor/dist/jsoneditor.min.css" rel="stylesheet" type="text/css">
	<script src="<%=request.getContextPath()	%>/res/js/jsoneditor/dist/jsoneditor.min.js"></script>
	
<title>飞猪订单明细</title>
</head>
<body>

	<div id ="JsonDiv" style="height: calc(100vh);">
	</div>
	<script type="text/javascript">
		
		$(function(){
			var $loadingToast =loadingToast();
			//var MenuJson=<%=Post.toString()%>;
			var JsonDiv = document.getElementById('JsonDiv');
			
			var Json_options = {
					mode: 'tree',
					modes: ['code',  'tree'], // allowed modes
					onError: function (err) {
						alert(err.toString());
					},
					onModeChange: function (newMode, oldMode) {
						console.log('Mode switched from', oldMode, 'to', newMode);
					}
				};
			var Json_editor = new JSONEditor(JsonDiv, Json_options);
			Json_editor.set(MenuJson);
			Json_editor.expandAll();
			$loadingToast.modal("hide");
		})
	</script>	
</body>
</html>