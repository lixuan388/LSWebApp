// <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
layui.config({
  base : '<%=request.getContextPath() %>/layuiadmin/' // 静态资源所在路径
  ,
  ContextPath : '<%=request.getContextPath() %>' //
  ,
  version : '<%=version.Version%>'//
}).extend({
  index : 'lib/index' // 主入口模块
}).use(
    [ 'index', 'table', 'form', 'layedit', 'admin', 'laydate' ],
    function() {
      var $ = layui.$, admin = layui.admin, setter = layui.setter, table = layui.table, form = layui.form, layer = layui.layer, laydate = layui.laydate;
      $body = $('body');

      // 日期
      laydate.render({
        elem : '#QueryDateFr'
      });
      laydate.render({
        elem : '#QueryDateTo'
      });

      table.render({
        elem : '#OrderStatusSyncTable',
        url : '<%=request.getContextPath() %>/web/visa/ota/OrderStatusSyncLogQuery.json',
        limit : 100,
        height : 'full-100',
        cols : [ [ {
          field : 'ebo_packagename',
          width : 220,
          align : 'center',
          title : '产品名称',
          templet : '#PackageNameTpl'
        }, {
          field : 'ebo_sourceorderno',
          width : 200,
          align : 'center',
          title : '主单号',
          templet : '#eboSourceordernoTpl'
        }, {
          field : 'ebon_name',
          width : 100,
          align : 'center',
          title : '客人姓名'
        }, {
          field : 'SyncDate',
          width : 100,
          align : 'center',
          title : '推送时间',
          templet : '#SyncDateTpl'
        }, {
          field : 'eos_code',
          width : 200,
          align : 'center',
          title : '推送情况',
          templet : '#EosCodeTpl'
        }, {
          field : 'Result',
          align : 'center',
          title : '状态',
          templet : '#ResultTpl'
        } ] ],
        page : false,
        where : {
          'DateFrom' : "",
          'DateTo' : ""
        }

        ,
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
        console.log(obj);
        var data = obj.data;
        if (obj.event === 'OpenOrder') {
          var id = data.ebo_id;
          window.open('<%=request.getContextPath() %>/Content/BookingOrder/Form/BookingOrderInfo.jsp?ID=' + id);
        } else if (obj.event === 'OpenLog') {
          var Ebon_id = data.ebon_id;
          var logText=$(obj.tr).find(".logText");
          var logTextIcon=$(obj.tr).find(".logTextIcon");
          if (logTextIcon.hasClass('open')){
            logText.hide();
            logTextIcon.removeClass('open');
            
          }
          else{

            logText.show();
            logTextIcon.addClass('open');
          }
          
          
          
          admin.req({
            url : setter.ContextPath + '/web/visa/ota/OrderStatusSyncLogDetilQuery.json?Ebon_id=' + Ebon_id,
            type : 'get',
            success : function(res) {
              console.log(obj.tr);
              if (res.MsgID != 1) {
                $(obj.tr).find(".logText").html(res.MsgText);
              } else {
                var div = $("<div></div>");
                div.append('<div style="margin: 10px 0; border: 1px solid silver;"></div>');
                for (item in res.Data) {
                  var d = res.Data[item];
                  var div2 = $("<div></div>");
                  div2.append("<div><span>推送时间：</span><span>" + d.SyncDate + "</span></div>");
                  div2.append("<div><span>推送状态：</span><span>" + VisaStateName[d.ebon_currentApplyStatus] + "【" + d.ebon_currentApplyStatus + "】</span><i class='layui-icon layui-icon-next'></i><span>"
                    + VisaStateName[d.nextapplystatus] + "【" + d.nextapplystatus + "】</span></div>");

                  if (d.Result == "Error") {
                    div2.append("<div><span>返回结果：</span><span style='color:red'>" + d.Result + "</span></div>");
                    div2.append("<div style='padding-left: 2em;'><span>msg:</span><span style='color:red'>" + d.ResultJson.error_response.msg + "</span></div>");
                    div2.append("<div style='padding-left: 2em;'><span>sub_msg:</span><span  style='color:red'>" + d.ResultJson.error_response.sub_msg + "</span></div>");
                  } else {

                    div2.append("<div><span>返回结果：</span><span >" + d.Result + "</span></div>");
                  }

                  div2.append('<div style="margin: 10px 0; border: 1px solid silver;"></div>');

                  div.append(div2);
                }
                $(obj.tr).find(".logText").html(div);
              }
            }
          });
        }
      });

      var $ = layui.$;

      var events = {
        Query : function(othis) {
          var json = {
            "DateFrom" : $('#QueryDateFr').val(),
            "DateTo" : $('#QueryDateTo').val(),
            "State" : $('#QueryStatus').val(),
          }
          table.reload('OrderStatusSyncTable', {
            where : json
          })
        }
      }
      //点击事件
      $body.on('click', '*[layadmin-event]', function() {
        var othis = $(this)

        , attrEvent = othis.attr('layadmin-event');
        //console.log($(this));
        events[attrEvent] && events[attrEvent].call(this, othis);
      });
    });
