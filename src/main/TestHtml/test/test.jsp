<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<jsp:include page="/head.jsp"/>
	
	<script src="<%=request.getContextPath() %>/res/js/bootstrap-datetimepicker.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/res/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <link href="<%=request.getContextPath() %>/res/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
	
<title>Insert title here</title>
</head>
<body>
	<div class="input-group">
		<span class="input-group-addon" id="basic-addon1">开卡日期1</span>
		<input type="text" value="" id="CreateDate" class=" form-control form_datetime " onchange="CreateDateChange()" data-date-format="yyyy-mm-dd">
	</div>
	<div class="input-group">
		<span class="input-group-addon" id="basic-addon1">开卡日期2</span>
		<input type="text" value="" id="CreateDate2" class=" form-control form_datetime "  data-date-format="yyyy-mm-dd">
	</div>


<script type="text/javascript">
$(function () {
	$('.form_datetime').datetimepicker({
        weekStart: 0, //一周从哪一天开始
        todayBtn:  1, //
        autoclose: 1,
        todayHighlight: 1,
        startView: 2,
        minView: 2, 
        forceParse: 0,
        showMeridian: 1,
        language:'zh-CN',
        startDate:'2017-01-01'
    });
    $('#CreateDate').val(new Date().Format('yyyy-MM-dd'));       
})

function CreateDateChange()
{
	var CreateDate=$("#CreateDate").val();
	var sTime=new Date(CreateDate).getTime()+1000*60*60*24*365;
	$("#CreateDate2").val(new Date(sTime).Format('yyyy-MM-dd'));
} 
</script>
</body>
</html>