<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN"	style="height: 100%;">
<head>
	<jsp:include page="/head.jsp"/>
	<title>WebApp</title>
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
	



</div>
<script type="text/javascript">
	
	$(function(){
		var $loadingToast = $('#loadingToast');
		$loadingToast.fadeOut(100);
	})
</script>
</body>
</html>