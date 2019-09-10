<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%

	java.util.Date ss = new java.util.Date();	
	java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
	String now = format.format(ss);//这个就是把时间戳经过处理得到期望格式的时间	
%>
<!DOCTYPE html>
<html lang="zh-CN"	style="height: 100%;">
<head>
	<jsp:include page="/head.jsp"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/res/js/alitrip.js"></script>
	
	<link rel="stylesheet" type="text/css" href="/Res/js/jquery-easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="/Res/js/jquery-easyui/themes/icon.css">
	<script type="text/javascript" src="/Res/js/jquery-easyui/jquery.easyui.min.js"></script>
	
	<script type="text/javascript" src="/Res/js/jquery-easyui/easyui-lang-zh_CN.js"></script>
	
	<title>WebApp</title>
	
	<style type="text/css">
		.DataTable>tbody>tr>td
		{
			font-size: 14px;
		}
	</style>
</head> 
<body style="height: 100%;">		
<div id="MianDiv"	 style="position: relative;height: 100%;padding: 10px;">

	<div id="alitripTravelTradesSearch" style="position: relative;">
	
		<div>
			<div style="margin-top: 10px;margin-left: 20px;">
				<div class="input-group"	style="width: 300px;float:left;" >
					<span class="input-group-addon">订单号：</span>
					<input type="text" class="form-control " id ="QueryOrderID" >
				</div>
				
				<div class="input-group"	style="width: 300px;float:left;margin-left: 10px;;margin-top: 0px;" >
					<span class="input-group-addon">订单状态：</span>					
					<select class="form-control" id ="QueryStatus">
						<option value="" selected>全部</option>
						<option value="未对照产品ID！" >未对照产品ID！</option>
						<option value="无内部产品信息！">无内部产品信息！</option>
						<option value="订单信息保存成功！">订单信息保存成功！</option>
					</select>
				</div>
				
				<div class="input-group"	style="width: 300px;float:left;margin-left: 10px;;margin-top: 0px;" >
					<span class="input-group-addon">订单日期：</span>
					<input type="text" class="form-control form_datetime" id ="QueryDateFr" style="width: 100px;">
					<span	class="input-group-addon">到</span>
					<input type="text" class="form-control form_datetime" id ="QueryDateTo" style="width: 100px;">
				</div>
				<button type="button" class="btn btn-primary" onclick="alitripTravelTradesSearch_Query();" style="float:left;margin-left: 10px;;margin-top: 0px;" >查询</button>
				<div style="clear: both;"></div>
			</div>
		
		<div style="margin: 10px 20px;border: 1px solid silver;"></div>
		<div style="height:calc(100vh - 80px);">
			<table class="table table-hover table-striped	DataTable easyui-datagrid" 
				data-options="singleSelect:true,fitColumns:true,method:'get'" id="DataGrid" style="height:100%">
				<thead>				
					<th data-options="field:'OrderID2',width: 100,sortable: false,align: 'center',halign: 'center',formatter:formatterOrder">订单号码</th>
					<th data-options="field:'status',width: 100,sortable: false,align: 'center',halign: 'center'"  >主订单状态</th>
					<th data-options="field:'created_time',width: 100,sortable: false,align: 'center',halign: 'center'"  >订单日期</th>
					<th data-options="field:'item_title',width: 200,sortable: false,align: 'center',halign: 'center'"  >商品名称</th>
					<th data-options="field:'total_fee',width: 80,sortable: false,align: 'right',halign: 'center'" >金额</th>
					<th data-options="field:'OrderType',width: 60,sortable: false,align: 'center',halign: 'center'"  >&nbsp;</th>
					<th data-options="field:'OrderType2',width: 60,sortable: false,align: 'center',halign: 'center' ,formatter:OpOrder" >&nbsp;</th>
					<!--  <th>&nbsp;</th>-->
				</thead>
				<tbody>
				
				</tbody>
				<tfoot>
				
				</tfoot>
			</table>
		</div>
		

		
		
	<script type="text/javascript">
	
	function formatterOrder(val,row)
	{
		return '<div style="position: relative;" orderID="'+row.OrderID2+'">'+row.OrderID2+'</div>';
		
	}

	function OpOrder(val,row){
		 
		 return '<div><a href="<%=request.getContextPath() %>/taobao/api/alitripTravelTradeQuery.json?OrderID='+row.OrderID2+'&U=true&d=<%=request.getSession().getLastAccessedTime()%>" target="_blank">刷新订单数据</a></div>'+
		'<div><a href="<%=request.getContextPath() %>/Content/TaoBao/Form/alitripInfo.jsp?id='+row.OrderID2+'&d=<%=request.getSession().getLastAccessedTime()%>" target="_blank">查看订单数据</a></div>';
		
		
	}
	
	function alitripTravelTradesSearch_Query()
	{

		var $loadingToast =loadingToast();
		var OrderID=$("#QueryOrderID").val();
		var StartDate =$("#QueryDateFr").val();
		var EndDate =$("#QueryDateTo").val();
		var Status =$("#QueryStatus").val();
		
		 var json={
				"OrderID":OrderID,
				"StartDate":StartDate,
				"EndDate":EndDate,
				"Status":Status,
				
		}
		$loadingToast.fadeIn(100);
		$.post("<%=request.getContextPath() %>/taobao/api/alitripTravelTradesSearch2.json",JSON.stringify(json),function(data){

			$loadingToast.modal("hide");
			 if (data.MsgID != 1)
			 { 
					alert(data.error_response.sub_msg);
				 return;
			 } 
			 else
			 {
			    //$('#DataGrid').datagrid({data:first_result});
			    var row=data.Data;
			    //console.log(row);
			    for (index=0;index<row.length;index++)
			    {
						var first_result=row[index].alitrip_travel_trade_query_response.first_result;
						
						row[index].OrderID2=first_result.order_id_string;
						row[index].status=GetTradesStatus(first_result.status)+"<br>("+first_result.status+")";
						row[index].statusID=first_result.status;
						
						row[index].created_time=first_result.created_time;
						row[index].item_title=first_result.sub_orders.sub_order_info[0].buy_item_info.item_title;
						//if (data.Data.MsgText=='未对照产品ID！')
						//{
						//	row[index].item_title=row[index].item_title+'<br>'+data.Data.alitrip_travel_trade_query_response.first_result.sub_orders.sub_order_info[0].buy_item_info.item_title;
						//}
						//else 
						if (row[index].MsgText=='无内部产品信息！')
						{
							row[index].item_title=row[index].item_title+'<br>out_sku_id:'+row[index].out_sku_id;
						}
							
						row[index].total_fee=first_result.sub_orders.sub_order_info[0].total_fee/100;

						if (row[index].MsgID==0)
						{
							row[index].OrderType="未处理";
						}
						else if (row[index].MsgID==-1)
						{
							row[index].OrderType=row[index].MsgText;
						}
						else if (row[index].MsgID==1)
						{
							row[index].OrderType='<a href="<%=request.getContextPath() %>/Content/BookingOrder/Form/BookingOrderInfo.jsp?ID='+row[index].OrderID+'&d=<%=request.getSession().getLastAccessedTime()%>" target="_blank">订单明细</a>';
						}
						else
						{
							row[index].OrderType=row[index].MsgID;
						}
			    }

					$('#DataGrid').datagrid({data:row});
			 }
		},"json");
		
	}
	 function OpenBookingOrder(id)
	 {
		 window.open('<%=request.getContextPath() %>/Content/BookingOrder/Form/BookingOrderInfo.jsp?ID='+id);
		 
	 }
	 
	
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
		$('.form_datetime').val('<%=now%>');
		$('#DataGrid').datagrid({
				rowStyler: function(index, row) {
					//此处可以添加条件
					if ((row.statusID=="TRADE_CLOSED_BY_TAOBAO")
							|| (row.statusID=="TRADE_CLOSED" )
							|| (row.statusID=="TRADE_CLOSED_BY_TAOBAO" ))
					{
						return 'background-color:#e0e0e0;color: #8a8a8a;';
					}
					else if (row.MsgID==0)
					{
						return 'background-color: #a1dbff;';
					}
					else if (row.MsgID==-1)
					{
						return 'background-color: #ffcaca;';
					}
						
				}
		});
		
		alitripTravelTradesSearch_Query();
	})
	
	</script>
		
	
	</div>
	</div>
<script type="text/javascript">
	
	$(function(){

	})
</script>
</body>
</html>