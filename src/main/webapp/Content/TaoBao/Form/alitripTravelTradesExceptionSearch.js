// <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

layui.use('table', function() {
  var table = layui.table;
  var $ = layui.$;
  // 监听工具条
  table.on('tool(DataGrid)', function(obj) {
    var data = obj.data;
    if (obj.event === 'Open') {
      window.open("<%=request.getContextPath() %>/Content/TaoBao/Form/alitripInfo.jsp?id=" + data.OrderID2 + "&d=<%=request.getSession().getLastAccessedTime()%>");
    } else if (obj.event === 'Refresh') {
      // event.ProductInfoEdit(obj);
      window.open("<%=request.getContextPath() %>/taobao/api/alitripTravelTradeQuery.json?OrderID=" + data.OrderID2 + "&U=true&d=<%=request.getSession().getLastAccessedTime()%>");
    } else if (obj.event === 'Edit') {
      // event.ProductInfoEdit(obj);

      OpenWindowLayer("绑定产品", "<%=request.getContextPath() %>/Content/TaoBao/Form/alitripTravelTradesUpdateSUKID.jsp?itemid=" + data.item_id + "&d=<%=request.getSession().getLastAccessedTime()%>",
          function() {
            event.Query();
          }, {
            'width' : '500px', 'height' : '250px'
          })

    }
  });

  var event =
    {
      Query : function(self) { // 获取选中数据
        var $loadingToast = loadingToast();
        var json = {
          "MsgID" : -1, "StartDate" : "2018-01-01", "EndDate" : "2028-01-01","NoOrderStatus" : "TRADE_FINISHED",
        }
        // $loadingToast.fadeIn(100);
        $.ajax({
          url : '<%=request.getContextPath() %>/taobao/api/alitripTravelTradesSearch2.json',
          type : 'post',
          data : JSON.stringify(json),
          dataType : 'Json',
          success : function(data) {
            $loadingToast.modal("hide");
            // console.log(data);
            if (data.MsgID != 1) {
              alert(data.MsgText);
              return;
            } else {
              if (data.Data.length == 0) {
                table.reload('DataGrid', {
                  // 更新数据
                  data : [],
                });
              } else {
                var TemplateData =
                  $.map(data.Data, function(item) {

                    var first_result = item.alitrip_travel_trade_query_response.first_result;

                    item.OrderID2 = first_result.order_id_string;
                    item.status = GetTradesStatus(first_result.status) + "<br>(" + first_result.status + ")";
                    item.statusID = first_result.status;

                    item.created_time = first_result.created_time.replace(new RegExp(" ", "g"), "<br>");
                    item.item_title = first_result.sub_orders.sub_order_info[0].buy_item_info.item_title;
                    item.item_title = item.item_title + "<br>item_id:" + first_result.sub_orders.sub_order_info[0].buy_item_info.item_id["$numberLong"];
// console.log(first_result.sub_orders.sub_order_info[0].buy_item_info.item_id);
                    item.item_id = first_result.sub_orders.sub_order_info[0].buy_item_info.item_id["$numberLong"];

                    // if (data.Data.MsgText=='未对照产品ID！')
                    // {
                    // row[index].item_title=row[index].item_title+'<br>'+data.Data.alitrip_travel_trade_query_response.first_result.sub_orders.sub_order_info[0].buy_item_info.item_title;
                    // }
                    // else
                    if (item.MsgText == '无内部产品信息！') {
                      item.item_title = item.item_title + '<br>out_sku_id:' + item.out_sku_id;
                    }

                    item.total_fee = first_result.sub_orders.sub_order_info[0].total_fee / 100;

                    if (item.MsgID == 0) {
                      item.OrderType = "未处理";
                    } else if (item.MsgID == -1) {
                      item.OrderType = item.MsgText;
                    } else if (item.MsgID == 1) {
                      item.OrderType =
                        '<a href="<%=request.getContextPath() %>/Content/BookingOrder/Form/BookingOrderInfo.jsp?ID=' + item.OrderID
                          + '&d=<%=request.getSession().getLastAccessedTime()%>" target="_blank">订单明细</a>';
                    } else {
                      item.OrderType = item.MsgID;
                    }
                    return item;
                  });

                // console.log(TemplateData);
                table.reload('DataGrid', {
                  // 更新数据
                  data : TemplateData,
                });
              }
            }
          }
        })
      }

    };

  event.Query();
});
