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

  table.render({
    elem : '#OrderStatusSyncTable',
    url : '<%=request.getContextPath() %>/web/visa/ota/OrderStatusSyncQuery.json',
    limit : 100,
    height : 'full-100',
    cols : [ [ {
      type : 'checkbox'
    }, {
      field : 'ava_statustype',
      width : 100,
      align : 'center',
      title : '签证状态',
      templet : '#avaStatustypeTpl'
    }, {
      field : 'eos_code',
      width : 200,
      align : 'center',
      title : '子单状态',
      templet : '#EosCodeTpl'
    }, {
      field : 'eos_mainName',
      width : 200,
      align : 'center',
      title : '主单状态',
      templet : '#eosMainNameTpl'
    }, {
      field : 'ebon_id',
      width : 190,
      align : 'center',
      title : '子单ID',
      templet : '#ebonIDTpl'
    }, {
      field : 'ebon_name',
      align : 'center',
      title : '客人姓名'
    }, {
      field : 'ebo_packagename',
      align : 'center',
      title : '产品名称'
    }, {
      field : 'ebo_sourceorderno',
      width : 220,
      align : 'center',
      title : '主单号',
      templet : '#eboSourceordernoTpl'
    } ] ],
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

  table.on('tool(OrderStatusSyncTable)', function(obj) {
    var data = obj.data;
    if (obj.event === 'OpenOrder') {
      var id = data.ebo_id;
      window.open('<%=request.getContextPath() %>/Content/BookingOrder/Form/BookingOrderInfo.jsp?ID=' + id);
    }
  });

  var $ = layui.$, active = {
    getCheckData : function() { // 获取选中数据
      var checkStatus = table.checkStatus('OrderStatusSyncTable'), data = checkStatus.data;
      if (data.length == 0) {
        layer.alert('请勾选需要推送的记录！');
        return;

      }
      var json = [];
      for (i in data) {
        var d = {};
        d.alitripCode = data[i].eos_code;
        d.GuestName = data[i].ebon_name;
        d.ebonID = data[i].ebon_id;
        d.eboID = data[i].ebo_id;
        d.ApplyID = data[i].ebon_applyid;
        d.OrderCode = data[i].ebo_sourceorderno;
        d.currentApplyStatus = data[i].ebon_currentApplyStatus;
        json[i] = d;
      }
      admin.req({
        url : setter.ContextPath + '/web/visa/ota/OrderStatusSync.json',
        type : 'post',
        data : JSON.stringify(json),
        success : function(res) {
          console.log(res)
          var div = "";
          for (i in res) {
            d = res[i];
            if (d.MsgID != 1) {
              div = div + "<div>【" + d.GuestName + "】状态推送失败！</div>";
              div = div + "<div>失败原因：" + d.MsgTest + "</div>";
            }
          }
          layer.alert('<div>状态推送完成！</div>' + div, function(index) {
            // do something
            active.QueryData();
            layer.close(index);
          });
        }
      });

    },
    QueryData : function() {
      table.reload('OrderStatusSyncTable');
    }
  };

  $('#OrderStatusSyncDiv .layui-btn').on('click', function() {
    var type = $(this).data('type');
    active[type] ? active[type].call(this) : '';
  });

//	
// //监听单元格编辑
// table.on('edit(OrderStatusTable)', function(obj){
// var value = obj.value //得到修改后的值
// ,data = obj.data //得到所在行所有键值
// ,field = obj.field; //得到字段
// var $loadingToast =loadingToast();
// var json={'id':data._id,'value':value,'type':'ERP'};
// console.log(json);
// admin.req({
// url: setter.ContextPath+'/web/system/OrderStatusUpdate.json'
// ,type: 'post'
// ,data:JSON.stringify(json)
// ,success: function(res){
//
// $loadingToast.modal("hide");
// if (res.MsgID!=1)
// {
// layer.alert(res.MsgText, function(index){
// //do something
// layer.close(index);
// });
// }
// else
// {
//					
// }
// }
// });
//		
// });

//  
// //监听主单状态操作
// form.on('radio(MainName)', function(obj){
// // console.log(obj.othis);
// // console.log(obj.elem);
// var keyid=$(obj.elem).data('keyid');
// // console.log('keyid:'+keyid);
//
// var $loadingToast =loadingToast();
// var json={'id':keyid,'value':obj.value,'type':'Main'};
// admin.req({
// url: setter.ContextPath+'/web/system/OrderStatusUpdate.json'
// ,type: 'post'
// ,data:JSON.stringify(json)
// ,success: function(res){
//
//  			$loadingToast.modal("hide");
//				if (res.MsgID!=1)
//				{
//        	layer.alert(res.MsgText,  function(index){
//        	  //do something        	  
//        	  layer.close(index);
//        	});
//				}
//				else
//				{
//					
//				}
//			}
//		});
//		//layer.tips(this.value + ' ' + this.name + '：'+ obj.elem.checked, obj.othis);
//	});

});