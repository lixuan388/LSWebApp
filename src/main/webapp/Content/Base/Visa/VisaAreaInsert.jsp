<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String	ID=request.getParameter("ID")==null?"":request.getParameter("ID");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<jsp:include page="/layuihead.jsp"/>
<title></title>
</head>
<body>
<div style="padding: 20px;"> 
 
	<form class="layui-form" action="" lay-filter="table">
	  <div class="layui-form-item">
	    <label class="layui-form-label">领区</label>
	    <div class="layui-input-block">
	      <input type="text" name="_Name"  autocomplete="off" placeholder="请输入领区名称 " class="layui-input" FieldName="_Name">
	    </div>
	  </div>
	  <div class="layui-form-item">
	    <label class="layui-form-label">排序</label>
	    <div class="layui-input-block">
	      <input type="text" name="_index"  autocomplete="off" class="layui-input" FieldName="_index">
	    </div>
	  </div>
	  <input type="hidden" name="_id" FieldName="_id">
	  <input type="hidden" name="_status" FieldName="_status">
	  <input type="hidden" name="_Code" FieldName="_Code">
	  <input type="hidden" name="_id" FieldName="_id">
	
	</form>  
	<div>
		<div style="width: calc(50% - 5px );padding: 10px;display: inline-block;"><button style="width:100%;" class="layui-btn" data-type="PostData">保存</button></div>
		<div style="width: calc(50% - 5px );padding: 10px;display: inline-block;"><button style="width:100%;" class="layui-btn layui-btn-danger" data-type="CloseWindows">关闭</button></div>
	</div>
</div>

<script>
layui.config({
  base: '<%=request.getContextPath() %>/layuiadmin/' //静态资源所在路径
}).extend({
  index: 'lib/index' //主入口模块
}).use(['index','form'], function(){
  var form = layui.form
  ,admin=layui.admin;
  
 
  //表单初始赋值
  form.val('table', {
    "_id": "-1" // "name": "value"
    ,"_Name": ""
    ,"_index": 100
    ,"_Code": ""
		,"_status": "I"
  })
  var active={

  	CloseWindows:function()
	  {
	  	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	  	parent.layer.close(index); //再执行关闭   
	  }
	  ,Query:function()
	  {
	  	admin.req({
	      url: '<%=request.getContextPath() %>/web/visa/base/VisaAreaByID.json'
	      ,type: 'get'
	      ,data: {
	        ID: <%=ID%>
	      }
	      ,success: function(res){
	        if (res.MsgID=='-1')
	        {
						if (<%=ID%>!=-1)
						{
		        	layer.alert(res.MsgText,  function(index){
		        	  //do something        	  
		        	  layer.close(index);
		        	  active.CloseWindows();
		        	});
						}
	        }
	        else{
	          form.val('table', {
	            "_id": res.Data._id// "name": "value"
	            ,"_Name": res.Data._Name
	            ,"_index": res.Data._index
	            ,"_Code": res.Data._Code
	        		,"_status": res.Data._status
	          })
	        }
	      }
	    });
	  }
	  
	  ,PostData:function()
	  {
			var $loadingToast =loadingToast();
	  	var Data={}
	  	$("form  [FieldName]").each(function(){
	  	    var FieldName='Eva'+$(this).attr("FieldName");
	  	    var FieldValue=$(this).val();
	  	    Data[FieldName]=FieldValue;
	  	  })
	  	  
	  	  var DataRows=[];  
	  	  DataRows[0]=Data; 
	  	  var json={"DataRows":DataRows};
	  	  
	    	admin.req({
	        url: '<%=request.getContextPath() %>/web/visa/base/VisaAreaPost.json'
	        ,type: 'post'
	        ,data: JSON.stringify(json)
	        ,success: function(res){

	    			$loadingToast.modal("hide");
	          if (res.MsgID=='-1')
	          {
	 	        	layer.alert(res.MsgText,  function(index){
	 	        	  //do something        	  
	 	        	  layer.close(index);
	 	        	});
	          }
	          else{
	 	        	layer.alert('保存成功！',  function(index){
	 	        	  //do something        	  
	 	        		layer.close(index);
	 	        		active.CloseWindows();
	 	        	});
	          }
	        }
	      });
	
	  }
  }
  
  $('.layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
  
  
  
  active.Query();

});
</script>

</body>
</html>