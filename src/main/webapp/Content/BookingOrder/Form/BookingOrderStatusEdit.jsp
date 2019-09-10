<%@page import="com.ecity.java.mvc.service.system.SystemService"%>
<%@page import="com.ecity.java.web.WebFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%    
String ID=request.getParameter("ID")==null?"":request.getParameter("ID");
if (ID.equals(""))
{
	WebFunction.GoErrerHtml(request,	response,	"缺少参数（ID）");
	return;
} 

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<jsp:include	page="/head.jsp"/>
		
<title>修改订单状态</title>

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

						
						
</head>
<body>
<div class="input-group" style="width: 100%;padding: 20px;">
	<%
	String[] StatusName=new SystemService().GetBookingOrderStatusName(); 
	for (int i =0;i<StatusName.length;i++)
	{
	%>
	<div style="float:left;padding: 2px;margin:10px 5px;font-size: 14px;" >
		<input type="radio" name="StatusName"  id ="StatusName<%=i%>" value='<%=StatusName[i]%>'>
		<label for="StatusName<%=i%>" class="btn btn-xs btn-default" ><%=StatusName[i]%></label>
	</div>
	<%
	}
	%>
	<div style="clear: both;"></div>
</div>

<div style="margin: 20px">
	<button type="button" class="btn btn-primary btn-xs" onclick="Save()" style="width:100%">保存</button>
</div>	

<script type="text/javascript">
	function Save()
	{
		
		if ($("[name=StatusName]:checked").length==0)
		{
			alert('请选择【订单状态】！');
			return ;
		}
		var StatusName=$("[name=StatusName]:checked").attr("value");
		var data={"EboID":"<%=ID %>","StatusName":StatusName};
		
		//console.log(json);
		
		$.post("<%=request.getContextPath()%>/web/visa/ota/UpdateOrderStatus.json",JSON.stringify(data),function(data){
			//console.log(data);
			if (data.MsgID!=1)
			{					 
					alert(data.MsgText);
			}
			else
			{
				alertLayer('修改成功！',function(){
		  		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		  		parent.layer.close(index); //再执行关闭   
				})
			}
	},"json");
	}
</script>
</body>
</html>