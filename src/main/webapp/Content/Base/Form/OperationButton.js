// <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
layui.config({
  base : '<%=request.getContextPath() %>/layuiadmin/' // 静态资源所在路径
  ,
  ContextPath : '<%=request.getContextPath() %>' //
  ,
  version : '<%=version.Version%>'//
}).extend({
  index : 'lib/index' // 主入口模块
}).use([ 'index', 'table', 'form', 'layedit', 'admin' ], function() {
  var $ = layui.$, admin = layui.admin, setter = layui.setter, table = layui.table, form = layui.form, layer = layui.layer;
  
  
  var PageOption={width:'400px',height:'400px'};
  
  $body = $('body');
  
  table.render({
    elem : '#OperationButtonTable',
    url : '<%=request.getContextPath() %>/web/system/OperationButtonQuery.json',
    limit : 100,
    cols : [ [ {
      field : '_id',
      width : 60,
      align : 'center',
      title : 'ID'
    }, {
      field : '_name',
      width : 200,
      align : 'center',
      title : '名称',
      edit : 'text'
    }, {
      field : '_ButtonName',
      align : 'center',
      title : '控件名称',
      edit : 'text'
    }, {
      field : '_status',
      width : 70,
      align : 'center',
      title : '状态',
      edit : 'text'
    }, {
      field : '_index',
      width : 60,
      align : 'center',
      title : '排序',
      edit : 'text'
    }
    ,{ width : 100,align:'center', toolbar: '#barDemo'}] ],
    page : false,
    response : {
      statusCode : 1
    // 重新规定成功的状态码为 200，table 组件默认为 0
    },
    parseData : function(res) { // 将原始数据解析成 table 组件所规定的数据
      return {
        "code" : res.MsgID, // 解析接口状态
        "msg" : res.MsgText, // 解析提示文本
        "count" : res.Data.length, // 解析数据长度
        "data" : res.Data
      // 解析数据列表
      };
    }
  });
  var events =  {
    InsertData:function(othis){
      //console.log('InsertData');
      OpenWindowLayer("新增操作按键","<%=request.getContextPath() %>/Content/Base/Form/OperationButtonEdit.jsp",function(){
        table.reload("OperationButtonTable");
      },PageOption)
      
    }
  }
  //点击事件
  $body.on('click', '*[layadmin-event]', function(){
    var othis = $(this)
    
    ,attrEvent = othis.attr('layadmin-event');
    //console.log($(this));
    events[attrEvent] && events[attrEvent].call(this, othis);
  });
  
  //监听工具条
  table.on('tool(OperationButtonTable)', function(obj){
    var data = obj.data;
    console.log('tool(OperationButtonTable)');
    if(obj.event === 'edit'){
      OpenWindowLayer("新增操作按键","<%=request.getContextPath() %>/Content/Base/Form/OperationButtonEdit.jsp?ID="+data._id,function(){
        table.reload("OperationButtonTable");
      },PageOption)
    }

  });


});