<%@page import="com.ecity.java.web.ls.Parameter.Json.SupplierInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.CountryJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN"	style="height: 100%;">
<head>
	<jsp:include page="/head.jsp"/>
	<link rel="stylesheet" type="text/css" href="/Res/js/jquery-easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/Res/js/jquery-easyui/themes/icon.css">
	<script type="text/javascript" src="/Res/js/jquery-easyui/jquery.easyui.min.js"></script>
	
	<script type="text/javascript" src="/Res/js/jquery-easyui/easyui-lang-zh_CN.js"></script>

	<title>WebApp</title>
	<style>
		.SelectVisaProductBtn[ProductType="1"]{
			display: table-cell;
			background-color: red;
			color: #fff;
		}
		.SelectVisaProductBtn{
			display: none;
		}
		</style>	
</head> 
<body style="height: 100%;">		
<div id="MianDiv"	 style="position: relative;height: 100%;padding: 10px;">
		
	<div id="ProductInfoDiv" style="position: relative;height: 100%;">
	
		<div>
			<div style="margin-top: 10px;margin-left: 20px;">
				<div class="input-group"	style="width: 500px;float:left;" >
					<span class="input-group-addon">搜索：</span>
					<input type="text" class="form-control" placeholder="产品名称/内部编码" id ="QueryText">
				</div>
				<button type="button" class="btn btn-primary" onclick="ProductInfo_Query();" style="float:left;margin-left: 10px;" >查询</button>
				<div style="clear: both;"></div>
			</div>
			<div style="margin: 10px 20px;border: 1px solid silver;"></div>
		</div>
			
		<div style="margin: 10px;">
			<a style="width:100%	" class="btn btn-primary btn-sm" href="javascript:void(0);" onclick="ProductInfo_Insert()"	role="button" >新增记录</a>
		</div>
		
		<div style="height: calc(100% - 90px);overflow: auto;">
			<table class="table table-hover DataTable easyui-datagrid" id="DataGrid" style="overflow: auto;height: 100%;"
				data-options="singleSelect:true,fitColumns:true,method:'get'">
				<thead>
					<tr>						
						<th data-options="field:'epi_id',width: 80,sortable: false,align: 'center',halign: 'center'" >ID</th>
						<th data-options="field:'epi_Code',width: 80,sortable: false,align: 'center',halign: 'center'" >内部编码</th>
						<th data-options="field:'epi_Name',width: 350,sortable: false,align: 'left',halign: 'center'">产品名称</th>
						<th data-options="field:'ProductType',width: 80,sortable: false,align: 'center',halign: 'center'" >产品类型</th>
						<th data-options="field:'Supplier',width: 80,sortable: false,align: 'center',halign: 'center'" >供应商</th>
						<th data-options="field:'Country',width: 80,sortable: false,align: 'center',halign: 'center'" >国家</th>
						<th data-options="field:'epi_Day',width: 50,sortable: false,align: 'center',halign: 'center'" >天数</th>
						<th data-options="field:'epi_InSideID',width: 80,sortable: false,align: 'center',halign: 'center'" >内部ID</th>
						<th data-options="field:'epi_InSideName',width: 150,sortable: false,align: 'center',halign: 'center'" >内部名称</th>
						<th data-options="field:'epi_CostMoney',width: 80,sortable: false,align: 'right',halign: 'center'" >成本价</th>
						<th data-options="field:'epi_SaleMoney',width: 80,sortable: false,align: 'right',halign: 'center'" >销售价</th>
						
						<th data-options="field:'OP',width:80,align:'right',formatter:OpenOrder"></th>
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>

		</div>
		
		<script id="DataTableTemplate" type="text/x-jquery-tmpl">
		<tr class="DataTr" KeyID="${epi_id}">
			<td FieldName="epi_id" style="text-align:center;" >${epi_id}</td>
			<td FieldName="epi_Code" style="text-align:center;" >${epi_Code}</td>
			<td FieldName="epi_Name"	style="text-align:center;">${epi_Name}</td>
			<td FieldName="epi_Type"	style="text-align:center;">${ProductType}</td>
			<td FieldName="epi_id_esi"	style="text-align:center;">${Supplier}</td>
			<td FieldName="epi_id_act"	style="text-align:center;">${Country}</td>
			<td FieldName="epi_Day"	style="text-align:center;">${epi_Day}</td>
			<td FieldName="epi_InSideID"	style="text-align:center;">${epi_InSideID}</td>
			<td FieldName="epi_InSideName"	style="text-align:center;">${epi_InSideName}</td>
			<td FieldName="epi_CostMoney"	style="text-align:right;">${epi_CostMoney}</td>
			<td FieldName="epi_SaleMoney" style="text-align:right;">${epi_SaleMoney}</td>		 
		</tr>
		<tr class="OPTr" KeyID="${epi_id}">
			<td colspan="11">
				<div style="width:100%;text-align:center;" data-epi_id="${epi_id}" data-epi_Code="${epi_Code}" data-epi_CodeOutSide="${epi_CodeOutSide}"
					data-epi_Name="${epi_Name}" data-epi_Type="${epi_Type}" data-epi_InSideID="${epi_InSideID}"
					data-epi_id_esi="${epi_id_esi}" data-epi_id_act="${epi_id_act}" data-CountryName="${Country}"
					data-epi_Day="${epi_Day}"
					data-epi_InSideName="${epi_InSideName}" data-epi_CostMoney="${epi_CostMoney}" data-epi_SaleMoney="${epi_SaleMoney}"
					data-epi_status="${epi_status}" data-epi_User_Ins="${epi_User_Ins}" data-epi_Date_Ins="${epi_Date_Ins}"
					data-epi_User_Lst="${epi_User_Lst}" data-epi_Date_Lst="${epi_Date_Lst}"
				>
					<a style="margin-left: auto;margin-right: auto;width:150px;" class="btn btn-primary btn-xs" href="javascript:void(0);" onclick="ProductInfo_Edit(this)"	role="button" >修改记录</a>
					<a style="margin-left: auto;margin-right: auto;width:150px;" class="btn btn-danger btn-xs" href="javascript:void(0);" onclick="ProductInfo_Delete(this)"	role="button" >删除记录</a>
				</div>
			</td>
		</tr>
	</script>
		<script id="DataTableTemplate2" type="text/x-jquery-tmpl">
		<tr>
			<td style="text-align: center;" >
				<div>${avs_id}</div>
				<div>
					<button type="button" style="width:100%" data-avsid="${avs_id}" data-avsName="${act_name}-${avs_name}" 
						data-avsMoney="${avs_THMoney}" data-avsCost="${avs_cost}" 
						class="btn btn-primary btn-xs table-hover-d" onclick="SetVisaProduct(this);" data-dismiss="modal">
														选择
					</button>
				</div>
			</td>
			<td style="text-align: center;"	>${act_name}-${avs_name}</td>
					td = td + '<td style="text-align: center;"	>' + data.Data[i].avs_day + '</td>'
					td = td + '<td style="text-align: right;"	>' + data.Data[i].avs_money + '</td>'
					td = td + '<td style="text-align: right;"	>' + data.Data[i].avs_THMoney + '</td>'
					td = td + '<td style="text-align: right;"	>' + data.Data[i].avs_cost + '</td>'
					$("#ProductInfoDiv #SelectVisaProductModal .DataTable>tbody").append('<tr>' + td + '</tr>');
	</script>
		
		<!-- Modal -->
		<div class="modal fade" id="ProductInfoInsertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">新增产品</h4>
					</div>
					<div class="modal-body">					
						<div class="form-group">
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">ID</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="epi_id" readonly value="-1">
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">内部编码</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epi_Code">
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">产品名称</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epi_Name">
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">产品类型</span>
							 <select	class="form-control" FieldName="epi_Type" onchange="ChangeProductType(this)"></select>
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">供应商</span>
							 <select	class="form-control" FieldName="epi_id_esi"></select>
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">国家</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="CountryName">
							 <input type="hidden" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="epi_id_act">
							 
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">天数</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epi_Day">
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">内部ID</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epi_InSideID" readonly>
							 <span class="input-group-addon btn SelectVisaProductBtn">选择产品</span>
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">内部名称</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epi_InSideName" readonly>
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">成本价</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epi_CostMoney">
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">销售价</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epi_SaleMoney">
						 </div>
						 <div style="display: none">
								<input type="hidden" FieldName="epi_status">
								<input type="hidden" FieldName="epi_User_Ins">
								<input type="hidden" FieldName="epi_Date_Ins">
								<input type="hidden" FieldName="epi_User_Lst">
								<input type="hidden" FieldName="epi_Date_Lst">
						 </div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-primary" onclick="ProductInfo_InsertSubmit();" data-dismiss="modal">保存</button>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="SelectVisaProductModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">选择签证产品</h4>
					</div>
					<div class="modal-body">			
	
						<div class="form-group">
							<div class="input-group">
								<input type="text" class="form-control" placeholder="请输入国家名称" id="SearchVisaProductName">
								<span class="input-group-addon btn" onclick="SearchVisaProduct()">选择国家</span>
							 </div>
						</div>
						<div class="form-group" style="height:400px;overflow-x: auto;" >
							 <table class="table table-striped table-hover DataTable">
									<thead>
										<td style="width:80px">内部ID</td>
										<td>内部名称</td>
										<td style="width:50px">天数</td>
										<td style="width:80px">销售价</td>		
										<td style="width:80px">同行价</td>
										<td style="width:80px">成本价</td>
									</thead>
									<tbody>
									
									</tbody>
								</table>
						</div>
						
					</div>		
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					</div>
				</div>
			</div>
		</div>
		<!-- Modal -->
		<div class="modal fade" id="ProductInfoDeleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">是否确认删除产品？</h4>
					</div>
					<div class="modal-body"> 
						<div class="form-group">
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">ID</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="epi_id" readonly >
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">内部编码</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epi_Code" readonly>
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">产品名称</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epi_Name" readonly>
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">产品类型</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="epi_Type" readonly>
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">内部ID</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epi_InSideID" readonly>
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">内部名称</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epi_InSideName" readonly>
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">成本价</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epi_CostMoney" readonly>
						 </div>
						 <div class="input-group">
							 <span class="input-group-addon" id="basic-addon1">销售价</span>
							 <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epi_SaleMoney" readonly>
						 </div>
						 <div style="display: none" class="PostData" >
								<input type="hidden" FieldName="epi_status">
								<input type="hidden" FieldName="epi_User_Lst">
								<input type="hidden" FieldName="epi_Date_Lst">
								<input type="hidden" FieldName="epi_id" >
						 </div>
						</div>					
					</div>		
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						<button type="button" class="btn btn-DANGER" onclick="ProductInfo_DeleteSubmit();" data-dismiss="modal">确认删除</button>
					</div>
				</div>
			</div>
		</div>
	
		
	<script type="text/javascript">
	
	
	function ProductInfo_Insert()
	{
	
		var $loadingToast = loadingToast();
		
		$.ajax({
			url: '<%=request.getContextPath() %>/System/GetMaxID.json?d=' + new Date().getTime(),
			type: 'get',
			dataType: 'Json',
			success: function (data) {
				$loadingToast.modal("hide");
				if (data.MsgID != 1)
				{ 
					alert(data.MsgText);
					return;
				} 
				else
				{
					$("#ProductInfoDiv #ProductInfoInsertModal [FieldName]").val("");
					$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_id]").val(data.MaxID*1);	
					$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_Code]").val(data.MaxID);	
					$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_status]").val("I");	
					$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_User_Ins]").val("<%=request.getSession().getAttribute("UserName")%>");	
					$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_Date_Ins]").val(new Date().Format("yyyy-MM-dd HH:mm:ss"));
					$("#ProductInfoDiv #ProductInfoInsertModal").modal("show");				
				}
			}
		})	
	}
	
	function ProductInfo_Edit(t)
	{
		
		$("#ProductInfoDiv #ProductInfoInsertModal [FieldName]").each(function(){
			var FieldName=$(this).attr("FieldName");
			$(this).val($(t).parent().data(FieldName.toLowerCase()));
		});	
	
		
		$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_status]").val("E");	
		$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_User_Lst]").val("<%=request.getSession().getAttribute("UserName")%>");	
		$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_Date_Lst]").val(new Date().Format("yyyy-MM-dd HH:mm:ss"));	
		
		$("#ProductInfoDiv #ProductInfoInsertModal").modal("show");
	}
	
	function ProductInfo_Delete(t)
	{
		$("#ProductInfoDiv #ProductInfoDeleteModal [FieldName]").each(function(){
			var FieldName=$(this).attr("FieldName");
			$(this).val($(t).parent().data(FieldName.toLowerCase()));
		});
	
		$("#ProductInfoDiv #ProductInfoDeleteModal [FieldName=epi_status]").val("D");	
		$("#ProductInfoDiv #ProductInfoDeleteModal [FieldName=epi_User_Lst]").val("<%=request.getSession().getAttribute("UserName")%>");	
		$("#ProductInfoDiv #ProductInfoDeleteModal [FieldName=epi_Date_Lst]").val(new Date().Format("yyyy-MM-dd HH:mm:ss"));	
		
	
		$("#ProductInfoDiv #ProductInfoDeleteModal [FieldName=epi_Type]").val(ProductTypeJson[$(t).parent().data("api_type")]);	
		
		$("#ProductInfoDiv #ProductInfoDeleteModal").modal("show");
	}
	
	function ProductInfo_DeleteSubmit()
	{
		
		var $loadingToast = loadingToast();
		
		var Data={}
		$("#ProductInfoDiv>#ProductInfoDeleteModal .PostData>[FieldName]").each(function(){
			var FieldName=$(this).attr("FieldName");
			var FieldValue=$(this).val();
			Data[FieldName]=FieldValue;
		})
		
		//console.log(Data);
		var DataRows=[];	
		DataRows[0]=Data; 
		var json={"DataRows":DataRows};
		
			$.post("<%=request.getContextPath()%>/Content/Product/ProductInfoPost.json?12123",JSON.stringify(json),function(data){
			//console.log(data);
	
			$loadingToast.modal("hide");
			if (data.MsgID!=1)
			{
				alert(data.MsgText);
			}
			else
			{
				alert("产品删除成功！");
				ProductInfo_Query();
			}
		},"json");
	}
	
	
	function ProductInfo_InsertSubmit()
	{
		
		var $loadingToast =loadingToast();
		
		var Data={}
		$("#ProductInfoDiv>#ProductInfoInsertModal [FieldName]").each(function(){
			var FieldName=$(this).attr("FieldName");
			var FieldValue=$(this).val();
			Data[FieldName]=FieldValue;
		})
		delete Data.CountryName;
		
		console.log(Data);
		var DataRows=[];	
		DataRows[0]=Data; 
		var json={"DataRows":DataRows};
		
			$.post("<%=request.getContextPath()%>/Content/Product/ProductInfoPost.json?12123",JSON.stringify(json),function(data){
			//console.log(data);
	
			$loadingToast.modal("hide");
			if (data.MsgID!=1)
			{
				alert(data.MsgText);
			}
			else
			{
				alert("产品信息保存成功！");
				ProductInfo_Query();
			}
		},"json");
	}
	
	function ProductInfo_Query()
	{
		var $loadingToast = loadingToast();
		var queryText=encodeURIComponent(encodeURIComponent($("#QueryText").val()));
		//$loadingToast.fadeIn(100);			
		$.ajax({
			url: '<%=request.getContextPath() %>/Content/Product/ProductInfoGet.json?QueryText='+queryText+'&d=' + new Date().getTime(),
			type: 'get',
			dataType: 'Json',
			success: function (data) {
				//console.log(data);
				//$loadingToast.fadeOut(100);
				
				$loadingToast.modal("hide");
				if (data.MsgID != 1)
				{
					alert(data.MsgText);
					return;
				} 
				else
				{
					$('#ProductInfoDiv>div>.DataTable>tbody').html('');
					if (data.Data.length == 0)
					{
				    $('#DataGrid').datagrid({data:[]});
					} 
					else
					{
						//$.template("DataTableTemplate", $("#ProductInfoDiv #DataTableTemplate").html() );
						//console.log(data.Data[0]);
						
						var TemplateData=$.map( data.Data, function( item ) {
							item.ProductType=ProductTypeName[item.epi_Type]==undefined?item.epi_Type:ProductTypeName[item.epi_Type];
							item.Supplier=SupplierName[item.epi_id_esi]==undefined?item.epi_id_esi:SupplierName[item.epi_id_esi];
							item.Country=CountryName[item.epi_id_act]==undefined?item.epi_id_act:CountryName[item.epi_id_act];
							return item;
						});

				    $('#DataGrid').datagrid({data:data.Data});
				    
				    
						//$("#ProductInfoDiv #DataTableTemplate").tmpl(TemplateData).appendTo('#ProductInfoDiv>div>.DataTable>tbody');	
	
					}
				}
			}
		})
	}
	
	function ChangeProductType(t)
	{
		
		//console.log($(t).val());
		$("#ProductInfoDiv #ProductInfoInsertModal .SelectVisaProductBtn").attr("ProductType",$(t).val());
		
	}
	function SetVisaProduct(t)
	{
		//console.log($(t));
		//console.log('avsID:'+$(t).data("avsid"));
		
		$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_InSideID]").val($(t).data("avsid"));
		$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_InSideName]").val($(t).data("avsname"));
		$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_SaleMoney]").val($(t).data("avsmoney"));
		$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_CostMoney]").val($(t).data("avscost"));
		
		if ($("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_Code]").val()=="")
		{
			$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_Code]").val($(t).data("avsid"));
		}
		if ($("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_CodeOutSide]").val()=="")
		{
			$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_CodeOutSide]").val($(t).data("avsid"));
		}
		if ($("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_Name]").val()=="")
		{
			$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_Name]").val($(t).data("avsname"));
		}
		
	}
	
	function SelectVisaProduct()
	{
		$("#ProductInfoDiv #SearchVisaProductName").attr("KeyID","-1");
		$("#ProductInfoDiv #SearchVisaProductName").val("");
		$("#SelectVisaProductModal").modal("show");
	}
	
	function SearchVisaProduct()
	{
		var KeyID=$("#ProductInfoDiv #SearchVisaProductName").attr("KeyID");
		if ("KeyID"=="-1")
		{
			alert("请输入签证国家！")
			return ;
		}
		//alert(KeyID);
		$.ajax({
			url: '<%=request.getContextPath() %>/Content/Product/SearchVisaProduct.json?ID='+KeyID+'&d=' + new Date().getTime(),
			type: 'get',
			dataType: 'Json',
			success: function (data) {
				//console.log(data);
				//$loadingToast.fadeOut(100);
				if (data.MsgID != 1)
				{
					alert(data.MsgText);
					return;
				} 
				else
				{
					$("#ProductInfoDiv #SelectVisaProductModal .DataTable>tbody").html("");
					for (i = 0; i < data.Data.length; i++)
					{
						var td = '';
						td = td + '<td style="text-align: center;" ><div>' + data.Data[i].avs_id +
						'<div><div><button type="button" style="width:100%"'
						+' data-avsid="'+data.Data[i].avs_id+'" data-avsName="'+ data.Data[i].act_name+"-"+data.Data[i].avs_name 
						+'" data-avsMoney="'+data.Data[i].avs_THMoney+'" data-avsCost="'+data.Data[i].avs_cost+'"'
						+' class="btn btn-primary btn-xs table-hover-d" onclick="SetVisaProduct(this);" data-dismiss="modal">选择</button></div></td>'
						td = td + '<td style="text-align: center;"	>' + data.Data[i].act_name+"-"+data.Data[i].avs_name + '</td>'
						td = td + '<td style="text-align: center;"	>' + data.Data[i].avs_day + '</td>'
						td = td + '<td style="text-align: right;"	>' + data.Data[i].avs_money + '</td>'
						td = td + '<td style="text-align: right;"	>' + data.Data[i].avs_THMoney + '</td>'
						td = td + '<td style="text-align: right;"	>' + data.Data[i].avs_cost + '</td>'
						$("#ProductInfoDiv #SelectVisaProductModal .DataTable>tbody").append('<tr>' + td + '</tr>');
					}
				}
			}
		})
	}
	$(function () {
		//ProductInfo_Query();
		for (item in ProductTypeName)
		{
			$("#ProductInfoDiv #ProductInfoInsertModal select[FieldName=epi_Type]").append("<option value="+item+">"+ProductTypeName[item]+"</option>")
		}
		for (item in CountryName)
		{
			$("#ProductInfoDiv #ProductInfoInsertModal select[FieldName=CountyName]").append("<option value="+item+">"+CountryName[item]+"</option>")
		}
		for (item in SupplierName)
		{
			$("#ProductInfoDiv #ProductInfoInsertModal select[FieldName=epi_id_esi]").append("<option value="+item+">"+SupplierName[item]+"</option>")
		}
		
		$("#ProductInfoDiv").on("click"," #ProductInfoInsertModal .SelectVisaProductBtn[ProductType=1]",function(){
			SelectVisaProduct();
		});

		$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=CountryName]").autocomplete({
			//source:CountryJson,
			source: function( request, response ) {
				$("#ProductInfoDiv #ProductInfoInsertModal select[FieldName=epi_id_act]").val("-1");
				var matcher = new RegExp( $.ui.autocomplete.escapeRegex( request.term ), "i" );
				response( $.map( CountryJson, function( item ) {
					value = item.Name;
					if (matcher.test( value )){				
						return {
							label: item.Name,
							value: item.ID
						}
					}
				}));
			},
			select: function( event, ui ) {
				//console.log("this.value:"+this.value);
				//console.log("this.label:"+this.label);
				this.value = ui.item.label;
	
				$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_id_act]").val(ui.item.value);
				//this.label = "111";
				return false;
			},
			focus: function( event, ui ) {
				this.value = ui.item.label;
				return false;
			},
			response: function( event, ui ){
				//console.log("response:");
				//console.log(ui);
				//console.log(ui.content.length);
				if (ui.content.length==1)
				{
					$("#ProductInfoDiv #ProductInfoInsertModal [FieldName=epi_id_act]").val(ui.content[0].value);
				}
			}
			
		})
		
		
		$("#ProductInfoDiv #SearchVisaProductName" ).autocomplete({
			//source:CountryJson,
			source: function( request, response ) {
				$("#ProductInfoDiv #SearchVisaProductName").attr("KeyID","-1");
				var matcher = new RegExp( $.ui.autocomplete.escapeRegex( request.term ), "i" );
				response( $.map( CountryJson, function( item ) {
					value = item.Name;
					if (matcher.test( value )){				
						return {
							label: item.Name,
							value: item.ID
						}
					}
				}));
			},
			
			select: function( event, ui ) {
				//console.log("this.value:"+this.value);
				//console.log("this.label:"+this.label);
				this.value = ui.item.label;
				$("#ProductInfoDiv #SearchVisaProductName").attr("KeyID",ui.item.value);
				SearchVisaProduct();
				//this.label = "111";
				return false;
			},
			focus: function( event, ui ) {
				this.value = ui.item.label;
				return false;
			},
			response: function( event, ui ){
				//console.log("response:");
				//console.log(ui);
				//console.log(ui.content.length);
				if (ui.content.length==1)
				{
					$("#ProductInfoDiv #SearchVisaProductName").attr("KeyID",ui.content[0].value);
				}
			}
			
		})
	})
	
	function OpenOrder(val,row){
			
			return "			<div class=\"OPTr\" KeyID=\""+row.epi_id+"\">\r\n" + 
			"				<div style=\"width:100%;text-align:center;\" data-epi_id=\""+row.epi_id+"\" data-epi_Code=\""+row.epi_Code+"\" data-epi_CodeOutSide=\""+row.epi_CodeOutSide+"\"\r\n" + 
			"					data-epi_Name=\""+row.epi_Name+"\" data-epi_Type=\""+row.epi_Type+"\" data-epi_InSideID=\""+row.epi_InSideID+"\"\r\n" + 
			"					data-epi_id_esi=\""+row.epi_id_esi+"\" data-epi_id_act=\""+row.epi_id_act+"\" data-CountryName=\""+row.Country+"\"\r\n" + 
			"					data-epi_Day=\""+row.epi_Day+"\"\r\n" + 
			"					data-epi_InSideName=\""+row.epi_InSideName+"\" data-epi_CostMoney=\""+row.epi_CostMoney+"\" data-epi_SaleMoney=\""+row.epi_SaleMoney+"\"\r\n" + 
			"					data-epi_status=\""+row.epi_status+"\" data-epi_User_Ins=\""+row.epi_User_Ins+"\" data-epi_Date_Ins=\""+row.epi_Date_Ins+"\"\r\n" + 
			"					data-epi_User_Lst=\""+row.epi_User_Lst+"\" data-epi_Date_Lst=\""+row.epi_Date_Lst+"\"\r\n" + 
			"				>\r\n" + 
			"					<a style=\"margin-left: auto;margin-right: auto;width:50%;\" class=\"btn btn-primary btn-xs\" href=\"javascript:void(0);\" onclick=\"ProductInfo_Edit(this)\"	role=\"button\" >修改</a>\r\n" + 
			"					<a style=\"margin-left: auto;margin-right: auto;width:50%;\" class=\"btn btn-danger btn-xs\" href=\"javascript:void(0);\" onclick=\"ProductInfo_Delete(this)\"	role=\"button\" >删除</a>\r\n" + 
			"				</div>\r\n" + 
			"		</div>";
		
		
	}
	
	</script>
		</div>
		</div>
	

<script type="text/javascript">

var ProductTypeJson=<%=new ProductTypeJson().GetJsonDataListString()%>
var ProductTypeName=<%=new ProductTypeJson().GetJsonDataString()%>

var CountryJson = <%=new CountryJson().GetJsonDataListString()%>
var CountryName = <%=new CountryJson().GetJsonDataString()%>
var SupplierJson = <%=new SupplierInfoJson().GetJsonDataListString()%>
var SupplierName = <%=new SupplierInfoJson().GetJsonDataString()%>

	$(function(){
		//var $loadingToast = $('#loadingToast');
		//$loadingToast.fadeOut(100);
	})
</script>
</body>
</html>
