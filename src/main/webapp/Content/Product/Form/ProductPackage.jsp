<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.SupplierInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.CountryJson"%>
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
	<div id="ProductPackageDiv"	 style="position: relative;height: 100%;padding: 10px;">
		<div>
			<div style="margin-top: 10px;margin-left: 20px;">
				<div class="input-group"	style="width: 500px;float:left;" >
					<span class="input-group-addon">搜索：</span>
					<input type="text" class="form-control" placeholder="产品名称/外部编码" id ="QueryText">
				</div>
				<button type="button" class="btn btn-primary" onclick="ProductPackage_Query();" style="float:left;margin-left: 10px;" >查询</button>
				<div style="clear: both;"></div>
			</div>
			<div style="margin: 10px 20px;border: 1px solid silver;"></div>
		</div>
			
		<div style="margin: 10px;">
			<a style="width:100%  " class="btn btn-primary btn-sm" href="javascript:void(0);" onclick="ProductPackage_Insert()"  role="button" >新增记录</a>
		</div>
		
		<div style="height: calc(100% - 90px);overflow: auto;">
			<table class="table table-hover DataTable easyui-datagrid" id="DataGrid" style="overflow: auto;height: 100%;"
				data-options="singleSelect:true,fitColumns:true,method:'get'">
				<thead>
					<tr>						
						<th data-options="field:'epgm_id',width: 80,sortable: false,align: 'center',halign: 'center'" >ID</th>
						<!--  <th data-options="field:'epgm_Code',width: 80,sortable: false,align: 'center',halign: 'center'" >内部编码</th>-->
						<th data-options="field:'epgm_CodeOutSide',width: 80,sortable: false,align: 'left',halign: 'center'">对外关联编码</th>
						<th data-options="field:'epgm_Name',width: 150,sortable: false,align: 'center',halign: 'center'" >产品名称</th>
						<th data-options="field:'epgm_ManNum',width: 80,sortable: false,align: 'center',halign: 'center'" >人数</th>
						<th data-options="field:'epgm_CostMoney',width: 80,sortable: false,align: 'right',halign: 'center'" >成本价</th>
						<th data-options="field:'epgm_SaleMoney',width: 80,sortable: false,align: 'right',halign: 'center'" >销售价</th>
						<th data-options="field:'OP',width:80,align:'right',formatter:OpenOrder"></th>
						
					</tr>
				</thead>
				<tbody>
					
				</tbody>
			</table>

		</div>
		
		
<jsp:include page="/Content/Product/Form/ProductPackageInsert.jsp"/>
<jsp:include page="/Content/Product/Form/ProductPackageSelectDetil.jsp"/>

<script type="text/javascript">
function ProductPackage_Insert()
{
  var $loadingToast = $('#loadingToast');
  $loadingToast.fadeIn(100);
  
  $.ajax({
    url: '<%=request.getContextPath() %>/System/GetMaxID.json?d=' + new Date().getTime(),
    type: 'get',
    dataType: 'Json',
    success: function (data) {
      $loadingToast.fadeOut(100);
      if (data.MsgID != 1)
      { 
        alert(data.MsgText);
        return;
      } 
      else
      {
        $("#ProductPackageDiv #ProductPackageInsertModal [FieldName]").val("");
        $("#ProductPackageDiv #ProductPackageInsertModal [FieldName=epgm_id]").val(data.MaxID*1);  
        $("#ProductPackageDiv #ProductPackageInsertModal [FieldName=epgm_status]").val("I");  
        $("#ProductPackageDiv #ProductPackageInsertModal [FieldName=epgm_User_Ins]").val("<%=request.getSession().getAttribute("UserName")%>");  
        $("#ProductPackageDiv #ProductPackageInsertModal [FieldName=epgm_Date_Ins]").val(new Date().Format("yyyy-MM-dd HH:mm:ss"));

        $("#ProductPackageDiv #ProductPackageInsertModal .DetilTable>tbody").html("");
        $("#ProductPackageDiv #ProductPackageInsertModal").modal("show");        
      }
    }
  })    
}
function ProductPackage_Edit(ID)
{
  var $loadingToast = $('#loadingToast');
  $loadingToast.fadeIn(100);
  
  $.ajax({
    url: '<%=request.getContextPath() %>/Content/Product/ProductPackageGet.json?ID='+ID+'&d=' + new Date().getTime(),
    type: 'get',
    dataType: 'Json',
    success: function (data) {
      $loadingToast.fadeOut(100);
      if (data.MsgID != 1)
      { 
        alert(data.MsgText);
        return;
      } 
      else
      {
        $("#ProductPackageDiv #ProductPackageInsertModal .ProductPackage [FieldName]").each(function(){
          $(this).val("");
          var FieldName=$(this).attr("FieldName");
          if (data.Data[0][FieldName])
          {
            $(this).val(data.Data[0][FieldName]);
          }
        });
        $("#ProductPackageDiv #ProductPackageInsertModal .ProductPackage [FieldName=epgm_User_Lst]").val("<%=request.getSession().getAttribute("UserName")%>");
        $("#ProductPackageDiv #ProductPackageInsertModal .ProductPackage [FieldName=epgm_Date_Lst]").val(new Date().Format("yyyy-MM-dd HH:mm:ss"));
        $("#ProductPackageDiv #ProductPackageInsertModal .DetilTable>tbody").html("");
        $("#ProductPackageDiv #DetilTableTemplate").tmpl(data.DetilData).appendTo($("#ProductPackageDiv #ProductPackageInsertModal .DetilTable>tbody"));  
        $("#ProductPackageDiv #ProductPackageInsertModal .DetilTable>tbody [FieldName=epgd_User_Lst]").val("<%=request.getSession().getAttribute("UserName")%>");
        $("#ProductPackageDiv #ProductPackageInsertModal .DetilTable>tbody [FieldName=epgd_Date_Lst]").val(new Date().Format("yyyy-MM-dd HH:mm:ss"));
        $("#ProductPackageDiv #ProductPackageInsertModal").modal("show");        
      }
    }
  })    
}

function ProductPackage_Query()
{
	var $loadingToast = loadingToast();
	var queryText=encodeURIComponent(encodeURIComponent($("#QueryText").val()));
	
  $.ajax({
    url: '<%=request.getContextPath() %>/Content/Product/ProductPackageGet.json?QueryText='+queryText+'&d=' + new Date().getTime(),
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
      	console.log(data.Data);
			    $('#DataGrid').datagrid({data:data.Data});
			    
      }
    }
  })
}

$(function () {
  ProductPackage_Query();
})


	function OpenOrder(val,row){
			return "<a style=\"width:100%\" class=\"btn btn-primary  btn-xs\" href=\"javascript:void(0);\" onclick=\"ProductPackage_Edit("+row.epgm_id+")\"  role=\"button\" >修改</a>";
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


</script>
</body>
</html>