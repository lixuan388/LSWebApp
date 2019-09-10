<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
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
	
<div id="ProductTypeDiv" style="position: relative;">

  <div>
    <table class="table table-hover table-striped DataTable">
      <thead>
        <td style="width:80px">ID</td>
        <td>产品类型</td>
      </thead>
      <tbody>
      
      </tbody>
      <tfoot>
      </tfoot>
    </table>
  </div>
  
  <script id="DataTableTemplate" type="text/x-jquery-tmpl">
    <tr class="DataTr" KeyID="${ID}">
      <td FieldName="ept_id" style="text-align:center;" >${ID}</td>
      <td FieldName="ept_Name"  style="text-align:center;">${Name}</td>     
    </tr>
  </script>
  
  
<script type="text/javascript">

function ProductType_Query()
{

  $('#ProductTypeDiv>div>.DataTable>tbody').html('');
  var TemplateData=ProductTypeJson;
  $("#ProductTypeDiv #DataTableTemplate").tmpl(TemplateData).appendTo('#ProductTypeDiv>div>.DataTable>tbody');  
  
}

$(function () {
  ProductType_Query();
  
})

</script>
  

</div>    

</div>
<script type="text/javascript">
var ProductTypeJson=<%=new ProductTypeJson().GetJsonDataListString()%>
var ProductTypeName=<%=new ProductTypeJson().GetJsonDataString()%>

	$(function(){
		var $loadingToast = $('#loadingToast');
		$loadingToast.fadeOut(100);
	})
</script>
</body>
</html>