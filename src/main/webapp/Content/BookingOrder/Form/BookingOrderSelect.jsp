<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


  <script type="text/html" id="BookingOrderSelectDiv">
  <div id='BookingOrderSelectDiv' >
    <table id="BookingOrderSelectDataGrid" lay-filter="BookingOrderSelectDataGrid">
    </table>

    <div><button class="layui-btn selectBtn" style="width:100%">确定</button></div>
  </div>
  </script>

  <script type="text/html" id="BookingOrderSelectSearchDiv">
  <div id='BookingOrderSelectDiv' >
    <div class='layui-form' style="margin-top: 5px;padding: 0 10px;">
              <div class="layui-form-item">
                <label class="layui-form-label">搜索</label>
                <div class="layui-input-block">
                  <input type="text" autocomplete="off" placeholder="OTA订单号/OTA昵称/联系人姓名/手机 " class="layui-input" id="QueryText" style="width: calc(100% - 70px); display: inline-block;">
                  <button type="button" class="layui-btn layui-btn-primary BookingOrderSelectSearch" >查询</button>
                </div>
              </div>
    </div>
    <table id="BookingOrderSelectDataGrid" lay-filter="BookingOrderSelectDataGrid">
    </table>

    <div><button class="layui-btn selectBtn" style="width:100%">确定</button></div>
  </div>
  </script>

  <script type="text/html" id="SourceGuest">
    <div>{{d.ebo_SourceGuest}}</div>
  </script>
  <script type="text/html" id="LinkMan">
    <div>{{d.ebo_LinkMan}}</div>
    <div>{{d.ebo_Phone}} </div>
  </script>

  <script type="text/html" id="CheckBox">
    <div><input type="radio" name='CheckBookingOrder' OrderID='{{d.ebo_SourceOrderNo}}'></div>
  </script>


  <script type="text/html" id="VisaAreaName">
    {{#var Ebo_id_Eva=d.ebo_id_Eva;}}
    {{#var name=VisaAreaName[Ebo_id_Eva]==undefined?"":VisaAreaName[Ebo_id_Eva];}}
    <div>{{name}}</div>
  </script>

<script type="text/javascript">

var VisaAreaName=[];

layui.define(['table'], function(exports){

  var   table = layui.table,$body=$('body');

  VisaAreaName=layui.data(WebConfig.tableName+'.VisaAreaName.Json').json;
  

  var layerOpenIndex=0;
  
  var DoAfterQuery=null;
  
  function Search(title,doAfterQuery){

    DoAfterQuery=doAfterQuery;

    layerOpenIndex=layer.open({
      type: 1,
      title:title,
      shadeClose:true,
      closeBtn:0,
      area:['900px','100%'],
      content: $('#BookingOrderSelectSearchDiv').html() //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
    });
    
    table.render({
      elem: '#BookingOrderSelectDataGrid',
      cols: [
        [{
          field:'checkbox',
          width: 30,
          templet: '#CheckBox',
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
        }
        ]
      ],
      page: false,

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
      height: 'full-130',
      size: 'sm'
    });
    table.on('row(BookingOrderSelectDataGrid)', function(obj){
      console.log(obj.tr) //得到当前行元素对象
      console.log(obj.data) //得到当前行数据
      //obj.del(); //删除当前行
      //obj.update(fields) //修改当前行数据
      $('[OrderID='+obj.data.ebo_SourceOrderNo+']').prop("checked", true);
      layui.form.render()
    });
  }
  
  function Query(QueryText,doAfterQuery){
    
    LoadingShow();
    DoAfterQuery=doAfterQuery;
    var json={'QueryText':QueryText,'QueryBind':'F'};
    console.log(json);
    $.post( WebConfig.ContextPath+ '/Content/BookingOrder/BookingOrderQuery.json',JSON.stringify(json),function(data,status){

      
      LoadingHide();
      console.log(data);
      if (data.MsgID!=1){
        layer.alert(data.MsgText);
      }
      else{
        if (data.Data.length==1){
          console.log(data.Data);
          if (DoAfterQuery){
            DoAfterQuery(data.Data[0].ebo_SourceOrderNo);
            return;
          }
        }
        else{
          console.log('show grid');

          layerOpenIndex=layer.open({
            type: 1,
            shadeClose:true,
            closeBtn:0,
            area:['900px','100%'],
            content: $('#BookingOrderSelectDiv').html() //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
          });
          
          table.render({
            elem: '#BookingOrderSelectDataGrid',
            data:data.Data,
            cols: [
              [{
                field:'checkbox',
                width: 30,
                templet: '#CheckBox',
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
              }
              ]
            ],
            page: false,

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
            height: 'full-95',
            size: 'sm'
          });
          table.on('row(BookingOrderSelectDataGrid)', function(obj){
            console.log(obj.tr) //得到当前行元素对象
            console.log(obj.data) //得到当前行数据
            //obj.del(); //删除当前行
            //obj.update(fields) //修改当前行数据
            $('[OrderID='+obj.data.ebo_SourceOrderNo+']').prop("checked", true);
            layui.form.render()
          });
          
        }
      }
    }, "json");
  }
  
  function DoCheck(){

    var check=$('#BookingOrderSelectDiv [name=CheckBookingOrder]:checked');
    console.log(check);
    if (check.length==0){
      layer.alert('请选择订单记录！')
      return;
    }
    var OrderID=check.attr('OrderID');
    
    console.log(OrderID);
    layer.close(layerOpenIndex);

    if (DoAfterQuery){
      DoAfterQuery(OrderID);
      return;
    }
    
  }

  //点击事件
  $body.on('click', '#BookingOrderSelectDiv .selectBtn', function(){
    var othis = $(this);
    DoCheck();
  });


  //点击事件
  $body.on('click', '#BookingOrderSelectDiv .BookingOrderSelectSearch', function(){
    var othis = $(this);

    var json={'QueryText':$('#QueryText').val()};
    LoadingShow();
    $.post( WebConfig.ContextPath+ '/Content/BookingOrder/BookingOrderQuery.json',JSON.stringify(json),function(data,status){

      LoadingHide();
      table.render({
        elem: '#BookingOrderSelectDataGrid',
        data:data.Data,
        cols: [
          [{
            field:'checkbox',
            width: 30,
            templet: '#CheckBox',
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
          }
          ]
        ],
        page: false,

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
        height: 'full-130',
        size: 'sm'
      });
    });
  });

  
  
  
  exports('BookingOrderSelect', {
    Query: Query,
    Search:Search
  });
  
  
})
</script>