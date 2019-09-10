<%@page import="java.net.URLDecoder"%>
<%@page import="com.ecity.java.mvc.service.system.SystemService"%>
<%@ page isELIgnored="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	java.util.Date ss = new java.util.Date();	
	java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
	String now = format.format(ss);//这个就是把时间戳经过处理得到期望格式的时间	
	

String	status=request.getParameter("status")==null?"":request.getParameter("status");

status=URLDecoder.decode(status, "UTF-8");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<jsp:include page="/head.jsp" />
<link href="<%=request.getContextPath()%>/res/css/FlexLayout.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/Res/js/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="/Res/js/jquery-easyui/themes/icon.css">
<script type="text/javascript" src="/Res/js/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/Res/js/jquery-easyui/easyui-lang-zh_CN.js"></script>
<title>WebApp</title>
<style type="text/css">
.datagrid-row1 {
  height: 50px;
  text-align: center;
}

div>button {
  margin: 1px;
}
</style>
</head>
<body>
  <div id="MianDiv" class="LayoutMain">
    <div id="BookingOrderQueryDiv" class="LayoutColumn" style="position: relative;">
      <div>
        <div style="margin-top: 10px; margin-left: 20px;">
          <div class="input-group" style="width: 400px; float: left;">
            <span class="input-group-addon">搜索：</span> <input type="text" class="form-control" placeholder="OTA订单号/OTA昵称/联系人姓名/手机" id="QueryText">
          </div>
          <div class="input-group" style="width: 250px; float: left; margin-left: 10px;; margin-top: 0px;">
            <span class="input-group-addon">订单状态：</span> <select class="form-control" id="QueryStatus">
              <option value="" selected>全部</option>
              <%
                              
							String[] StatusName=new SystemService().GetBookingOrderStatusName(); 
							for (int i =0;i<StatusName.length;i++)
							{
              %>
              <option value="<%=StatusName[i]%>"><%=StatusName[i]%></option>
              <%
							}
  						%>
            </select>
          </div>
          <div class="input-group" style="width: 300px; float: left; margin-left: 10px; margin-top: 0px;">
            <span class="input-group-addon">成交日期：</span> <input type="text" class="form-control form_datetime" id="QueryDateFr" style="width: 100px;"> <span class="input-group-addon">到</span>
            <input type="text" class="form-control form_datetime" id="QueryDateTo" style="width: 100px;">
          </div>
          <button type="button" class="btn btn-primary" onclick="BookingOrderQuery_Query();" style="float: left; margin-left: 10px;">查询</button>
          <div style="clear: both;"></div>
        </div>
        <!-- 
			<div style="margin-top: 10px;margin-left: 20px;">
			
				<button type="button" class="btn btn-primary" onclick="" style="float:left;" >同步更新OTA支付订单</button>
				<button type="button" class="btn btn-primary" onclick="" style="float:left;margin-left: 20px;">批量认领订单</button>
			
				<div style="clear: both;"></div>
			</div>
			 -->
        <div style="margin: 10px 20px; border: 1px solid silver;"></div>
      </div>
      <div style="overflow: auto; height: 100%;">
        <table class="table tableflow table-hover table-striped	DataTable easyui-datagrid" id="DataGrid" style="overflow: auto; height: 100%;"
          data-options="singleSelect:true,fitColumns:true,method:'get',fit:false,nowrap:false"
        >
          <thead>
            <tr>
              <th data-options="field:'Index',width: 50,sortable: false,align: 'center',halign: 'center'">序号</th>
              <th data-options="field:'ebo_SourceName',width: 100,sortable: false,align: 'center',halign: 'center'">OTA来源</th>
              <th data-options="field:'ebo_SourceOrderNo',width: 150,sortable: false,align: 'center',halign: 'center'">OTA订单号</th>
              <th data-options="field:'ebo_StatusType',width: 100,sortable: false,align: 'center',halign: 'center'">操作</th>
              <th data-options="field:'ebo_SaleName',width: 80,sortable: false,align: 'center',halign: 'center'">销售客服</th>
              <th data-options="field:'ebo_SourceGuest',width: 100,sortable: false,align: 'center',halign: 'center',formatter:OpenSourceGuest">OTA昵称</th>
              <th data-options="field:'ebo_PayDate',width: 120,sortable: false,align: 'center',halign: 'center'">成交日期</th>
              <th data-options="field:'ebo_PackageName',width: 200,sortable: false,align: 'center',halign: 'center'">成交商品</th>
              <th data-options="field:'ebo_id_Eva',width: 100,sortable: false,align: 'center',halign: 'center',formatter:OpenVisaAreaName">送签领区</th>
              <th data-options="field:'ebo_PayMoney',width: 80,sortable: false,align: 'center',halign: 'center'">金额</th>
              <th data-options="field:'ebo_LinkMan',width: 100,sortable: false,align: 'center',halign: 'center'">联系人</th>
              <th data-options="field:'ebo_Phone',width: 100,sortable: false,align: 'center',halign: 'center'">手机</th>
              <th data-options="field:'OP',width:100,align:'right',formatter:OpenOrder"></th>
            </tr>
          </thead>
          <tbody>
          </tbody>
        </table>
      </div>
      <script id="DetilTableTemplate" type="text/html">
				<tr onclick="OpenBookingOrder(this);" style="cursor: pointer;" data-id="${ebo_id}">
					<td>${Index}</td>
					<td>${ebo_SourceName}</td>
					<td>${ebo_SourceOrderNo}</td>
					<td>${ebo_StatusType}</td>
					<td>${ebo_SourceGuest}</td>
					<td>${ebo_PayDate}</td>
					<td>${ebo_PackageName}</td>
					<td>${ebo_PackageVisa}</td>
					<td>${ebo_PayMoney}</td>
					<td>${ebo_LinkMan}</td>
					<td>${ebo_Phone}</td>
				</tr>
		</script>
      <script type="text/javascript"> 
	$(function () {
		$('.form_datetime').datetimepicker({
			weekStart: 0, //一周从哪一天开始
			todayBtn:	1, //
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2, 
			forceParse: 0,
			showMeridian: 1,
			language:'zh-CN',
				format:'yyyy-mm-dd',
			startDate:'2018-01-01'
		});
		//$('.form_datetime').val('<%=now%>');
		
		<%
			if (!status.equals(""))
			{
				%>
				$('#QueryStatus').val('<%=status%>');
				BookingOrderQuery_Query();
				
				<%
			}
		%>
	})
	
	function BookingOrderQuery_Query()
	{
		var $loadingToast = loadingToast();
		var json={
			"QueryText":$('#QueryText').val(),
			"QueryDateFr":$('#QueryDateFr').val(),
			"QueryDateTo":$('#QueryDateTo').val(),
			"QueryStatus":$('#QueryStatus').val(),
		}
		$.post("<%=request.getContextPath()%>/Content/BookingOrder/BookingOrderQuery.json",JSON.stringify(json),function(data){
			$loadingToast.modal("hide");
			if (data.MsgID != 1)
			{ 
				alert(data.MsgText);
				return;
			} 
			else
			{
				//console.log(data.Data);
				$('#DataGrid').datagrid({data:data.Data});
			}
		},"json");
			
			/*
		$.ajax({
			url: '<%=request.getContextPath() %>/Content/BookingOrder/BookingOrderQuery.json?d=' + new Date().getTime(),
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
					console.log(data.Data);
					$('#DataGrid').datagrid({data:data.Data});
					// $("#BookingOrderQueryDiv .DataTable>tbody").html("");
					//$("#BookingOrderQueryDiv #DetilTableTemplate").tmpl(data.Data).appendTo($("#BookingOrderQueryDiv .DataTable>tbody"));
				}
			}
		})	
		*/
	}
	function OpenBookingOrder2(t)
	{
		var id=$(t).data("id");
		window.open('<%=request.getContextPath() %>/Content/BookingOrder/Form/BookingOrderInfo.jsp?ID='+id);
	}
	function OpenBookingOrder(data)
	{
		var id=data.ebo_id;
		window.open('<%=request.getContextPath() %>/Content/BookingOrder/Form/BookingOrderInfo.jsp?ID='+id);
	}
	function OpenBookingOrder3(id)
	{
		window.open('<%=request.getContextPath() %>/Content/BookingOrder/Form/BookingOrderInfo.jsp?ID='+id);
	}

  function OpenOrder(val,row){
    return '<div><button type="button" class="btn btn-primary btn-xs" onclick="OpenBookingOrder3(\''+row.ebo_id+'\')" style="width:100%">查看</button></div>'+
    '<div><button type="button" class="btn btn-danger btn-xs" onclick="EditOrderStatus(\''+row.ebo_id+'\')" style="width:100%">修改状态</button></div>';
  }

  function OpenVisaAreaName(val,row){
    var Ebo_id_Eva=row.ebo_id_Eva;
    //console.log(Ebo_id_Eva);
    var name=VisaAreaName[Ebo_id_Eva]==undefined?"":VisaAreaName[Ebo_id_Eva];
    return '<div>'+name+'</div>';
  }


	function OpenSourceGuest(val,row){
		return '<div>'+row.ebo_SourceGuest+'</div>'+
		'<div><a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid='+row.ebo_SourceGuest+'&site=cntaobao&s=1&charset=utf-8" ><img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid='+row.ebo_SourceGuest+'&site=cntaobao&s=1&charset=utf-8" alt="点击这里给我发消息" /></a><div>'
		;
	}

	function EditOrderStatus(id)
	{
		OpenWindowLayer('修改订单状态','<%=request.getContextPath() %>/Content/BookingOrder/Form/BookingOrderStatusEdit.jsp?ID='
                        + id, function() {
                      BookingOrderQuery_Query();
                    }, {
                      "width" : "500px"
                    });
              }
            </script>
    </div>
    <div style="display: none;">$('#DataGrid').datagrid({ singleSelect: true, //onClickRow: onClickRow, //onDblClickRow:onDblClickRow , //toolbar: '#ShowCustomerList2DataGridTool', method:'get',
      fitColumns:'true', columns: [ [ {field: 'Index',title: '序号',width: 50,sortable: false,align: 'center',halign: 'center',editor:'textbox'}, {field: 'ebo_SourceName',title: 'OTA来源',width:
      100,align: 'center',halign: 'center',sortable: false,editor:'textbox'}, {field: 'ebo_SourceOrderNo',title: 'OTA订单号',width: 150,align: 'center',halign: 'center',sortable: false,editor:'textbox'},
      { field: 'ebo_StatusType', title: '操作', width: 100, align: 'right', halign: 'center', sortable: false, editor:'textbox'}, { field: 'ebo_SourceGuest', title: 'OTA昵称', width: 100, align: 'right',
      halign: 'center', sortable: false, editor:'textbox'}, { field: 'ebo_PayDate', title: '成交日期', width: 120, align: 'right', halign: 'center', sortable: false, editor:'textbox'}, { field:
      'ebo_PackageName', title: '成交商品', width: 200, align: 'right', halign: 'center', sortable: false, editor:'textbox'}, { field: 'ebo_PackageVisa', title: '送签领区', width: 100, align: 'right', halign:
      'center', sortable: false, editor:'textbox'}, { field: 'ebo_PayMoney', title: '金额', width: 80, align: 'right', halign: 'center', sortable: false, editor:'textbox'}, { field: 'ebo_LinkMan',
      title: '联系人', width: 100, align: 'right', halign: 'center', sortable: false, editor:'textbox'}, { field: 'ebo_Phone', title: '手机', width: 100, align: 'right', halign: 'center', sortable: false,
      editor:'textbox'} ] ] });</div>
  </div>
  <script type="text/javascript">
      function onDblClickRow(rowIndex, rowData) {
        console.log(rowData);
        OpenBookingOrder(rowData);
        //		if (endEditing('#'+this.id)){
        //			$('#'+this.id).datagrid('selectRow', rowIndex)
        //						.datagrid('beginEdit', rowIndex);
        //			SetDataGridEditIndex('#'+this.id,rowIndex);
        //		} else {
        //			$('#'+this.id).datagrid('selectRow', GetDataGridEditIndex('#'+this.id));
        //		}
      }
      var VisaAreaName;
      $(function() {
        $('#DataGrid').datagrid();

        VisaAreaName = layui.data('Json').VisaAreaName;

      })
    </script>
</body>
</html>