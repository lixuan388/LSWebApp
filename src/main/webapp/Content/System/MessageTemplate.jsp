<%@page import="com.ecity.java.web.WebFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
		

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<jsp:include page="/head.jsp"/>
	<link href="<%=request.getContextPath() %>/res/css/FlexLayout.css" rel="stylesheet">

	<link rel="stylesheet" type="text/css" href="/Res/js/jquery-easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/Res/js/jquery-easyui/themes/icon.css">
	<script type="text/javascript" src="/Res/js/jquery-easyui/jquery.easyui.min.js"></script>
	
	<script type="text/javascript" src="/Res/js/jquery-easyui/easyui-lang-zh_CN.js"></script>
<title>短信模板</title>
</head>
<body>
<div class="LayoutMain">
	<div style="margin: 10px;">
		<button type="button" class="btn btn-primary" onclick="Query();" style="float:left;margin-left: 10px;width:100px;" >查询</button>
		<button type="button" class="btn btn-primary" onclick="Insert();" style="float:left;margin-left: 10px;width:100px;" >新增</button>
		<div style="clear: both;"></div>
	</div>
	<div style="margin: 10px 20px;border: 1px solid silver;"></div>
	<div style="overflow: auto;height: calc(100vh - 60px);padding: 5px;">
		<table class="table tableflow table-hover table-striped	DataTable easyui-datagrid" id="DataGrid" style="overflow: auto;height: 100%;"
			data-options="singleSelect:true,fitColumns:'true',method:'get'">
			<thead>
				<tr>
					<th data-options="field:'Index',width: 50,sortable: false,align: 'center',halign: 'center'">序号</th>
					<th data-options="field:'_id',width: 50,sortable: false,align: 'center',halign: 'center'">ID</th>
					<th data-options="field:'_Title',width: 100,sortable: false,align: 'center',halign: 'center'">名称</th>
					<th data-options="field:'_Content',width: 300,sortable: false,align: 'center',halign: 'center'">内容</th>					
					<th data-options="field:'_User_Ins',width: 80,sortable: false,align: 'center',halign: 'center'">新增人</th>
					<th data-options="field:'_Date_Ins',width: 150,sortable: false,align: 'center',halign: 'center'">新增日期</th>
					<th data-options="field:'_User_Ins',width: 80,sortable: false,align: 'center',halign: 'center'">修改人</th>
					<th data-options="field:'_Date_Lst',width: 150,sortable: false,align: 'center',halign: 'center'">修改日期</th>
					<th data-options="field:'OP',width:80,align:'right',formatter:OpenOrder"></th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
	</div>
</div>

	<!-- Modal -->
	<div class="modal fade" id="MessageTemplateEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document" style="width: 800px;">
			<div class="modal-content" >
				<div class="modal-header">
					<h4 class="modal-title" id="myModalLabel">新增短信模板</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">ID</span>
							<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="_id" readonly>
						</div>
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">名称</span>
							<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="_Title">
						</div>
						
						
						<div	style="margin-top:	5px;">
							<textarea	style="width:	100%;	height:	200px;resize:	none;" FieldName="_Content"></textarea>
						</div>
					
					
						</textarea>
						<input type="hidden" FieldName="_status" >
						<input type="hidden" FieldName="_User_Ins" >
						<input type="hidden" FieldName="_Date_Ins" >
						<input type="hidden" FieldName="_User_Lst" >
						<input type="hidden" FieldName="_Date_Lst" >
					</div>					
				</div>					
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" onclick="Post();" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>	
	
	
<script type="text/javascript"> 
	$(function(){
		$('.easyui-datagrid').datagrid();
		Query();
	})
	function OpenOrder(val,row){
		return '<button type="button" class="btn btn-primary btn-xs" onclick="Edit(\''+(row.Index-1)+'\')" style="width:50%">修改</button>'+
		'<button type="button" class="btn btn-danger btn-xs" onclick="Delete(\''+row.ebo_id+'\')" style="width:50%">删除</button>';
	}
	function Query()
	{
		
		var $loadingToast = loadingToast();
		$.ajax({
			url: '<%=request.getContextPath() %>/web/visa/ota/system/MessageTemplateGet.json?d=' + new Date().getTime(),
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
	function Insert()
	{
		
		var MessageTemplateEditModal=$("#MessageTemplateEditModal");
		MessageTemplateEditModal.find(".modal-title").html("新增短信模板");
		MessageTemplateEditModal.find("[FieldName=_id]").val("-1");
		MessageTemplateEditModal.find("[FieldName=_Title]").val("");
		MessageTemplateEditModal.find("[FieldName=_Content]").val("");
		MessageTemplateEditModal.find("[FieldName=_status]").val("I");
		MessageTemplateEditModal.find("[FieldName=_User_Ins]").val("<%=WebFunction.GetUserName(request)%>");
		MessageTemplateEditModal.find("[FieldName=_Date_Ins]").val(new Date().Format('yyyy-MM-dd HH:mm:ss'));						
		MessageTemplateEditModal.modal("show");
	}

	function Edit(Index)
	{
		var rows = $('#DataGrid').datagrid('getRows');//获得所有行
    var row = rows[Index];//根据index获得其中一行。
		
		var MessageTemplateEditModal=$("#MessageTemplateEditModal");
		MessageTemplateEditModal.find(".modal-title").html("修改短信模板");
		MessageTemplateEditModal.find("[FieldName=_id]").val(row._id);
		MessageTemplateEditModal.find("[FieldName=_Title]").val(row._Title);
		MessageTemplateEditModal.find("[FieldName=_Content]").val(row._Content);
		MessageTemplateEditModal.find("[FieldName=_status]").val("E");
		MessageTemplateEditModal.find("[FieldName=_User_Ins]").val(row._User_Ins);
		MessageTemplateEditModal.find("[FieldName=_Date_Ins]").val(row._Date_Ins);
		MessageTemplateEditModal.find("[FieldName=_User_Lst]").val("<%=WebFunction.GetUserName(request)%>");
		MessageTemplateEditModal.find("[FieldName=_Date_Lst]").val(new Date().Format('yyyy-MM-dd HH:mm:ss'));
						
		MessageTemplateEditModal.modal("show");
	}
	
	function Post()
	{
		var $loadingToast =loadingToast();
		
		var Data={}
		$("#MessageTemplateEditModal [FieldName]").each(function(){
			var FieldName=$(this).attr("FieldName");
			var FieldValue=$(this).val();
			Data["Emt"+FieldName]=FieldValue;
		})
		
		var DataRows=[];	
		DataRows[0]=Data; 
		var json={"DataRows":DataRows};
		

		console.log(json);

		$.post("<%=request.getContextPath()%>/web/visa/ota/system/MessageTemplatePost.json",JSON.stringify(json),function(data){
			//console.log(data);
			$loadingToast.modal("hide");
			if (data.MsgID!=1)
			{
				alert(data.MsgText);
			}
			else
			{
				alert("短信模板保存成功！");
				Query();
				
			}
		},"json");
	}
 </script>
</body>
</html>