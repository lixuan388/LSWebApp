//<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
layui.use('table', function(){
  var table = layui.table;

  //监听工具条
  table.on('tool(demo)', function(obj){
    var data = obj.data;
    if(obj.event === 'del'){
//      layer.confirm('真的删除行么', function(index){
//        obj.del();
//        layer.close(index);
//      });
    } else if(obj.event === 'edit'){
//      layer.alert('编辑行：<br>'+ JSON.stringify(data))
    }
  });
  
  table.render({

    elem: '#VisaTypeTable'
    	,url:'<%=request.getContextPath() %>/web/visa/base/VisaType.json'
  	,cols: [[
      {field:'_id',  align:'center',title:'ID'}
      ,{field:'_Name', align:'center', title:'名称'}
      ,{field:'_index', align:'center', title:'排序'}
      //,{ align:'center', toolbar: '#barDemo'}
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
//    getCheckData: function(){ //获取选中数据
//      var checkStatus = table.checkStatus('idTest')
//      ,data = checkStatus.data;
//      layer.alert(JSON.stringify(data));
//    }
//    ,getCheckLength: function(){ //获取选中数目
//      var checkStatus = table.checkStatus('idTest')
//      ,data = checkStatus.data;
//      layer.msg('选中了：'+ data.length + ' 个');
//    }
//    ,isAll: function(){ //验证是否全选
//      var checkStatus = table.checkStatus('idTest');
//      layer.msg(checkStatus.isAll ? '全选': '未全选')
//    }
  };
  
  $('.demoTable .layui-btn').on('click', function(){
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });
});