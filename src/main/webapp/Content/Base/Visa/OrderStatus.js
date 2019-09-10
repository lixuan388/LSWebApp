//<%@ page language="java" contentType="text/html; charset=UTF-8"		pageEncoding="UTF-8"%>
	layui.config({
		base: '<%=request.getContextPath() %>/layuiadmin/' //静态资源所在路径
		,ContextPath: '<%=request.getContextPath() %>' //
		,version: '<%=version.Version%>'//
	}).extend({
		index: 'lib/index' //主入口模块
	}).use(['index','table','form','layedit','admin'], function(){
	var $ = layui.$
	,admin=layui.admin
	,setter=layui.setter
	,table = layui.table
	,form = layui.form
	,layer = layui.layer;
	

	
	table.render({
		elem: '#OrderStatusTable'
		,url:'<%=request.getContextPath() %>/web/visa/base/OrderStatus.json'
		,limit: 100
		,cols: [[
			{field:'_index',width:60, align:'center', title:'排序'}
			,{field:'_Code',width:65, align:'center', title:'编码'}
			,{field:'_Name',width:165, align:'center', title:'OTA状态'}
			,{field:'_ERPName',width:75, align:'center', title:'签证状态', edit: 'text'}
			,{field:'_state', align:'center', title:'流程', edit: 'text'}
			,{ field:'_MainName',width:550,align:'center', toolbar: '#barDemo', title:'主单状态'}
		]]
		,page: false
		,response: {
			statusCode: 1 //重新规定成功的状态码为 200，table 组件默认为 0
		}
		,parseData: function(res){ //将原始数据解析成 table 组件所规定的数据
				return {
					"code": res.MsgID, //解析接口状态
					"msg": res.MsgText, //解析提示文本
					"count": res.Data.length, //解析数据长度
					"data": res.Data //解析数据列表
				};
			}
	});
	
  //监听单元格编辑
  table.on('edit(OrderStatusTable)', function(obj){
    var value = obj.value //得到修改后的值
    ,data = obj.data //得到所在行所有键值
    ,field = obj.field; //得到字段
    var $loadingToast =loadingToast();
		var json={'id':data._id,'value':value,'type':field};
		console.log(json);
		admin.req({
			url: setter.ContextPath+'/web/system/OrderStatusUpdate.json'
			,type: 'post'
			,data:JSON.stringify(json)
			,success: function(res){

  			$loadingToast.modal("hide");
				if (res.MsgID!=1)
				{
        	layer.alert(res.MsgText,  function(index){
        	  //do something        	  
        	  layer.close(index);
        	});
				}
				else
				{
					
				}
			}
		});
		
  });
  
  
	//监听主单状态操作
	form.on('radio(MainName)', function(obj){
//		console.log(obj.othis);
//		console.log(obj.elem);
		var keyid=$(obj.elem).data('keyid');
//		console.log('keyid:'+keyid);

		var $loadingToast =loadingToast();
		var json={'id':keyid,'value':obj.value,'type':'Main'};
		admin.req({
			url: setter.ContextPath+'/web/system/OrderStatusUpdate.json'
			,type: 'post'
			,data:JSON.stringify(json)
			,success: function(res){

  			$loadingToast.modal("hide");
				if (res.MsgID!=1)
				{
        	layer.alert(res.MsgText,  function(index){
        	  //do something        	  
        	  layer.close(index);
        	});
				}
				else
				{
					
				}
			}
		});
		//layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
	});
	
});