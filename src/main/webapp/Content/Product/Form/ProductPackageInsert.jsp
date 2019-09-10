<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>


	<style>
		#ProductPackageInsertModal .row+.row{
			margin-top: 5px;
		}
		#ProductPackageInsertModal .col-md-4 ,#ProductPackageInsertModal .col-md-12 {
			padding: 0px;
		}
		
		#ProductPackageInsertModal .row{
			padding-left: 10px;
			padding-right:10px;
		}
		
	</style>
	<!-- Modal -->
	<div class="modal fade" id="ProductPackageInsertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document" style="width: 800px;">
			<div class="modal-content" >
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">套餐产品</h4>
				</div>
				<div class="modal-body">					
					<div class="ProductPackage">
						<div class="row">
							<div class="col-md-4">
								<div class="input-group" >
									<span class="input-group-addon" id="basic-addon1">ID</span>
									<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="epgm_id" readonly value="-1">
								</div>
							</div>
							<div class="col-md-4" style="display: none">
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">内部编码</span>
									<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epgm_Code">
								</div>
							</div>
							<div class="col-md-4">
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">对外关联编码</span>
									<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epgm_CodeOutSide">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12">
								<div class="input-group" style="width: 100%;">
									<span class="input-group-addon" id="basic-addon1">产品名称</span>
									<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epgm_Name">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-12" >
								<div class="input-group" style="width: 100%;">
									<span class="input-group-addon" id="basic-addon1">产品备注</span>
									<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epgm_Remark">
								</div>
							</div>
						</div>

						<div class="row">						
							<div class="col-md-4">
						
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">人数</span>
									<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epgm_ManNum">
								</div>
							</div>
							<div class="col-md-4" >

								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">成本价</span>
									<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epgm_CostMoney">
								</div>
							</div>
							<div class="col-md-4" >
								<div class="input-group">
									<span class="input-group-addon" id="basic-addon1">销售价</span>
									<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="epgm_SaleMoney">
								</div>
							</div>

						</div>
					 <div style="display: none">
							<input type="hidden" FieldName="epgm_status">
							<input type="hidden" FieldName="epgm_User_Ins">
							<input type="hidden" FieldName="epgm_Date_Ins">
							<input type="hidden" FieldName="epgm_User_Lst">
							<input type="hidden" FieldName="epgm_Date_Lst">
					 </div>
				 </div>
				 <div style="margin-top: 10px;">
						<table class="table DetilTable	DataTable table-striped">
							<thead>
								<tr>
									<td style="width:80px;">内部ID</td>
									<td>内部名称</td>
									<td style="width:80px;">供应商</td>
									<td style="width:80px;">国家</td>
									<td style="width:50px;">天数</td>
									<td style="width:80px;">数量</td>
									<td style="width:80px;">成本价</td>
									<td style="width:80px;">销售价</td>
									<td style="width:80px;">&nbsp;</td>
								</tr>
							</thead>
							<tbody>
								
							</tbody>
						</table>
						<div style="margin: 10px;">
							<a style="width:100%	" class="btn btn-primary	btn-sm" href="javascript:void(0);" onclick="ProductPackageDetil_Insert()"	role="button" >新增产品明细</a>
						</div>
				 </div>
			 </div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" onclick="ProductPackageDetil_Submit();" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<script id="DetilTableTemplate" type="text/html">
		<tr data-epgd_id="${epgd_id}" DataStatus="${epgd_status}">
			<td style="text-align:center;">${epgd_id}</td>
			<td style="text-align:center;">${epgd_Name}</td>
			<td style="text-align:center;">${SupplierName[epi_id_esi]}</td>
			<td style="text-align:center;">${CountryName[epi_id_act]}</td>
			<td style="text-align:center;">${epi_Day}</td>
			<td ><input type="text" class="form-control" FieldName="epgd_Num" value="${epgd_Num}"style="width: 100%;line-height: 2em;height: 2em;" onchange="SumCostMoney()"></td>
			<td style="text-align:right;">${epgd_CostMoney}</td>
			<td style="text-align:right;">${epgd_SaleMoney}</td>

				<td>
					<input type="hidden" FieldName="epgd_id" value="${epgd_id}">
					<input type="hidden" FieldName="epgd_status" value="${epgd_status}">
					<input type="hidden" FieldName="epgd_User_Ins" value="${epgd_User_Ins}">
					<input type="hidden" FieldName="epgd_Date_Ins" value="${epgd_Date_Ins}">
					<input type="hidden" FieldName="epgd_User_Lst" value="${epgd_User_Lst}">
					<input type="hidden" FieldName="epgd_Date_Lst" value="${epgd_Date_Lst}">
					<input type="hidden" FieldName="epgd_id_epgm" value="${epgd_id_epgm}">
					<input type="hidden" FieldName="epgd_id_epi" value="${epgd_id_epi}">
					<input type="hidden" FieldName="epgd_Name" value="${epgd_Name}">
					<input type="hidden" FieldName="epgd_CostMoney" value="${epgd_CostMoney}">
					<input type="hidden" FieldName="epgd_SaleMoney" value="${epgd_SaleMoney}">
					<a style="width:100%"	data-epgd_id="${epgd_id}" class="btn btn-danger	btn-xs" href="javascript:void(0);" onclick="ProductPackageDetil_Delete(this)"	role="button" >删除</a>
				</td>		
		</tr>
	</script>

	
<script type="text/javascript">
function ProductPackageDetil_Delete(t)
{
	var epgd_id=$(t).data("epgd_id")
	var tr=$("#ProductPackageDiv #ProductPackageInsertModal .DataTable>tbody>tr[data-epgd_id="+epgd_id+"]");
	tr.find("[FieldName=epgd_status]").val("D");
	tr.find("[FieldName=epgd_User_Lst]").val("<%=request.getSession().getAttribute("UserName") %>");
	tr.find("[FieldName=epgd_Date_Lst]").val(new Date().Format("yyyy-MM-dd HH:mm:ss"));
	tr.attr("DataStatus","D");
	
}
function SumCostMoney()
{
	var cost=0;
	var sale=0;
	$("#ProductPackageDiv	#ProductPackageInsertModal .DetilTable>tbody>tr").each(function(){
		cost=cost+$(this).find("[FieldName=epgd_CostMoney]").val()*1*$(this).find("[FieldName=epgd_Num]").val();
		sale=sale+$(this).find("[FieldName=epgd_SaleMoney]").val()*1*$(this).find("[FieldName=epgd_Num]").val();
	})
	$("#ProductPackageDiv	#ProductPackageInsertModal [FieldName=epgm_CostMoney]").val(cost);
	$("#ProductPackageDiv	#ProductPackageInsertModal [FieldName=epgm_SaleMoney]").val(sale);	
}

function ProductPackageDetil_Submit()
{
	
	var $loadingToast = $('#loadingToast');
	$loadingToast.fadeIn(100);
	
	var Data={}
	$("#ProductPackageDiv #ProductPackageInsertModal .ProductPackage [FieldName]").each(function(){
		var FieldName=$(this).attr("FieldName");
		var FieldValue=$(this).val();
		Data[FieldName]=FieldValue;
	})
	
	var DataDetilRows=[];	
	$("#ProductPackageDiv #ProductPackageInsertModal .DetilTable>tbody>tr").each(function(index){
		var tr=$(this);
		var DataDetil={};
		tr.find("[FieldName]").each(function(){
			var FieldName=$(this).attr("FieldName");
			var FieldValue=$(this).val();
			DataDetil[FieldName]=FieldValue;
		})
		DataDetilRows[index]=DataDetil;
	})
	//console.log(Data);
	var DataRows=[];	
	DataRows[0]=Data; 
	var json={"DataRows":DataRows,"DataDetilRows":DataDetilRows};
	

	//console.log(json);

	$.post("<%=request.getContextPath()%>/Content/Product/ProductPackagePost.json",JSON.stringify(json),function(data){
		//console.log(data);
		$loadingToast.fadeOut(100);
		if (data.MsgID!=1)
		{
			alert(data.MsgText);
		}
		else
		{
			alert("产品信息保存成功！");
			$("#ProductPackageDiv #ProductPackageInsertModal").modal("hide");
			ProductPackage_Query	();
		}
	},"json");
}

</script>	