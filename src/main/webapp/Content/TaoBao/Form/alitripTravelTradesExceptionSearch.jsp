<%@page import="com.ecity.java.web.ls.Parameter.Json.SupplierInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.CountryJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
<%@ page isELIgnored="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN" style="height: 100%;">
<head>
<jsp:include page="/layuihead.jsp" />
<script type="text/javascript" src="<%=request.getContextPath() %>/res/js/alitrip.js"></script>
<title>WebApp</title>
<style type="text/css">
.layui-table-cell {
  height: inherit;
  line-height: inherit;
}
</style>
</head>
<body style="height: 100%;">
  <div id="MianDiv" style="position: relative; height: 100%; padding: 10px;">
    <div id="ProductInfoDiv" style="position: relative; height: 100%;">
      <div style="height: calc(100%); overflow: auto;">
        <table class="layui-table" lay-data="{ id:'DataGrid',page:true,limit:15,height: 'full-50', cellMinWidth: 80}" lay-filter="DataGrid">
          <thead>
            <tr>
              <th lay-data="{field:'OrderID2',width:175,align:'center'}">订单号码</th>
              <th lay-data="{field:'status',width: 270,align:'center'}">主订单状态</th>
              <th lay-data="{field:'created_time',width: 95,align:'center'}">订单日期</th>
              <th lay-data="{field:'item_title',align:'center'}">商品名称</th>
              <th lay-data="{field:'total_fee',width: 80,align:'center'}">金额</th>
              <th lay-data="{field:'OrderType',width: 200,align:'center'}">&nbsp;</th>
              <th lay-data="{field:'OrderType2',width: 105,align:'center',toolbar: '#TableOPBar'}">&nbsp;</th>
            </tr>
          </thead>
        </table>
      </div>
    </div>
  </div>
  <script type="text/html" id="TableOPBar">
	<div style="margin: 2px;"><a class="layui-btn layui-btn-xs" lay-event="Refresh" style="width: 100%;">刷新订单数据</a></div>
	<div style="margin: 2px;"><a class="layui-btn layui-btn-xs" lay-event="Open" style="width:100%;background-color: #5990b3;">查看订单数据</a></div>
	<div style="margin: 2px;"><a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="Edit" style="width:100%;">重新绑定产品</a><div>
</script>
  <script src="/Res/js/layer/layui/layui.js" charset="utf-8"></script>
  <!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
  <script>
	<%@ include file = "/Content/TaoBao/Form/alitripTravelTradesExceptionSearch.js" %>
</script>
</body>
</html>
