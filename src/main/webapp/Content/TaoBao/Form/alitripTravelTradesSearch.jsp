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
<div id="loadingToast" style=" display: none1;">
	<div class="weui-mask_transparent"></div>
	<div class="weui-toast">
		<i class="weui-loading weui-icon_toast"></i>
		<p class="weui-toast__content">数据加载中</p>
	</div>
</div>				
<div id="MianDiv"	 style="position: relative;height: 100%;padding: 10px;">

	<div id="alitripTravelTradesSearch" style="position: relative;">
	
		<div>
			<div style="margin-top: 10px;margin-left: 20px;">
				<div class="input-group"	style="width: 500px;float:left;" >
					<span class="input-group-addon">订单状态：</span>
					<select class="form-control" id ="QueryStatus">
						<option value="0" selected>全部</option>
						<option value="1" >等待买家付款</option>
						<option value="2">等待卖家发货</option>
						<option value="3">等待买家确认收货</option>
						<option value="4">交易关闭</option>
						<option value="6">交易成功</option>
						<option value="8">交易关闭</option>	
					</select>
				</div>
				
				<div class="input-group"	style="width: 300px;float:left;margin-left: 10px;;margin-top: 0px;" >
					<span class="input-group-addon">订单日期：</span>
					<input type="text" class="form-control form_datetime" id ="QueryDateFr" style="width: 100px;">
					<span	class="input-group-addon">到</span>
					<input type="text" class="form-control form_datetime" id ="QueryDateTo" style="width: 100px;">
				</div>
				<button type="button" class="btn btn-primary" onclick="alitripTravelTradesSearch_Query();" style="float:left" >查询</button>
				<div style="clear: both;"></div>
			</div>
		
		<div style="margin: 10px 20px;border: 1px solid silver;"></div>
		<div style="height:calc(100vh - 80px);">
			<table class="table table-hover table-striped	DataTable easyui-datagrid" 
				data-options="singleSelect:true,fitColumns:true,method:'get'" id="DataGrid" style="height:100%">
				<thead>				
					<th data-options="field:'OrderID',width: 100,sortable: false,align: 'center',halign: 'center',formatter:formatterOrder">订单号码</th>
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
		<nav aria-label="Page navigation">
			<ul class="pagination" style="margin: 5px;">
				<li>
					<a href="#" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
					</a>
				</li>
				<li>
					<a href="#" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</ul>
		</nav>
		

		
		
		
		<table class="DataTableTemplate" >
			<tbody id="DataTableTemplate" class="DataTableTemplate" >
				<tr class="DataTr" orderID="${OrderID}" style="position: relative;">
					<td >${OrderID}
						<div class="loading" style="position: absolute;top:0px;left:0px;right:0px;bottom:0px;background-color: #9e9e9e33;text-align: center;">
							<i class="weui-loading"></i>
						</div>
					</td>
					<td ><span FieldName="status">&nbsp;</span></td>
					<td ><span FieldName="created_time">&nbsp;</span></td>
					<td ><span FieldName="item_title">&nbsp;</span></td>
					<td style="text-align: right"><span FieldName="total_fee">&nbsp;</span><span>元</span></td>
					<td ><span FieldName="OrderType">&nbsp;</span></td>
					<td	>
						<div><a href="<%=request.getContextPath() %>/taobao/api/alitripTravelTradeQuery.json?OrderID=${OrderID}&U=true&d=<%=request.getSession().getLastAccessedTime()%>" target="_blank">刷新订单数据</a></div>
						<div><a href="<%=request.getContextPath() %>/Content/TaoBao/Form/alitripInfo.jsp?id=${OrderID}&d=<%=request.getSession().getLastAccessedTime()%>" target="_blank">查看订单数据</a></div>
					</td>
				</tr>
			</tbody>
		</table>
		
		
	<script type="text/javascript">
	
	function formatterOrder(val,row)
	{
		return '<div style="position: relative;" orderID="'+row.OrderID+'">'+row.OrderID+'<div class="loading" style="position: absolute;top:0px;left:0px;right:0px;bottom:0px;background-color: #9e9e9e33;text-align: center;">'+
			'<i class="weui-loading"></i>'+
		'</div></div>';
		
	}

	function OpOrder(val,row){
		 
		 return '<div><a href="<%=request.getContextPath() %>/taobao/api/alitripTravelTradeQuery.json?OrderID='+row.OrderID+'&U=true&d=<%=request.getSession().getLastAccessedTime()%>" target="_blank">刷新订单数据</a></div>'+
		'<div><a href="<%=request.getContextPath() %>/Content/TaoBao/Form/alitripInfo.jsp?id='+row.OrderID+'&d=<%=request.getSession().getLastAccessedTime()%>" target="_blank">查看订单数据</a></div>';
		
		
	}
	
	function QueryInfo(OrderID)
	{
		$.ajax({
			url: '<%=request.getContextPath() %>/taobao/api/alitripTravelTradeQuery.json?OrderID='+OrderID+'&d=' + new Date().getTime(),
			type: 'get',
			dataType: 'Json',
			success: function (data) {
				//console.log(data);
				if (data.MsgID==1)
				{
					var first_result=data.Data.alitrip_travel_trade_query_response.first_result;
					

			    //$('#DataGrid').datagrid({data:first_result});
			    
			    var row=$('#DataGrid').datagrid('getRows');
			    //console.log(row);
			    for (index=0;index<row.length;index++)
			    {
			    	if (row[index].OrderID==OrderID)
			    	{
							row[index].status=GetTradesStatus(first_result.status)+"<br>("+first_result.status+")";
							row[index].statusID=first_result.status;
							
							row[index].created_time=first_result.created_time;
							row[index].item_title=first_result.sub_orders.sub_order_info[0].buy_item_info.item_title;
							//if (data.Data.MsgText=='未对照产品ID！')
							//{
							//	row[index].item_title=row[index].item_title+'<br>'+data.Data.alitrip_travel_trade_query_response.first_result.sub_orders.sub_order_info[0].buy_item_info.item_title;
							//}
							//else 
							if (data.Data.MsgText=='无内部产品信息！')
							{
								row[index].item_title=row[index].item_title+'<br>out_sku_id:'+data.Data.out_sku_id;
							}
								
							row[index].total_fee=first_result.sub_orders.sub_order_info[0].total_fee/100;
							row[index].MsgID=data.Data.MsgID;
							if (data.Data.MsgID==0)
							{
								row[index].OrderType="未处理";
							}
							else if (data.Data.MsgID==-1)
							{
								row[index].OrderType=data.Data.MsgText;
							}
							else if (data.Data.MsgID==1)
							{
								row[index].OrderType='<a href="<%=request.getContextPath() %>/Content/BookingOrder/Form/BookingOrderInfo.jsp?ID='+data.Data.OrderID+'&d=<%=request.getSession().getLastAccessedTime()%>" target="_blank">订单明细</a>';
							}
							else
							{
								row[index].OrderType=data.Data.MsgID;
							}
							$('#DataGrid').datagrid('beginEdit',index);
							$('#DataGrid').datagrid('endEdit',index);
			    	}
			    }
				}
				$('[orderID="'+OrderID+'"] .loading').remove();
			}
		})	
		
	}
	function alitripTravelTradesSearch_Query(vCurrentPage)
	{

		var $loadingToast =loadingToast();
		
		var StartDate =$("#QueryDateFr").val();
		var EndDate =$("#QueryDateTo").val();
		var PageSize =20;
		var Status =$("#QueryStatus").val();
		var CurrentPage=(vCurrentPage==undefined)?1:vCurrentPage;
		
		$.ajax({
			url: '<%=request.getContextPath() %>/taobao/api/alitripTravelTradesSearch.json?StartDate='+StartDate+'&EndDate='+EndDate+'&PageSize='+PageSize+'&Status='+Status+'&CurrentPage='+CurrentPage+'&d=' + new Date().getTime(),
			type: 'get',
			dataType: 'Json',
			success: function (data) {
				//console.log(data);
				$loadingToast.modal("hide");
				if (data.error_response)
				{
					
					alert(data.error_response.sub_msg);
					return;
				} 
				else
				{
					//console.log(data.alitrip_travel_trades_search_response.order_string_list.string);
					
					$('.pagination li.pageli').remove();
					if (data.alitrip_travel_trades_search_response.total_orders==0)
					{
						alert("没有对应的记录！")
					}
					else
					{
						var TemplateData=$.map( data.alitrip_travel_trades_search_response.order_string_list.string, function( item ) {
							//console.log(item);
							return {"OrderID":item};
						});
						
						//console.log(TemplateData);
						$('#DataGrid').datagrid({data:TemplateData});
						
						var total_orders=data.alitrip_travel_trades_search_response.total_orders;

						if (CurrentPage>1)
						{
							$('.pagination>li>[aria-label="Previous"]').data('pageno',CurrentPage-1);
						}
						else
						{
							$('.pagination>li>[aria-label="Previous"]').data('pageno',1);
						}
						if (CurrentPage*PageSize>total_orders)
						{
							$('.pagination>li>[aria-label="Next"]').data('pageno',CurrentPage);
						}
						else
						{
							$('.pagination>li>[aria-label="Next"]').data('pageno',CurrentPage+1);
						}
						
						var PageNo=1;
						$('.pagination').find('li:last').before('<li class="pageli PageNo'+PageNo+'"><a href="#" data-pageno='+PageNo+'>'+PageNo+'</a></li>');
						while (total_orders>PageSize)
						{
							PageNo++;
							$('.pagination').find('li:last').before('<li class="pageli PageNo'+PageNo+'" ><a href="#" data-pageno='+PageNo+'>'+PageNo+'</a></li>');
							total_orders=total_orders-PageSize;
						}
						$('.pagination li.pageli.PageNo'+CurrentPage).addClass('active');
						
						for (i in data.alitrip_travel_trades_search_response.order_string_list.string)
						{
							//console.log(i);
							var OrderID=data.alitrip_travel_trades_search_response.order_string_list.string[i];
							QueryInfo(OrderID);
						}
					}
				}
			}
		})	
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
		$('.pagination').on('click','li>a',function(){
			var CurrentPage=$(this).data('pageno');
			alitripTravelTradesSearch_Query(CurrentPage);
		})

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
		var $loadingToast = $('#loadingToast');
		$loadingToast.fadeOut(100);
	})
</script>
</body>
</html>