<%@page import="com.ecity.java.mvc.dao.uilts.SQLUilts"%>
<%@page import="com.ecity.java.web.ls.Content.BookingOrder.alitripTravelTradeInfoClass"%>
<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
String id=request.getParameter("id")==null?"-1":request.getParameter("id");
alitripTravelTradeInfoClass json=new alitripTravelTradeInfoClass(id);
String OrderID=SQLUilts.GetMaxIDByDatePrefix("SF");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">

	<jsp:include page="/head.jsp"/>
	
<style type="text/css">

  [type=radio]+label
    {
      display: block;
    }
    [type=radio]:checked+label
    {
      background-color: blue;
      Color:white;
    }
    [type=radio]
    {
      display: none;
    }
    .weui-form-preview__item
    {
      margin-top: 10px;
    }
</style>
  
<title>生成快递单</title>
</head>
<body>

<div style="margin: 50px;">
	<div class="form-group" >
    <div class="input-group">
      <span class="input-group-addon" id="basic-addon1">快递单号</span>
      <input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="Orderid" value="<%=OrderID%>">
    </div>
    <div class="input-group">
      <span class="input-group-addon" id="basic-addon1">快递方式</span>
      <select class="form-control" FieldName="payMethod">
        <option value='1' selected>寄付月结</option>
        <option value='2'>顺风到付</option>
      </select>
    </div>
		<div class="input-group">
			<span class="input-group-addon" id="basic-addon1">省</span>
			<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="Province" value="">
		</div>
		<div class="input-group">
			<span class="input-group-addon" id="basic-addon1">市</span>
			<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="City" value="">
		</div>
		<div class="input-group">
			<span class="input-group-addon" id="basic-addon1">区</span>
			<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="County" value="">
		</div>
		<div class="input-group">
			<span class="input-group-addon" id="basic-addon1">公司</span>
			<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="Company" value="">
		</div>
		<div class="input-group">
			<span class="input-group-addon" id="basic-addon1">联系人</span>
			<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="Contact" value="">
		</div>
		<div class="input-group">
			<span class="input-group-addon" id="basic-addon1">电话</span>
			<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="Tel" value="">
		</div>
		<div class="input-group">
			<span class="input-group-addon" id="basic-addon1">地址</span>
			<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="Address" value="">
		</div>
		<div class="input-group">
			<span class="input-group-addon" id="basic-addon1">货物</span>
			<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="Cargo" value="资料">
		</div>
		
		<input type="hidden" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="SourceOrderNo" value="<%=id %>">
		
		
		
	</div>
	<div style="margin: 10px;">
		<a style="width:100%" id="SaveBtn" class="btn btn-primary btn-sm" href="javascript:void(0);" onclick="Create()"  role="button" >保存</a>
	</div>
</div>

	<script type="text/javascript">
		
		$(function(){
			var $loadingToast =loadingToast();
			var alitripData=<%=json.OpenTable()%>;
			var contactorData=alitripData.Data.alitrip_travel_trade_query_response.first_result.sub_orders.sub_order_info[0].contactor;
			
			$("[FieldName=Province]").val(contactorData.post_province);
			$("[FieldName=City]").val(contactorData.post_city);
			$("[FieldName=County]").val(contactorData.post_area);
			$("[FieldName=Company]").val("");
			$("[FieldName=Contact]").val(contactorData.name);
			$("[FieldName=Tel]").val(contactorData.phone);
			var post_address=contactorData.post_address;
			post_address=post_address.replace("("+contactorData.post_province+")","");
			post_address=post_address.replace("("+contactorData.post_city+")","");
			post_address=post_address.replace("("+contactorData.post_area+")","");
			
			$("[FieldName=Address]").val(post_address);

			$loadingToast.modal("hide");
		})
		
		function Create()
		{

			var $loadingToast =loadingToast();
			var Data={};
			$("[FieldName]").each(function(){
				var n=$(this).attr("FieldName");
				var v=$(this).val();
				Data[n]=v;
			})
			
			console.log(Data);
	    $.post("<%=request.getContextPath()%>/web/SF/CreateOrderInfo.json",JSON.stringify(Data),function(data){
	  			$loadingToast.modal("hide");
	  			if (data.MsgID==1){
	  				$("#SaveBtn").remove();
	  				PrintWayBillImage(data.FileName);
	  			}
	  			else{
		        alertLayer(data.MsgText,function(){
		        	//window.location.reload();
		        })
	  			}
	    },"json");
			
		}

		function PrintWayBillImage(path)
		{
		  var $loadingToast = loadingToast();
			$.ajax({
				url: 'http://127.0.0.1:58001/?WayBillPrint&path=/SFWayBillImage/'+path,
				type: 'get',
				dataType: 'Json',
				success: function (data) {
			    $loadingToast.modal("hide");
//					console.log(data);
					if (data.ErrCode=1)
					{
						//$(".ScanButton").removeAttr("disabled");

						alertLayer("打印完成",function(){
							closeWindows();
		        })
					}
					else
					{
						alert(data.ErrMsg);
					}
				},
				error:function(Req,err,e){
					$loadingToast.modal("hide");
					alert("打印失败");
				}
			})
		}

		
	</script>	
</body>
</html>