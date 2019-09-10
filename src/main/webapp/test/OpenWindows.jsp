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
    
    
<script type="text/javascript">
function GetParentBody(w)
{
	if (w!=w.parent)
	{
		return GetParentBody(w.parent)
	}
	else
	{
		return $("body",w.document);
	}
}



function OpenWindows2(href,title,onClose)
{
	var OpenModal=$("	<div class=\"modal\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"myModalLabel\" style=\"background-color: #ccccccb3;\"> \r\n" + 
			"		<div class=\"modal-dialog\" role=\"document\" style=\"width: calc( 100% - 60px);height:calc( 100% - 60px);margin-left: 30px;margin-right: 30px;margin-top: 30px;\">\r\n" + 
			"			<div class=\"modal-content\" style=\"width: 100%;height:100%;\">\r\n" + 
			"				<div class=\"modal-header\">\r\n" + 
			"					<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\r\n" + 
			"					<h4 class=\"modal-title\">"+title+"</h4>\r\n" + 
			"				</div>\r\n" + 
			"				<div class=\"modal-body\" style=\"width:100%;height:calc(100% - 60px);overflow: hidden;padding: 0px;\">\r\n" + 
			"					<iframe src=\""+href+"\" scrolling=\"auto\" frameborder=\"0\" width=\"100%\" height=\"100%\"></iframe>\r\n" + 
			"				</div>\r\n" + 
			"			</div> \r\n" + 
			"		</div> \r\n" + 
			"	</div>");
//	$(OpenModal).find("iframe").attr("src",href)

	var Body=GetParentBody(window.parent);
	$(Body).append(OpenModal);
	$(OpenModal).on('hidden.bs.modal', function (e) {
	  console.log(e);
	  $(OpenModal).remove();
	  if (onClose==Function){onClose();}
	})
	.modal({
		keyboard: false,
		backdrop:false
	})
	.modal("show");
}

function doClose()
{
	console.log("doClose()");	
	alert("doClose");
}





function alert2(Text,onClose)
{
	var AlertConfirm=$("<div class=\"modal \"  tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"myModalLabel\" style=\"background-color: #ccccccb3;z-index: 6000;\">\r\n" + 
	"          <div class=\"modal-dialog\" role=\"document\" style=\"max-width: 360px;margin-left: auto;margin-right: auto; height: calc(100% - 60px);padding-top: 0px;\">\r\n" + 
	"            <div class=\"modal-content\" >\r\n" + 
	"\r\n" + 
	"              <div class=\"modal-body\" style=\"min-height: 50px\" >\r\n" + 
	"                <span class=\"AlertConfirmText\">"+Text+"</span>\r\n" + 
	"              </div>\r\n" + 
	"              <div class=\"modal-footer\" style=\"padding: 5px;\">\r\n" + 
	"                <button type=\"button\" class=\"btn btn-default btn-xs\"  data-dismiss=\"modal\">确定</button>\r\n" + 
	"              </div>\r\n" + 
	"            </div>\r\n" + 
	"          </div>\r\n" + 
	"        </div>  ");
	var Body=GetParentBody(window.parent);
	$(Body).append(AlertConfirm);
	$(AlertConfirm).on('hidden.bs.modal', function (e) {
	  console.log(e);
	  $(AlertConfirm).remove();
	  if (onClose){onClose();}
	})
	.modal({
		keyboard: false,
		backdrop:false
	})
	.modal("show");
	var contentHeight=$(AlertConfirm).find(".modal-content").height();
	var h =(contentHeight) /2+60;
	//console.log("contentHeight:"+contentHeight);
	//console.log(h);
	$(AlertConfirm).find(".modal-dialog").css("padding-top","calc(50vh - "+h+"px)");
}

function loadingToast(text)
{
	var content=text?text:"数据加载中"
	var loading=$('<div id="loadingToast" style=" display: none;">'+
									'<div class="weui-mask_transparent"></div>'+
									'<div class="weui-toast">'+
										'<i class="weui-loading weui-icon_toast"></i>'+
										'<p class="weui-toast__content">'+content+'</p>'+
									'</div>'+
								'</div>');
	var Body=GetParentBody(window.parent);
	$(Body).append(loading);
	$(loading).on('hidden.bs.modal', function (e) {
		console.log(e);
		$(loading).remove();
	})
	.modal({
		keyboard: false,
		backdrop:false
	})
	.modal("show");
	return loading;
}
</script>

<script type="text/javascript">
var testLoad
function showload()
{
	testLoad=loadingToast('定时器');
	//setTimeout("alert('对不起, 要你久候')", 3000 )
	setTimeout("closeLoad(testLoad)", 3000);
}

function closeLoad(t)
{
	$(t).modal("hide");
}




function AlitripTravelVisaApplicantUpdate(id)
{
	OpenWindows('<%=request.getContextPath()%>/test/OpenWindowsChild.jsp','test',function(){alert("after close");});
}
function showparent()
{
	console.log(window.parent);
	console.log(window);
	console.log(window==window.parent);
	var body=GetParentBody(window.parent);
	//var p=window.parent;
	//var msg=$(p).find("#MsgDiv");
	var msg=body.find("#MsgDiv");

	console.log(msg);
	msg.append("<div>123</div>");
}
function GetParentBody(w)
{
	console.log(w);
	console.log(w.parent);
	if (w!=w.parent)
	{
		return GetParentBody(w.parent)
	}
	else
	{

		console.log("return :");
		console.log(w);
		return $("body",w.document);
	}
}

function Addiframe()
{
	$("#iframe").append('<iframe src="<%=request.getContextPath() %>/test/OpenWindows.jsp?d=<%=request.getSession().getLastAccessedTime()%>" scrolling="auto" frameborder="0" width="100%" height="100%"></iframe>')
}



</script>

<title>Insert title here</title>
</head>
<body>

<div>
	<button	type="button"	class="btn	btn-default"	onclick="AlitripTravelVisaApplicantUpdate('011924807')">更新申请信信息</button>
</div>

<div>
	<button	type="button"	class="btn	btn-default"	onclick="alert('011924807011924807<br>011924807')">alert</button>
</div>

<div>
	<button	type="button"	class="btn	btn-default"	onclick="alert2('011924807011924807<br>011924807',function(){alert('after close');})">alert2doClose</button>
</div>
<div>
	<button	type="button"	class="btn	btn-default"	onclick="alert2('011924807011924807<br>011924807')">alert2</button>
</div>
<div>
	<button	type="button"	class="btn	btn-default"	onclick="showparent(this)">GetParent</button>
</div>
<div>
	<button	type="button"	class="btn	btn-default"	onclick="showload()">loadingToast</button>
</div>
<div>
	<button	type="button"	class="btn	btn-default"	onclick="Addiframe()">Addiframe</button>
</div>


<div style="height:100px">
	<div id="loadingToast" style=" display: none;">
		<div class="weui-mask_transparent"></div>
		<div class="weui-toast">
			<i class="weui-loading weui-icon_toast"></i>
			<p class="weui-toast__content">数据加载中</p>
		</div>
	</div>
</div>
<div id="MsgDiv"  style="height: 100px;border: 1px solid;;background-color: #e7e7e7">
	
</div>

<div id="iframe" style="height: 500px;border: 1px solid;">
	
</div>




</body>
</html>