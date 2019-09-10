<%@ page isELIgnored="true" %>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
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
	<div id="SupplierInfoDiv" style="position: relative;">
	
	  <div>
	  	<div style="margin: 10px;">
	    	<a style="width:100%  " class="btn btn-primary btn-sm" href="javascript:void(0);" onclick="SupplierInfo_Insert()"  role="button" >新增记录</a>
			</div>
	    <table class="table table-hover table-striped DataTable">
	      <thead>
	        <td style="width:80px">ID</td>
	        <td>名称</td>
	        <td  style="width:100px">&nbsp;</td>
	      </thead>
	      <tbody>
	      
	      </tbody>
	      <tfoot>
	      </tfoot>
	    </table>
			<div style="margin: 10px;">
				<a style="width:100%  " class="btn btn-primary btn-sm" href="javascript:void(0);" onclick="SupplierInfo_Insert()"  role="button" >新增记录</a>
			</div>
	    
	  </div>
	  
	  <script id="DataTableTemplate" type="text/x-jquery-tmpl">
    <tr class="DataTr" KeyID="${esi_id}">
      <td style="text-align:center;" >${esi_id}</td>
      <td style="text-align:center;">${esi_Name}</td>
			<td>
				<input type="hidden" FieldName="esi_id" value="${esi_id}">
				<input type="hidden" FieldName="esi_Name" value="${esi_Name}">
				<input type="hidden" FieldName="esi_status" value="${esi_status}">
				<input type="hidden" FieldName="esi_User_Ins" value="${esi_User_Ins}">
				<input type="hidden" FieldName="esi_Date_Ins" value="${esi_Date_Ins}">
				<input type="hidden" FieldName="esi_User_Lst" value="${esi_User_Lst}">
				<input type="hidden" FieldName="esi_Date_Lst" value="${esi_Date_Lst}">

				<a style="" 
          class="btn btn-primary  btn-xs" 
					href="javascript:void(0);" 
					onclick="SupplierInfo_Edit(this)"  
					role="button" >修改</a>
				<a style="" 
          class="btn btn-danger  btn-xs" 
					href="javascript:void(0);" 
					onclick="SupplierInfo_Delete(this)"  
					role="button" >删除</a>
			</td>
    </tr>
  </script>
	  
	<jsp:include page="/Content/Base/Form/SupplierInfoEdit.jsp"/>
	  
	<script type="text/javascript">
	
	function SupplierInfo_Delete(t)
	{
		var td=$(t).parent();
		console.log(td);
		$("#SupplierInfoDiv #SupplierInfoEditModal  #myModalLabel").html("删除供应商信息")
		$("#SupplierInfoDiv #SupplierInfoEditModal  [onclick=SupplierInfoEdit_Submit]").html("确认删除")
		
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_id]").val(td.find('[FieldName=esi_id]').val());
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_Name]").val(td.find('[FieldName=esi_Name]').val());
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_status]").val("D");
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_User_Ins]").val(td.find('[FieldName=esi_User_Ins]').val());
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_Date_Ins]").val(td.find('[FieldName=esi_Date_Ins]').val());
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_User_Lst]").val("<%=request.getSession().getAttribute("UserName")%>");
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_Date_Lst]").val(new Date().Format("yyyy-MM-dd HH:mm:ss"));
		$("#SupplierInfoDiv #SupplierInfoEditModal").modal("show");  
	}
	
	function SupplierInfo_Edit(t)
	{
		var td=$(t).parent();
		$("#SupplierInfoDiv #SupplierInfoEditModal  #myModalLabel").html("修改供应商信息")
		$("#SupplierInfoDiv #SupplierInfoEditModal  [onclick=SupplierInfoEdit_Submit]").html("保存")
		
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_id]").val(td.find('[FieldName=esi_id]').val());
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_Name]").val(td.find('[FieldName=esi_Name]').val());
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_status]").val("E");
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_User_Ins]").val(td.find('[FieldName=esi_User_Ins]').val());
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_Date_Ins]").val(td.find('[FieldName=esi_Date_Ins]').val());
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_User_Lst]").val("<%=request.getSession().getAttribute("UserName")%>");
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_Date_Lst]").val(new Date().Format("yyyy-MM-dd HH:mm:ss"));
		$("#SupplierInfoDiv #SupplierInfoEditModal").modal("show");       
	}
	
	function SupplierInfo_Insert()
	{
		$("#SupplierInfoDiv #SupplierInfoEditModal  #myModalLabel").html("新增供应商信息")
		$("#SupplierInfoDiv #SupplierInfoEditModal  [onclick=SupplierInfoEdit_Submit]").html("保存")
		
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_id]").val("-1");
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_ame]").val("");
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_status]").val("I");
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_User_Ins]").val("<%=request.getSession().getAttribute("UserName")%>");
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_Date_Ins]").val(new Date().Format("yyyy-MM-dd HH:mm:ss"));
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_User_Lst]").val("<%=request.getSession().getAttribute("UserName")%>");
		$("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName=esi_Date_Lst]").val(new Date().Format("yyyy-MM-dd HH:mm:ss"));
		$("#SupplierInfoDiv #SupplierInfoEditModal").modal("show");      
		
	}
	
	function SupplierInfo_Query()
	{
	  $.ajax({
	    url: '<%=request.getContextPath() %>/Content/Base/SupplierInfoGet.json?d=' + new Date().getTime(),
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
	        $('#SupplierInfoDiv .DataTable>tbody').html('');
	        if (data.Data.length == 0)
	        {
	        } 
	        else
	        {
	          $('#SupplierInfoDiv .DataTable>tbody').html('');
	          var TemplateData=data.Data;
	          $("#SupplierInfoDiv #DataTableTemplate").tmpl(TemplateData).appendTo('#SupplierInfoDiv .DataTable>tbody');
	        }
	      }
	    }
	  })  
	}
	
	$(function () {
		SupplierInfo_Query();
	  
	})
	
	</script>
	  
	
	</div>    
	
</div>
<script type="text/javascript">
	
	$(function(){
		var $loadingToast = $('#loadingToast');
		$loadingToast.fadeOut(100);
	})
</script>
</body>
</html>