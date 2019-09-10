<%@page import="com.ecity.java.web.SF.api.SFApi"%>
<%@page import="com.ecity.java.web.system.Config"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<jsp:include page="/head.jsp"/>
	<script type="text/javascript" src="/Res/js/layer/layer/layer.js"></script>
<title>顺风参数配置</title>
<style type="text/css">
	.input-group > .input-group-addon
	{
		width:300px;
		text-align: left;
	}
</style>
</head>
<body>

<%
	String tomcatPath=System.getProperty("catalina.home");
	String ConfigPath=tomcatPath+"\\conf\\webConfig.properties";
	System.out.println(ConfigPath);

	Config c = new Config(ConfigPath);
	c.load();
	// TODO Auto-generated catch block
	String [] valueList=new String []{"ls.SF.ClientCode","ls.SF.CheckWord","ls.SF.CustID","ls.SF.J_Province","ls.SF.J_City",
				"ls.SF.J_County","ls.SF.J_Company","ls.SF.J_Contact","ls.SF.J_Tel","ls.SF.J_Address","ls.SF.ReqURL","ls.SF.WayBillPrintURL"};
%>

<div style="margin: 50px;">
	<div class="form-group" >
		<% 
			for (int i =0;i<valueList.length;i++)
			{
			%>
			<div class="input-group">
				<span class="input-group-addon" id="basic-addon1"><%=valueList[i]%></span>
				<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="<%=valueList[i]%>" value="<%=c.getProperty(valueList[i])%>">
			</div>
			<%
			}
		%>
			
	</div>
	<div style="margin: 10px;">
		<a style="width:100%  " class="btn btn-primary btn-sm" href="javascript:void(0);" onclick="Save()"  role="button" >保存</a>
	</div>
</div>
<%
	
%>

<script type="text/javascript">
	console.log("ClientCode:<%=SFApi.ClientCode%>");
	console.log("CheckWord:<%=SFApi.CheckWord%>");
	console.log("CustID:<%=SFApi.CustID%>");


	function Save()
	{
		var Data=[];
		$("[FieldName]").each(function(index){
			console.log("index:"+index);
			console.log("Name:"+$(this).attr("FieldName"));
			console.log("Value:"+$(this).val());
			var v={'name':$(this).attr("FieldName"),'value':$(this).val()};
			Data[index]=v;
		})
		console.log(Data);
    $.post("<%=request.getContextPath()%>/web/SF/SetConfig.json",JSON.stringify(Data),function(data){
        console.log(data); 
        alertLayer(data.MsgText,function(){
        	window.location.reload();
        })
        
    },"json");
		
		
	}

</script>

</body>
</html>