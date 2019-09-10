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
	<title>WebApp</title>
</head> 
<body style="height: 100%;">		
<div id="loadingToast" style=" display: none1;">
	<div class="weui-mask_transparent"></div>
	<div class="weui-toast">
		<i class="weui-loading weui-icon_toast"></i>
		<p class="weui-toast__content">数据加载中</p>
	</div>
</div>				


<div id="MianDiv"	 style="position: relative;height: 100%;padding: 10px;">
<div id="ProductPackageDiv" style="position: relative;">
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
	<div style="margin: 10px;">
    <a style="width:100%  " class="btn btn-primary btn-sm" href="javascript:void(0);" onclick="ProductPackage_Insert()"  role="button" >新增记录</a>
	</div>
  <div>
    
    <table class="table table-hover DataTable">
      <thead>
        <td style="width:80px">ID</td>
        <td style="width:80px">内部编码</td>
        <td style="width:80px">外部编码</td>
        <td>产品名称</td>
        <td style="width: 150px;">人数</td>
        <td style="width:80px">成本价</td>
        <td style="width:80px">销售价</td>    
        <td style="width:80px">&nbsp;</td>    
      </thead>
      <tbody>
      
      </tbody>
    </table>
  </div>

  <script id="DataTableTemplate" type="text/x-jquery-tmpl">
    <tr class="DataTr" KeyID="${epgm_id}">
        <td>${epgm_id}</td>
        <td>${epgm_Code}</td>
        <td>${epgm_CodeOutSide}</td>
        <td>${epgm_Name}</td>
        <td>${epgm_ManNum}</td>
        <td>${epgm_CostMoney}</td>
        <td>${epgm_SaleMoney}</td>    
        <td><a style="width:100%  " 
          class="btn btn-primary  btn-xs" href="javascript:void(0);" onclick="ProductPackage_Edit(${epgm_id})"  role="button" >修改</a></td>    
    </tr>
  </script>
    
  <div style="margin: 10px;">
    <a style="width:100%  " class="btn btn-primary  btn-sm" href="javascript:void(0);" onclick="ProductPackage_Insert()"  role="button" >新增记录</a>
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
  //var $loadingToast = $('#loadingToast');
  //$loadingToast.fadeIn(100);      
  $.ajax({
    url: '<%=request.getContextPath() %>/Content/Product/ProductPackageGet.json?d=' + new Date().getTime(),
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
        $('#ProductPackageDiv>div>.DataTable>tbody').html('');
        if (data.Data.length == 0)
        {

          var TemplateData=[];
          $("#ProductPackageDiv #DataTableTemplate").tmpl(TemplateData).appendTo('#ProductPackageDiv>div>.DataTable>tbody');  
        } 
        else
        {
          
          var TemplateData=data.Data;
          $("#ProductPackageDiv #DataTableTemplate").tmpl(TemplateData).appendTo('#ProductPackageDiv>div>.DataTable>tbody');  

        }
      }
    }
  })
}

$(function () {
  ProductPackage_Query();
})

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
		var $loadingToast = $('#loadingToast');
		$loadingToast.fadeOut(100);
	})
</script>
</body>
</html>