<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<jsp:include page="/head.jsp"/>
<title>Insert title here</title>
</head>
<body>
<button onclick="DeviceInit();">连接(DeviceInit)</button>
<button onclick="Scan();">扫描(Scan)</button>
<div id ="MsgDiv">

</div>

<script type="text/javascript">



function Scan()
{
	$.ajax({
		url: 'http://127.0.0.1:58001/?Scan',
		type: 'get',
		dataType: 'Json',
		success: function (data) {
			console.log(data);
			if (data.ErrCode=1)
			{
				
			}
			$("#MsgDiv").html("<div>ErrCode:"+data.ErrCode+"</div><div>ErrMsg:"+data.ErrMsg+"</div>")
			
		}
	})	
}
function DeviceInit()
{
	$.ajax({
		url: 'http://127.0.0.1:58001/?DeviceInit',
		type: 'get',
		dataType: 'Json',
		success: function (data) {
			console.log(data);
			if (data.ErrCode=1)
			{
				
			}
			$("#MsgDiv").html("<div>ErrCode:"+data.ErrCode+"</div><div>ErrMsg:"+data.ErrMsg+"</div>");
		},
		error:function(Req,err,e){

			console.log(Req);
			console.log(err);
			console.log(e);
			alert("error");
		}
	})	
}

	</script>

</body>
</html>