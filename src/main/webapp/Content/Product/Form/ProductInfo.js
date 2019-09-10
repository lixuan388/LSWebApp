// <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

layui.use([ 'table', 'form' ], function() {
  var table = layui.table, form = layui.form;
  var $ = layui.$;
  // 监听工具条
  table.on('tool(DataGrid)', function(obj) {
    var data = obj.data;
    if (obj.event === 'del') {} else if (obj.event === 'edit') {
      event.ProductInfoEdit(obj);
    }
  });

  table.render({
    elem : '#DataGrid',
    page : true,
    limit : 15,
    height : 'full-150',
    size : 'sm',
    cols : [ [ {
      field : 'epi_id',
      width : 80,
      align : 'center',
      title : 'ID'
    }, {
      field : 'epi_Code',
      width : 100,
      align : 'center',
      title : '内部编码'
    }, {
      field : 'epi_Name',
      align : 'center',
      title : '产品名称'
    }, {
      field : 'ProductType',
      width : 80,
      align : 'center',
      title : '产品类型'
    }, {
      field : 'Supplier',
      width : 60,
      align : 'center',
      title : '供应商'
    }, {
      field : 'Country',
      width : 60,
      align : 'center',
      title : '国家'
    }, {
      field : 'epi_Day',
      width : 50,
      align : 'center',
      title : '天数'
    }, {
      field : 'epi_InSideID',
      width : 75,
      align : 'center',
      title : '内部ID'
    }, {
      field : 'epi_InSideName',
      align : 'center',
      title : '内部名称'
    }, {
      field : 'epi_CostMoney',
      width : 75,
      align : 'center',
      title : '成本价'
    }, {
      field : 'epi_SaleMoney',
      width : 75,
      align : 'center',
      title : '销售价'
    }, {
      field : 'OP',
      width : 100,
      align : 'right',
      toolbar : '#TableOPBar',
      align : 'center'
    } ] ],
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

  var event = {
    ProductInfoQuery : function(self) { // 获取选中数据
      var $loadingToast = loadingToast();
      var QueryText = (encodeURIComponent($("#QueryText").val()));
      var type = "0";
      $('[type=checkbox]:checked').each(function() {
        type = type + "," + $(this).data('value');
      })

      var json = {
        'QueryText' : QueryText,
        'type' : type
      }
      // $loadingToast.fadeIn(100);
      $.ajax({
        url : '<%=request.getContextPath() %>/Content/Product/ProductInfoGet.json?d=' + new Date().getTime(),
        type : 'get',
        data : json,
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
              var TemplateData = $.map(data.Data, function(item) {
                item.ProductType = ProductTypeName[item.epi_Type] == undefined ? item.epi_Type : ProductTypeName[item.epi_Type];
                item.Supplier = SupplierName[item.epi_id_esi] == undefined ? item.epi_id_esi : SupplierName[item.epi_id_esi];
                item.Country = CountryName[item.epi_id_act] == undefined ? item.epi_id_act : CountryName[item.epi_id_act];
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
    },
    ProductInfoInsert : function(self) {
      var $loadingToast = loadingToast();
      $.ajax({
        url : '<%=request.getContextPath() %>/System/GetMaxID.json?d=' + new Date().getTime(),
        type : 'get',
        dataType : 'Json',
        success : function(data) {
          $loadingToast.modal("hide");
          if (data.MsgID != 1) {
            alert(data.MsgText);
            return;
          } else {
            OpenWindowLayer("新增产品", "<%=request.getContextPath()%>/Content/Product/Form/ProductInfoInsert.jsp?ID=-1", null, {
              'width' : '800px'
            })
          }
        }
      })
    },
    ProductInfoEdit : function(obj) {
      var id = obj.data.epi_id;
      OpenWindowLayer("修改产品信息", "<%=request.getContextPath()%>/Content/Product/Form/ProductInfoInsert.jsp?ID=" + id, null, {
        'width' : '800px'
      })

    },
    ProductInfoDelete : function(self) {
      $("#ProductInfoDiv #ProductInfoDeleteModal [FieldName]").each(function() {
        var FieldName = $(this).attr("FieldName");
        $(this).val($(t).parent().data(FieldName.toLowerCase()));
      });
      $("#ProductInfoDiv #ProductInfoDeleteModal [FieldName=epi_status]").val('D');
      $("#ProductInfoDiv #ProductInfoDeleteModal [FieldName=epi_User_Lst]").val('<%=request.getSession().getAttribute("UserName")%>');
      $("#ProductInfoDiv #ProductInfoDeleteModal [FieldName=epi_Date_Lst]").val(new Date().Format("yyyy-MM-dd HH:mm:ss"));
      $("#ProductInfoDiv #ProductInfoDeleteModal [FieldName=epi_Type]").val(ProductTypeJson[$(t).parent().data("api_type")]);
      $("#ProductInfoDiv #ProductInfoDeleteModal").modal("show");
    }
  };

  $('[lay-event]').on('click', function() {
    var type = $(this).attr('lay-event');
    event[type] ? event[type].call(this) : '';
  });

  event.ProductInfoQuery();
});
