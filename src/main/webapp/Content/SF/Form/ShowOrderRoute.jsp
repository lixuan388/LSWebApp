<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>

<%
String id=request.getParameter("id")==null?"-1":request.getParameter("id");

%>		
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<jsp:include	page="/head.jsp"/>
		
	<link rel="stylesheet" href="/Res/js/layer/layui/css/layui.css"	>
	
	<script src="/Res/js/layer/layui/layui.js"></script>
	
<title>物流信息</title>
</head>
<body>
	<div id ='RouteDiv' style="padding: 20px;">
	<ul class="layui-timeline">

	</ul>
	</div>
	

<script id="timelinedemo" type="text/html">
		<li class="layui-timeline-item">
			<i class="layui-icon layui-timeline-axis">&#xe63f;</i>
			<div class="layui-timeline-content layui-text">
				<h3 class="layui-timeline-title">{{d.accept_time}}</h3>
				<p>{{d.remark}}</p>
				<p>地址：{{d.accept_address}}</p>
			</div>
		</li>
</script>

<script type="text/javascript">
$(function(){
	//query();
	layui.use('laytpl', function(){
		query();
	}); 
})
function query()
{
	var $loadingToast = loadingToast();
	$.ajax({
		url: "<%=request.getContextPath() %>/web/SF/GetSFOrderRoute.json?ID=<%=id%>&d=" + new Date().getTime(),
		type: 'get',
		dataType: 'Json',
		success: function (data) {
			$loadingToast.modal("hide");
//			console.log(data);
			if (data.MsgID==-1)
			{
				$("#RouteDiv").html("无物流记录！");
				
			}
			else
			{
				var laytpl = layui.laytpl;
				
				var timeline = timelinedemo.innerHTML;
				for (i in data.Data)
				{
					laytpl(timeline).render(data.Data[i], function(html){
					  $(".layui-timeline").append(html);
					});
				}
				
			}
		}
	})	
		
}
</script>
</body>
</html>