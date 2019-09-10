<%@page import="java.sql.SQLException"%>
<%@page import="com.java.sql.SQLCon"%>
<%@page import="com.ecity.java.sql.db.DBTable"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.SupplierInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.CountryJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
<%@ page isELIgnored="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN" style="height: 100%;">
<head>
<jsp:include page="/layuihead.jsp" />
<title>WebApp</title>
<style type="text/css">
.layui-form-checkbox i {
	height: 30px;
}

.layui-table-cell, .layui-table-tool-panel li {
	white-space: inherit;
}

.layui-table-view .layui-table[lay-size="sm"] .layui-table-cell {
	height: inherit;
}
</style>
</head>
<body style="height: 100%;">
	<div id="MianDiv"
		style="position: relative; height: 100%; padding: 10px;">
		<div id="ProductInfoDiv" style="position: relative; height: 100%;">
			<div>
				<form class="layui-form layui-form-pane" action="">
					<div style="margin-top: 10px; margin-left: 20px;">
						<div class="layui-form-item">
							<div class="layui-inline">
								<label class="layui-form-label">搜索：</label>
								<div class="layui-input-inline">
									<input type="text" name="title" lay-verify="title"
										autocomplete="off" placeholder="产品名称/内部编码" class="layui-input"
										id="QueryText">
								</div>
							</div>
							<%
							  DBTable table =new DBTable(SQLCon.GetConnect(), "select Ept_Name,Ept_id from dbo.Ept_Product_Type where Ept_status<>'D'  order by ept_id");
															try
															{
																try {
																	table.Open();
																	while (table.next())
																	{
							%>

										<div class="layui-inline">
											<div class="layui-input-block" style="margin-left: 0px;">
												<input type="checkbox"
													name="ProductType" data-value="<%=table.getString("Ept_id") %>"
													title="<%=table.getString("Ept_Name") %>" checked="">
											</div>
										</div>
										<%
										}
				
									} catch (SQLException e1) {
										// TODO Auto-generated catch block
										e1.printStackTrace();
									}
								}
								finally
								{
									table.CloseAndFree();
								}
								%>
							<div class="layui-inline">
								<button type="button"
									class="layui-btn layui-btn-primary layui-btn-sm"
									lay-event="ProductInfoQuery" style="margin-left: 10px;">查询</button>
							</div>
							<div class="layui-inline">
								<button type="button" style="margin-left: 10px;"
									class="layui-btn layui-btn-normal layui-btn-sm"
									lay-event="ProductInfoInsert" role="button">新增记录</button>
							</div>

						</div>
					</div>

					<div style="margin: 10px 20px; border: 1px solid silver;"></div>
				</form>
			</div>

			<!--<div style="height: calc(100% - 90px);overflow: auto;">
			  <table class="layui-table" lay-data="{ id:'DataGrid',page:true,limit:15,height:'full-100'}" lay-filter="DataGrid">
				<thead>
					<tr>
						<th lay-data="{field:'epi_id',width: 80,align:'center'}" >ID</th>
						<th lay-data="{field:'epi_Code',width: 100,align:'center'}" >内部编码</th>
						<th lay-data="{field:'epi_Name',align:'center'}">产品名称</th>
						<th lay-data="{field:'ProductType',width: 120,align:'center'}" >产品类型</th>
						<th lay-data="{field:'Supplier',width: 80,align:'center'}" >供应商</th>
						<th lay-data="{field:'Country',width: 80,align:'center'}" >国家</th>
						<th lay-data="{field:'epi_Day',width: 50,align:'center'}" >天数</th>
						<th lay-data="{field:'epi_InSideID',width: 80,align:'center'}" >内部ID</th>
						<th lay-data="{field:'epi_InSideName',align:'center'}" >内部名称</th>
						<th lay-data="{field:'epi_CostMoney',width: 80,align:'center'}" >成本价</th>
						<th lay-data="{field:'epi_SaleMoney',width: 80,align:'center'}" >销售价</th>
						
						<th lay-data="{field:'OP',width:100,align:'right', toolbar: '#TableOPBar',align:'center'}"></th>
					</tr>
				</thead>
			</table>
		</div>
			-->
			<table class="layui-table" id='DataGrid' lay-filter="DataGrid">

			</table>
		</div>
	</div>
	<script type="text/html" id="TableOPBar">
	<a class="layui-btn layui-btn-xs" lay-event="edit" style="width: 40%;">修改</a>
	<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del" style="width: 40%;">删除</a>
</script>


	<script src="/Res/js/layer/layui/layui.js" charset="utf-8"></script>
	<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
	<script>
	<%@ include file = "/Content/Product/Form/ProductInfo.js" %>
</script>
	<script>
var ProductTypeName=<%=new ProductTypeJson().GetJsonDataString()%>

var CountryName = <%=new CountryJson().GetJsonDataString()%>
var SupplierName = <%=new SupplierInfoJson().GetJsonDataString()%>

</script>
</body>
</html>
