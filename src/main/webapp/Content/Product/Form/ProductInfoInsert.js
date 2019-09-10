//<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
layui.config({
  base: '<%=request.getContextPath() %>/layuiadmin/' //静态资源所在路径
}).extend({
  index: 'lib/index' //主入口模块
}).use(['index','form'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,admin=layui.admin;
  
  //监听指定开关
  form.on('radio(ProductTypeName)', function(data){
  	ChangeProductType();
  });
  

	function ChangeProductType()
	{
		//console.log($(t).val());
		var id=$('[name=_Type]:checked').val();
		$("#ProductInfoInsertModal .SelectVisaProductBtn").attr("ProductType",id);
	}
	
	
  //监听提交
  form.on('submit(ProductInfo_InsertSubmit)', function(data){
  	
  	var $loadingToast =loadingToast();
  	
  	console.log(data.field);
  	var Data={};
  	for (i in data.field)
  	{
  		Data['Epi'+i]=data.field[i]
  	}
  	
  	
  	
		var DataRows=[];	
		DataRows[0]=Data; 
		var json={"DataRows":DataRows};
		admin.req({
      url: '<%=request.getContextPath()%>/Content/Product/ProductInfoPost.json'
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
  
	
	
	function LoadData(){
		var data=<%=p.toJson().toString()%>;
		//console.log(data);
		form.val('table', data)
		  
		$("[FieldName=_status]").val("E");
		$("[FieldName=_User_Lst]").val('<%=request.getSession().getAttribute("UserName")%>');	
		$("[FieldName=_Date_Lst]").val(new Date().Format("yyyy-MM-dd HH:mm:ss"));	
		var id=$('[name=_Type]:checked').val();
		$("#ProductInfoInsertModal .SelectVisaProductBtn").attr("ProductType",id);
	}
	LoadData();
	
});