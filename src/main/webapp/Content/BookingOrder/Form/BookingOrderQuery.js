layui.extend({
  index: 'lib/index' // 主入口模块
}).define(['index',
'form',
'element',
'laydate',
'table'], function () {
  var $ = layui.$,
  form = layui.form,
  admin = layui.admin,
  view= layui.view,
  setter = layui.setter,
  table = layui.table,
  laydate = layui.laydate;
  
  $body = $('body');
  
  var StatusName=layui.data(layuiTableName+'.Json').BookingOrderStatusName;
  //console.log(StatusName);
  for (i in StatusName)
  {
    $('#QueryStatus').append('<option value="'+StatusName[i]+'">'+StatusName[i]+'</option>');
  }
  form.render('select');
  VisaAreaName=layui.data(setter.tableName+'.VisaAreaName.Json').json;
  console.log('VisaAreaName2');
  console.log(VisaAreaName);
  
  
  // 日期
  laydate.render({
    elem: '#QueryDateFr'
  });
  laydate.render({
    elem: '#QueryDateTo'
  });
  
  table.render({
    elem: '#DataGrid',
    url: setter.ContextPath
    + '/Content/BookingOrder/BookingOrderQuery.json',
    where: {
      'QueryText': QueryText,
      'QueryDateFr': QueryDateFr,
      'QueryDateTo': QueryDateTo,
      'QueryStatus': QueryStatus
    },
    method: 'post',
    contentType: 'application/json;charset=UTF-8',
    cols: [
      [{
        type:'checkbox',
        width: 30,
        align: 'center'
      },{
        field: 'Index',
        width: 40,
        sortable: false,
        align: 'center',
        title: '序号'
      },
      {
        field: 'ebo_SourceName',
        width: 60,
        sortable: false,
        align: 'center',
        title: 'OTA来源'
      },
      {
        field: 'ebo_SourceOrderNo',
        width: 140,
        sortable: false,
        align: 'center',
        templet: '#SourceOrderNo',
        title: 'OTA订单号'
      },
      {
        field: 'ebo_StatusType',
        width: 60,
        sortable: false,
        align: 'center',
        title: '操作'
      },
      {
        field: 'ebo_SaleName',
        width: 60,
        sortable: false,
        align: 'center',
        title: '销售客服'
      },
      {
        field: 'ebo_SourceGuest',
        width: 100,
        sortable: false,
        align: 'center',
        templet: '#SourceGuest',
        // formatter : OpenSourceGuest,
        title: 'OTA昵称'
      },
      {
        field: 'ebo_PayDate',
        width: 80,
        sortable: false,
        align: 'center',
        title: '成交日期'
      },
      {
        field: 'ebo_PackageName',
        //width: 200,
        sortable: false,
        align: 'center',
        title: '成交商品'
      },
      {
        field: 'ebo_id_Eva',
        width: 60,
        sortable: false,
        align: 'center',
        templet : '#VisaAreaName',
        title: '送签领区'
      },
      {
        field: 'ebo_PayMoney',
        width: 80,
        sortable: false,
        align: 'center',
        title: '金额'
      },
      {
        field: 'ebo_LinkMan',
        width: 90,
        sortable: false,
        align: 'center',

        templet : '#LinkMan',
        title: '联系人'
      },
      {
        field: 'OP',
        width: 70,
        align: 'right',
        toolbar: '#barDemo' ,
        title: ''
      }
      ]
    ],
    page: false,
    done:function(res, curr, count){
      view.removeLoad();
      $('.TRADE_CLOSED').parent().parent().parent().addClass('TRADE_CLOSED');
    },
    response: {
      statusCode: 1      // 重新规定成功的状态码为 200，table 组件默认为 0
    },
    parseData: function (res) { // 将原始数据解析成 table 组件所规定的数据
      return {
        'code': res.MsgID, // 解析接口状态
        'msg': res.MsgText, // 解析提示文本
        'count': res.Data==undefined?0:res.Data.length, // 解析数据长度
        'data': res.Data        // 解析数据列表
      };
    },
    height: 'full-160',
    size: 'sm'
  });
  var events =  {
      Query:function(othis){
        view.loading($('#BookingOrderQueryDiv'));
        var json={
            "QueryText":$('#QueryText').val(),
            "QueryDateFr":$('#QueryDateFr').val(),
            "QueryDateTo":$('#QueryDateTo').val(),
            "QueryStatus":$('#QueryStatus').val(),
          }
        table.reload('DataGrid',{
            where: json
        })
      }
      ,Binding:function(othis){
        var checkStatus = table.checkStatus('DataGrid')
        ,data = checkStatus.data;
        if (data.length==0)
        {
          layer.alert('请勾选需要认领的记录！');        
          return ;
        }
        var json=[];
        for (i in data)
        {
          var d={};
          d.OrderID=data[i].ebo_id;
          json[i]=d;
        }
        console.log(json);
        admin.req({
          url: setter.ContextPath+'/web/visa/ota/UpdateOrderSalename.json'
          ,type: 'post'
          ,data:JSON.stringify(json)
          ,success: function(res){
            layer.alert('<div>批量认领完成！</div>',function(index){
              //do something
              table.reload('DataGrid',{})
              layer.close(index);
            });           
          }
        });
      }
      
  }
  //点击事件
  $body.on('click', '*[layadmin-event]', function(){
    var othis = $(this)
    
    ,attrEvent = othis.attr('layadmin-event');
    //console.log($(this));
    events[attrEvent] && events[attrEvent].call(this, othis);
  });

  
  $('#QueryText').on('keydown', function (event) {
    console.log(event.keyCode);
    if (event.keyCode == 13) {
      events.Query();
      return false
    }
});
  
  
  
  //监听工具条
  table.on('tool(DataGrid)', function(obj){
    var data = obj.data;
    if(obj.event === 'open'){
      window.open(setter.ContextPath+'/Content/BookingOrder/Form/BookingOrderInfo.jsp?ID='+data.ebo_id);
    } else if(obj.event === 'edit'){
      OpenWindowLayer('修改订单状态',setter.ContextPath+'/Content/BookingOrder/Form/BookingOrderStatusEdit.jsp?ID='+ data.ebo_id, function() {
        table.reload('DataGrid',{})
      }, 
      {"width" : "500px"});    
    }
  });
})
