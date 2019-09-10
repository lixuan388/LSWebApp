<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String InitialScale=request.getParameter("InitialScale")==null?"1":(String)request.getParameter("InitialScale");
//String webPath="http://ls.17ecity.cc:18888";
String webPath="";
%>       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
    <meta name="viewport" id="webviewport" content="width=device-width,initial-scale=<%=InitialScale %>,user-scalable=0"> 


	  <link rel="stylesheet" href="<%=webPath%>/Res/css/jquery-ui.css">
	   <script src="<%=webPath%>/Res/js/jquery.min.js"></script>
	  <script src="<%=webPath%>/Res/js/jquery-ui.js"></script>
	  <script src="<%=webPath%>/Res/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=webPath%>/Res/js/jquery.tmpl.js"></script>
    <script type="text/javascript" src="<%=webPath%>/Res/js/date.js"></script>
    
    
      
  <script src="<%=webPath%>/Res/js/bootstrap-datetimepicker.min.js"></script>
  <script type="text/javascript" src="<%=webPath%>/Res/js/bootstrap-datetimepicker.zh-CN.js"></script>
  <link href="<%=webPath%>/Res/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    

  <link href="<%=webPath%>/Res/css/bootstrap.min.css" rel="stylesheet">
  
	<link href="<%=request.getContextPath() %>/res/css/Default.css" rel="stylesheet">
	
    <script type="text/javascript" src="/Res/js/ECityAlert.js"></script>
    
    


<title>Insert title here</title>
</head>
<body>
    	<div style="margin: 10px;">
				<div class="input-group">
					<span class="input-group-addon" id="basic-addon1">开卡日期</span>
					<input type="text" class="form-control form_datetime" placeholder="" aria-describedby="basic-addon1"FieldName="amc_CreateDate">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" onclick="EditCreateDateClose();">取消</button>
					<button type="button" class="btn btn-primary" onclick="EditCreateDatePost();" >保存</button>
				</div>
			</div>


<script type="text/javascript">

function EditCreateDatePost()
{
	alert('修改成功！',function(){ EditCreateDateClose();});
}
function EditCreateDateClose()
{
		var iJquery=window.parent.jQuery;
		iJquery("#"+window.name).modal("hide");
}



</script>

</body>
</html>