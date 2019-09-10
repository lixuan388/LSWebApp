<%@page import="com.ecity.java.web.ls.Parameter.Json.SupplierInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.CountryJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%

String itemid=request.getParameter("itemid")==null?"":request.getParameter("itemid");
%>
<!DOCTYPE html>
<html lang="zh-CN"	style="height: 100%;">
<head>
	<jsp:include page="/layuihead.jsp"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/res/js/alitrip.js"></script>
	<title>WebApp</title>
	<style type="text/css">
	
	
	</style>
</head> 
<body style="height: 100%;">		
<div id="MianDiv"	 style="position: relative;height: 100%;padding: 10px;">
		<form class="layui-form" action="" lay-filter="table" >
			<div class="layui-form-item">
				<label class="layui-form-label">Item_ID</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" placeholder="" name="item_id" value="<%=itemid%>">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">内部产品编码</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input" placeholder="" name="out_sku_id" value="">
				</div>
			</div>
			<div class="">
				<button style="width:calc(50% - 10px)" type="button" class="layui-btn layui-btn-primary" onclick="closeWindows()">取消</button>
				<button style="width:calc(50% - 10px)" type="button" class="layui-btn layui-btn-normal"  lay-submit=""  lay-filter="Submit">保存</button>
			</div>
		</form>
</div>


<script src="/Res/js/layer/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
function closeWindows()
{
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	parent.layer.close(index); //再执行关闭   
}

layui.config({
  base: '<%=request.getContextPath() %>/layuiadmin/' //静态资源所在路径
}).extend({
  index: 'lib/index' //主入口模块
}).use(['index','form'], function(){
  var form = layui.form
  ,$=layui.$
  ,layer = layui.layer
  ,admin=layui.admin;
  


	
  //监听提交
  form.on('submit(Submit)', function(data){
  	
  	var $loadingToast =loadingToast();
  	
		var json={
				"item_id":$("[name=item_id]").val(),
				"out_sku_id":$("[name=out_sku_id]").val(),
				};
		admin.req({
      url: '<%=request.getContextPath()%>/web/taobao/AlitripTravelTradesUpdateSUKID.json'
      ,type: 'post'
      ,data: JSON.stringify(json)
      ,success: function(res){
	    	$loadingToast.modal("hide");
				if (res.MsgID!='1')
				{
					alertLayer("<div style='font-weight: 800;font-size: 18px;'>数据保存失败！</div><div style='color:red;'>"+res.MsgText+'</div>',null);
				}
				else
				{
					alertLayer("产品信息保存成功！",function(){
						closeWindows();
					});
				}
      }
    });
		
    return false;
  });
});

</script>
</body>
</html>
