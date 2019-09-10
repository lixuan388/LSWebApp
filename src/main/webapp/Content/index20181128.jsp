<%@page import="com.java.version"%>
<%@page import="com.ecity.java.web.taobao.Variable"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecity.java.web.ls.system.fun.BuildMenu" %>
<%@page import="com.ecity.java.web.ls.Parameter.Json.SupplierInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.CountryJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>


<%
	String authorizeUrl=URLEncoder.encode("http://ls.17ecity.cc:18888"+request.getContextPath()+"/Server/authorize?state=1212");
%>
<%@ page import="java.util.Iterator" %>

<!DOCTYPE html>
<html lang="zh-CN" >
<head>
	<jsp:include page="/head.jsp"/>
	<script src="<%=request.getContextPath() %>/res/js/bootstrap-treeview.min.js"></script>
	<link href="<%=request.getContextPath() %>/Content/index.css" rel="stylesheet">
	<link href="<%=request.getContextPath() %>/res/css/FlexLayout.css" rel="stylesheet">
	<title>WebApp</title>
</head> 
<body >

<div class="LayoutMain" style="background-color: #e7e7e7;" >

	<div>
		<!-- 页头 begin -->
		<jsp:include page="/Content/navbar-header-default.jsp"/>
		<!-- 页头 end -->
	</div>
	
	<div id="MainBody" class ="LayoutMainBody" >
		<div class="LayoutMainBodyLeft" >
			<div id="tree" ></div>
		</div> 
	
		<div id="MainTabDiv"  class="LayoutMainBodyCenter">
			<!-- Nav tabs -->
			<ul class="nav nav-tabs" id="MainTab" role="tablist">
				<li role="presentation" class="active"><a href="#FirstPage" aria-controls="home" role="tab" data-toggle="tab">首页</a></li>
			</ul>
		
			<!-- Tab panes -->
			<div class="tab-content" style="height:100%;">
				<div role="tabpanel" class="tab-pane active" id="FirstPage" style="overflow: scroll;">
					<div>电子商务操作平台</div>
					
					    <div><a href="https://oauth.taobao.com/authorize?response_type=code&client_id=25010520&redirect_uri=<%=authorizeUrl %>&view=web">飞猪登录</a></div>
					<div>https://oauth.taobao.com/authorize?response_type=code&client_id=25010520&redirect_uri=<%=authorizeUrl %>&view=web</div>
					<div><span>Sessionkey:</span><span><%=Variable.Sessionkey %></span></div>
					
				</div>
			</div>		
		</div>
	</div>
</div>


<div id="loadingToast" style=" display: none;">
	<div class="weui-mask_transparent"></div>
	<div class="weui-toast">
		<i class="weui-loading weui-icon_toast"></i>
		<p class="weui-toast__content">数据加载中</p>
	</div>
</div>




<script type="text/javascript">
var tree = [
	{
		'text': '电商操作',
		'href': '#',
		'id': '2',
		'nodes': [
			{
				'text': '订单查询',
				'href': '/Content/BookingOrder/Form/BookingOrderQuery.jsp?',
				'id': '21'
			},
			{
				'text': '飞猪订单查询',
				'href': '/Content/TaoBao/Form/alitripTravelTradesSearch2.jsp?',
				'id': '22'
			}
		]
	},
	{
		'text': '基础信息',
		'href': '#',
		'id': '3',
		'nodes': [
			{
				'text': '供应商',
				'href': '/Content/Base/Form/SupplierInfo.jsp?',
				'id': '31'
			},
			{
				'text': '短信模板',
				'href': '/Content/System/MessageTemplate.jsp?',
				'id': '32'
			},
			{
				'text': '顺风参数配置',
				'href': '/Content/SF/SFConfig.jsp?',
				'id': '33'
			}
		]
	},
	{
		'text': '产品管理',
		'href': '#',
		'id': '1',
		'nodes': [
			{
				'text': '产品类型',
				'href': '/Content/Product/Form/ProductType.jsp?',
				'id': '11'
			},
			{
				'text': '产品资料',
				'href': '/Content/Product/Form/ProductInfo.jsp?',
				'id': '12'
			},
			{
				'text': '产品上线',
				'href': '/Content/Product/Form/ProductPackage.jsp?',
				'id': '13'
			}
		]
	}

];
	function getTree() {
		// Some logic to retrieve, or generate tree structure
		return tree;
	}
	function LoadPage(name, id, href)
	{
		if (href=='#'){
			return;
		}
		var moduleid = 'ModuleID' + id;
		if ($('#MainTab a[href="#' + moduleid + '"').length == 0)
		{
			$('#MainTabDiv>ul').append('<li role="presentation"><a href="#' + moduleid + '" aria-controls="#' + moduleid + '"	role="tab" data-toggle="tab">【' + name + '】</a></li>');
			$('#MainTabDiv>.tab-content').append('<div role="tabpanel" class="tab-pane" id="' + moduleid + '"><iframe src="<%=request.getContextPath() %>'+href+'d=' + new Date().getTime()+'" scrolling="auto" frameborder="0" width="100%" height="100%"	></iframe></div>');
			$('#MainTab a[href="#' + moduleid + '"').tab('show');
		} 
		else {
			$('#MainTab a[href="#' + moduleid + '"').tab('show');
		}
	}
	$(function () {
		$('#tree').treeview({
			data: getTree(),
			levels: 1,
			onNodeSelected: function (event, data) {
				$('#tree').treeview('expandNode',data.nodeId);
				
				//console.log(data);
				//console.log(data.href);
				LoadPage(data.text, data.id, data.href);
			}
		});
	})



</script>
<script type="text/javascript">
	var ProductTypeJson=<%=new ProductTypeJson().GetJsonDataListString()%>
	var ProductTypeName=<%=new ProductTypeJson().GetJsonDataString()%>

	var CountryJson = <%=new CountryJson().GetJsonDataListString()%>
	var CountryName = <%=new CountryJson().GetJsonDataString()%>
	var SupplierJson = <%=new SupplierInfoJson().GetJsonDataListString()%>
	var SupplierName = <%=new SupplierInfoJson().GetJsonDataString()%>
</script>
	

</body>
</html>
