<%@page import="com.ecity.java.web.ls.Parameter.Json.EVisaAreaJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.EVisaTypeJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.SupplierInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.CountryJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
<%@page import="com.ecity.java.json.JSONObject"%>
<%@page import="com.ecity.java.mvc.model.visa.ota.system.ProductInfoPO"%>
<%@page import="com.ecity.java.mvc.service.visa.ota.system.ProductInfoService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
		
<%
	String ID=request.getParameter("ID")==null?"0":request.getParameter("ID");
	ProductInfoService service=new ProductInfoService();
	ProductInfoPO p=null;
	if (ID.equals("-1"))
	{
		p=service.insert();
	}
	else
	{
		p=service.find(ID);
	}
	
	if (p==null)
	{
		%>
		<div>无对应记录！(<%=ID %>)</div>
		<%
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<jsp:include page="/layuihead.jsp"/>
	<style>
		.SelectVisaProductBtn[ProductType="1"]{
			display: inline-block;
			background-color: #1E9FFF;
			color: #fff;
			cursor: pointer;
		}
		.SelectVisaProductBtn{
			/*display: none;*/
		}
		.layui-form-label{
			width:120px;
		}
		.layui-input-block {
		    margin-left: 130px;
		}
	</style>
<title>Insert title here</title>
</head>
<body>
	<div style="margin: 20px;padding: 20px;" id ="ProductInfoInsertModal">
		<form class="layui-form" action="" lay-filter="table" >
			<div class="layui-form-item">
				<label class="layui-form-label">ID</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" placeholder="" name="_id" FieldName="_id" readonly value="">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">内部编码</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" placeholder="" name="_Code" FieldName="_Code" value="">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">产品名称</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" placeholder="" name="_Name" FieldName="_Name" value="">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">产品类型</label>
				<div class="layui-input-block">
					<div FieldName="_Type" ></div>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">供应商</label>
				<div class="layui-input-block">				
					<div FieldName="_id_Esi" ></div>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">国家</label>
				<div class="layui-input-block">
					<select name="_id_act" lay-search=""  FieldName="CountryName"></select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">天数</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" placeholder="" name="_Day" FieldName="_Day" value="">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">内部ID</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" placeholder="" name="_InSideID" FieldName="_InSideID" value="" style="display: inline-block;width: calc(100% - 100px);"  readonly="readonly">
					<button type="button" class="layui-btn layui-btn-disabled SelectVisaProductBtn" >选择产品</button>
				</div>
				
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">内部名称</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" placeholder="" name="_InSideName" FieldName="_InSideName" value="" readonly="readonly">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">送签流程</label>
				<div class="layui-input-block">				
					<div FieldName="_id_Evt" ></div>
				</div>
			</div>			
			<div class="layui-form-item">
				<label class="layui-form-label">送签领区</label>
				<div class="layui-input-block">				
					<div FieldName="_id_Eva" ></div>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">成本价</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" placeholder="" name="_CostMoney" FieldName="_CostMoney" value="">
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">销售价</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" placeholder="" name="_SaleMoney" FieldName="_SaleMoney" value="">
				</div>
			</div>
			<div style="display: none">
				<input type="hidden" FieldName="_status" name="_status">
				<input type="hidden" FieldName="_User_Ins" name="_User_Ins">
				<input type="hidden" FieldName="_Date_Ins" name="_Date_Ins">
				<input type="hidden" FieldName="_User_Lst" name="_User_Lst">
				<input type="hidden" FieldName="_Date_Lst" name="_Date_Lst">
			</div>
			<div class="">
				<button style="width:calc(50% - 10px)" type="button" class="layui-btn layui-btn-primary" onclick="closeWindows()">取消</button>
				<button style="width:calc(50% - 10px)" type="button" class="layui-btn layui-btn-normal"  lay-submit=""  lay-filter="ProductInfo_InsertSubmit">保存</button>
			</div>
		</form>
	</div>

		<!-- Modal -->
		<div class="modal fade" id="SelectVisaProductModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="myModalLabel">选择签证产品</h4>
					</div>
					<div class="modal-body">			
	
						<form class="layui-form" action="" lay-filter="myModalLabel" >
							<div class="layui-form-item">
								<div style="display: inline-block;width: calc(100% - 100px);"><select name="SearchVisaProductName" lay-search=""  FieldName="CountryName"></select></div>
								<div style="display: inline-block;"><button style="" type="button" class="layui-btn layui-btn-normal" onclick="SearchVisaProduct()">选择国家</button></div>
							</div>
						</form>							
							
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
<script type="text/javascript">


var ProductTypeJson=<%=new ProductTypeJson().GetJsonDataListString()%>
var ProductTypeName=<%=new ProductTypeJson().GetJsonDataString()%>

var CountryJson = <%=new CountryJson().GetJsonDataListString()%>
var CountryName = <%=new CountryJson().GetJsonDataString()%>
var SupplierJson = <%=new SupplierInfoJson().GetJsonDataListString()%>
var SupplierName = <%=new SupplierInfoJson().GetJsonDataString()%>

var VisaTypeName=<%=new EVisaTypeJson().GetJsonDataString()%>
var VisaAreaName=<%=new EVisaAreaJson().GetJsonDataString()%>


	
	$(function(){

		for (item in ProductTypeName)
		{
			//$("#ProductInfoInsertModal select[FieldName=_Type]").append("<option value="+item+">"+ProductTypeName[item]+"</option>")
			
			$("#ProductInfoInsertModal [FieldName=_Type]").append('<input type="radio"  name="_Type" lay-filter="ProductTypeName" value="'+item+'" title="'+ProductTypeName[item]+'" >')
		}
		for (item in CountryName)
		{
			$("select[FieldName=CountryName]").append("<option value="+item+">"+CountryName[item]+"</option>")
		}
		for (item in SupplierName)
		{
			//$("#ProductInfoInsertModal select[FieldName=_id_Esi]").append("<option value="+item+">"+SupplierName[item]+"</option>")
			$("#ProductInfoInsertModal [FieldName=_id_Esi]").append('<input type="radio" name="_id_Esi" value="'+item+'" title="'+SupplierName[item]+'" >')
		}

		for (item in VisaAreaName)
		{
			//$("#ProductInfoInsertModal select[FieldName=_id_Esi]").append("<option value="+item+">"+SupplierName[item]+"</option>")
			$("#ProductInfoInsertModal [FieldName=_id_Eva]").append('<input type="radio" name="_id_Eva" value="'+item+'" title="'+VisaAreaName[item]+'" >')
		}

		for (item in VisaTypeName)
		{
			//$("#ProductInfoInsertModal select[FieldName=_id_Esi]").append("<option value="+item+">"+SupplierName[item]+"</option>")
			$("#ProductInfoInsertModal [FieldName=_id_Evt]").append('<input type="radio" name="_id_Evt" value="'+item+'" title="'+VisaTypeName[item]+'" >')
		}

		$("#ProductInfoInsertModal").on("click"," .SelectVisaProductBtn[producttype=1]",function(){
			SelectVisaProduct();
		});
	})

	function SearchVisaProduct()
	{
		var KeyID=$('[name=SearchVisaProductName]').val();
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
					$("#SelectVisaProductModal .DataTable>tbody").html("");
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
						$("#SelectVisaProductModal .DataTable>tbody").append('<tr>' + td + '</tr>');
					}
				}
			}
		})
	}

	
	function SelectVisaProduct()
	{
		$("#SearchVisaProductName").attr("KeyID","-1");
		$("#SearchVisaProductName").val("");
		$("#SelectVisaProductModal").modal("show");
	}
		
	function ProductInfo_InsertSubmit()
	{
		var $loadingToast =loadingToast();
		var Data={}
		$("#ProductInfoInsertModal [FieldName]").each(function(){
			var FieldName=$(this).attr("FieldName");
			var FieldValue=$(this).val();
			Data["epi"+FieldName]=FieldValue;
		})
		delete Data.epiCountryName;
		
		console.log(Data);
		var DataRows=[];	
		DataRows[0]=Data; 
		var json={"DataRows":DataRows};
		
		return;
		
			$.post("<%=request.getContextPath()%>/Content/Product/ProductInfoPost.json?12123",JSON.stringify(json),function(data){
			//console.log(data);
	
			$loadingToast.modal("hide");
			if (data.MsgID!=1)
			{
				alert(data.MsgText);
			}
			else
			{
				alertlayer("产品信息保存成功！",function(){

					closeWindows();
				});
			}
		},"json");
	}
	

	function SetVisaProduct(t)
	{
		//console.log($(t));
		//console.log('avsID:'+$(t).data("avsid"));
		
		$("#ProductInfoInsertModal [FieldName=_InSideID]").val($(t).data("avsid"));
		$("#ProductInfoInsertModal [FieldName=_InSideName]").val($(t).data("avsname"));
		$("#ProductInfoInsertModal [FieldName=_SaleMoney]").val($(t).data("avsmoney"));
		$("#ProductInfoInsertModal [FieldName=_CostMoney]").val($(t).data("avscost"));
		
		if ($("#ProductInfoInsertModal [FieldName=_Code]").val()=="")
		{
			$("#ProductInfoInsertModal [FieldName=_Code]").val($(t).data("avsid"));
		}
		if ($("#ProductInfoInsertModal [FieldName=_CodeOutSide]").val()=="")
		{
			$("#ProductInfoInsertModal [FieldName=_CodeOutSide]").val($(t).data("avsid"));
		}
		if ($("#ProductInfoInsertModal [FieldName=_Name]").val()=="")
		{
			$("#ProductInfoInsertModal [FieldName=_Name]").val($(t).data("avsname"));
		}
		
	}
	function closeWindows()
	{
  	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
  	parent.layer.close(index); //再执行关闭   
	}
</script>	
<script>
<%@ include file = "/Content/Product/Form/ProductInfoInsert.js" %>
</script>  

</body>
</html>