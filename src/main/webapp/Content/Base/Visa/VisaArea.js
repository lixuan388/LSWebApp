//<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
layui.use('table', function(){
  var table = layui.table;
  
  var PageOption={width:'400px',height:'260px'};
  //监听工具条
  table.on('tool(VisaAreaTable)', function(obj){
    var data = obj.data;
    if(obj.event === 'del'){
//      layer.confirm('真的删除行么', function(index){
//        obj.del();
//        layer.close(index);
//      });
    } else if(obj.event === 'edit'){
    	
    	 OpenWindowLayer("新增领区","<%=request.getContextPath() %>/Content/Base/Visa/VisaAreaInsert.jsp?ID="+data._id,function(){
 		  	table.reload("VisaAreaTable");
 		  },PageOption)
//      layer.alert('编辑行：<br>'+ JSON.stringify(data))
    }
  });
  
  table.render({

    elem: '#VisaAreaTable'
    	,url:'<%=request.getContextPath() %>/web/visa/base/VisaArea.json'
  	,cols: [[
      {field:'_id',  align:'center',title:'ID'}
      ,{field:'_Name', align:'center', title:'名称'}
      ,{field:'_index', align:'center', title:'排序'}
      ,{ align:'center', toolbar: '#barDemo'}
    ]]
    ,page: true
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
  
  
  var $ = layui.$, active = {
  		InsertData: function(){ //获取选中数据
  		  OpenWindowLayer("新增领区","<%=request.getContextPath() %>/Content/Base/Visa/VisaAreaInsert.jsp?ID=-1",function(){
  		  	table.reload("VisaAreaTable");
  		  },PageOption)
    }
  };
  
  $('.demoTable .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
});