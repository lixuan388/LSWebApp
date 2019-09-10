//<%@page pageEncoding="UTF-8"%>
function CreateVisaSign(id) {
  // window.open('<%=request.getContextPath()%>/Content/BookingOrder/Form/CreateVisaSign.jsp?ID='+id);
  OpenWindows('<%=request.getContextPath()%>/Content/BookingOrder/Form/CreateVisaSign.jsp?ID=' + id, '生成受理号', function() {
    GetVisaNameList();
    GetHistoryList();
  });

}

function ExpressCreate(id) {
  // window.open('<%=request.getContextPath()%>/Content/BookingOrder/Form/CreateVisaSign.jsp?ID='+id);
  console.log(id);
  OpenWindows('<%=request.getContextPath()%>/Content/SF/Form/ExpressCreate.jsp?id=' + id + '&d=' + new Date().getTime(), '生成快递单', function() {
    GetWayBillList();
  });
}

function AlitripTravelVisaApplicantUpdate(id) {

  OpenWindows('<%=request.getContextPath()%>/Content/BookingOrder/Form/AlitripTravelVisaApplicantUpdate.jsp?ID=' + id, '更新申请人信息', function() {
    GetVisaNameList;
    GetHistoryList();
  });
  // window.open('<%=request.getContextPath()%>/Content/BookingOrder/Form/AlitripTravelVisaApplicantUpdate.jsp?ID='+id);
}

function getGuestName(id) {
  for (item in NameList) {
    if (NameList[item].ebon_id == id) {
      return NameList[item].ebon_Name;
    }
  }
  return '';

}

function getGuestAvgID(id) {
  for (item in NameList) {
    if (NameList[item].ebon_id == id) {
      return NameList[item].ebon_id_avg;
    }
  }
  return '';
}
function getGuestID(id) {
  for (item in NameList) {
    if (NameList[item].ebon_id == id) {
      return NameList[item].ebon_id_ava;
    }
  }
  return '';
}
function getGuestPassPort(id) {
  for (item in NameList) {
    if (NameList[item].ebon_id == id) {
      if (NameList[item].ebon_PassPort != undefined) {
        return NameList[item].ebon_PassPort;
      } else {
        return "";
      }

    }
  }
  return '';
}
$(function() {
  for (i = 0; i < PackageJson.length; i++) {
    if (PackageJson[i].ebop_id_ept == 1) {
      $("#VisaDiv").show();
      // $("#VisaTemplate").tmpl(PackageJson[i]).appendTo($(".VisaDataTable>tbody"));
    } else if (PackageJson[i].ebop_id_ept == 2) {
      $("#BaoXianDiv").show();
      $("#DataTemplate2").tmpl(PackageJson[i]).appendTo($(".BaoXianDataTable>tbody"));
    } else if (PackageJson[i].ebop_id_ept == 3) {
      $("#WifiDiv").show();
      $("#DataTemplate").tmpl(PackageJson[i]).appendTo($(".WifiDataTable>tbody"));
    } else if (PackageJson[i].ebop_id_ept == 4) {
      $("#PhoneDiv").show();
      $("#DataTemplate").tmpl(PackageJson[i]).appendTo($(".PhoneDataTable>tbody"));
    }
  }

  $('.easyui-datagrid').datagrid();
  GetHistoryList();
  //GetPackageList(1);
  GetVisaNameList();
  GetMessageTemplate();
  GetWayBillList();
  $('[role=tablist]').tab();
  $('[role=tablist] a:first').tab('show');

})
function OpenVisaSign(t) {
  var id = $(t).data("id");
  // window.open('<%=request.getContextPath()%>/Content/BookingOrder/Form/VisaSign.jsp?ID='+id);
  OpenWindows('<%=request.getContextPath()%>/Content/BookingOrder/Form/VisaSign.jsp?ID=' + id, '查看订单', function() {});

}

function SendMessage() {

  var json = {
    "EboID" : "<%=ID %>",
    "mobile" : $("#SendMsgPhone").val(),
    "content" : $("#SendMsgContent").val()
  };
  // console.log(json);

  $.post("<%=request.getContextPath()%>/zjun/v2smsSend", json, function(data) {
    // console.log(data);
    if (data.MsgID != 1) {
      alert("短信发送失败！<br>" + data.MsgText);
    } else {
      // alert("短信发送成功！<br>Message:"+data.Message+"<br>Remainpoint:"+data.Remainpoint+"<br>Returnstatus:"+data.Returnstatus+"<br>SuccessCounts:"+data.SuccessCounts+"<br>TaskID:"+data.TaskID);
      alert("短信发送成功！");
      GetHistoryList();
    }
  }, "json");
}

function CheckKeyWord() {
  var json = {
    "content" : $("#SendMsgContent").val()
  };
  // console.log(json);

  $.post("<%=request.getContextPath()%>/zjun/v2smsvCheckKeyWord", json, function(data) {
    // console.log(data);
    if (data.MsgID != 1) {
      alert(data.MsgText);
    } else {
      if (data.Message == "没有包含屏蔽词") {
        SendMessage();
      } else {
        alert(data.Message);
      }
    }
  }, "json");
}

function UpdateSaleName() {
  var json = [ {
    "OrderID" : "<%=ID%>"
  } ];

  $.post("<%=request.getContextPath()%>/web/visa/ota/UpdateOrderSalename.json", JSON.stringify(json), function(data) {
    // console.log(data);
    if (data.MsgID != 1) {
      alert(data.MsgText);
    } else {
      $("span[FieldName=ebo_SaleName]").html(data.SaleName);
      alert("销售绑定成功！");
      GetHistoryList();
    }
  }, "json");
}

function GetHistoryList() {
  $(".HistoryLoading1").show();
  $(".HistoryLoading2").show();
  $.ajax({
    url : '<%=request.getContextPath()%>/web/visa/ota/BookingOrderHistory.json?ID=<%=ID%>&d=' + new Date().getTime(),
    type : 'get',
    dataType : 'Json',
    success : function(data) {
      // console.log(data);
      if (data.MsgID != 1) {
        alert(data.MsgText);
      } else {
        var i=1;

        var d1 = $.map(data.Data, function(item, index) {
          if (item.type == '操作备注') {
            item.index=i;
            i++;
            return item;
          } else {
            return null;
          }
        });

        i=1;
        var d2 = $.map(data.Data, function(item, index) {
          if (item.type != '操作备注') {
            item.index=i;
            i++;
            return item;
          } else {
            return null;
          }
        });

        $('#HistoryDataGrid1').datagrid({
          data : d1
        });
        $('#HistoryDataGrid2').datagrid({
          data : d2
        });
      }
      $(".HistoryLoading1").hide();
      $(".HistoryLoading2").hide();
    }
  })
}

function GetWayBillList() {
  $(".WayBillLoading").show();
  $.ajax({
    url : '<%=request.getContextPath()%>/web/SF/GetSFOrderInfo.json?ID=<%=OrderJson.getString("ebo_SourceOrderNo")%>&d=' + new Date().getTime(),
    type : 'get',
    dataType : 'Json',
    success : function(data) {
      // console.log(data);
      if (data.MsgID != 1) {
        alert(data.MsgText);
      } else {
        $("#WayBillTable").html("");
        var jsonArrey = [];
        var b = new Base64();
        //console.log(data.Data);
        for (i in data.Data) {
          var orderID = data.Data[i]._OrderID;
          if (jsonArrey[orderID] == undefined) {
            jsonArrey[orderID] = {
              orderID : "",
              PostRequest : "",
              PostResponse : "",
              Print : "",
              mailDate : "",
              mailUserName : "",
              BillImage : ""
            };
            jsonArrey[orderID].orderID = orderID;
          }
          jsonArrey[orderID][data.Data[i]._Type] = b.decode(data.Data[i]._Content);
          if (data.Data[i]._Type == 'Print') {
            jsonArrey[orderID]['mailDate'] = data.Data[i]._date_ins;
            jsonArrey[orderID]['mailUserName'] = data.Data[i]._user_ins;
          }
        }
        var jsonArrey2 = [];
        var indexNo = 0;
        var PayMethodValue = {
          1 : '寄付月结',
          2 : '顺风到付'
        }
        for (i in jsonArrey) {
          var d = jsonArrey[i];
          if (d.PostRequest!=''){
           
            d.PostRequest = JSON.parse(d.PostRequest);
            d.PostRequest_Address = d.PostRequest.Address;
  
            // console.log(d);
            if (d.Print) {
              var print = JSON.parse(d.Print);
              d.mailNo = print[0].mailNo;
              d.deliverShipperCode = print[0].deliverShipperCode;
              d.consignerCompany = print[0].consignerCompany;
              d.consignerName = print[0].consignerName;
              d.consignerMobile = print[0].consignerMobile;
              d.consignerTel = print[0].consignerTel;
              d.consignerProvince = print[0].consignerProvince;
              d.consignerCity = print[0].consignerCity;
              d.consignerCounty = print[0].consignerCounty;
              d.consignerAddress = print[0].consignerAddress;
              d.PayMethod = PayMethodValue[print[0].payMethod];
  
  //            console.log(d.mailNo);
            }
  
            // $("#WayBillTemplate").tmpl(d).appendTo($("#WayBillTable"));
            d.index = indexNo + 1;
            jsonArrey2[indexNo] = d;
            indexNo = indexNo + 1; 
          }
        }

//        console.log(jsonArrey2);
        $('#WayBillDataGrid').datagrid({
          data : jsonArrey2
        });

      }
      $(".WayBillLoading").hide();
    }
  })
}

function GetVisaNameList() {

  $(".VisaLoading").show();
  $.ajax({
    url : '<%=request.getContextPath()%>/web/visa/ota/BookingOrderNameListByVisa.json?ID=<%=ID%>&d=' + new Date().getTime(),
    type : 'get',
    dataType : 'Json',
    success : function(data) {
      // console.log(data);
      if (data.MsgID != 1) {
        alert(data.MsgText);
      } else {
        $('#VisaDataGrid').datagrid({
          data : data.Data
        });
        $(".VisaLoading").hide();
        $("#CreateVisaSignBtn").hide();
        for (i in data.Data) {
          if (data.Data[i].ebon_id_avg == -1) {
            $("#CreateVisaSignBtn").show();
          }
        }
      }
    }
  })
}
function GetPackageList(type) {
  // console.log("GetPackageList");
  switch (type) {
  case 1:
    $(".VisaLoading").show();
    break;
  case 2:
    break;
  default:
    break;
  }

  $.ajax({
    url : '<%=request.getContextPath()%>/web/visa/ota/BookingOrderPackage.json?ID=<%=ID%>&PackageType=' + type + '&d=' + new Date().getTime(),
    type : 'get',
    dataType : 'Json',
    success : function(data) {
      // console.log(data);
      if (data.MsgID != 1) {
        alert(data.MsgText);
      } else {
        switch (type) {
        case 1:
          $('#VisaDataGrid').datagrid({
            data : data.Data
          });
          $(".VisaLoading").hide();
          $("#CreateVisaSignBtn").hide();
          for (i in data.Data) {
            if (data.Data[i]._ebon_id_avg == -1) {
              $("#CreateVisaSignBtn").show();
            }
          }
          break;
        case 2:
          break;
        default:
          break;
        }
      }
    }
  })
}
var MessageTemplate;
function GetMessageTemplate() {
  $.ajax({
    url : '<%=request.getContextPath() %>/web/visa/ota/system/MessageTemplateGet.json?d=' + new Date().getTime(),
    type : 'get',
    dataType : 'Json',
    success : function(data) {
      if (data.MsgID != 1) {
        return;
      } else {

        MessageTemplate = data.Data;
        $("#MessageTemplateList").html();

        $("#MessageTemplateList").append("<option style='display: none'></option>");
        for (var i = 0; i < data.Data.length; i++) {
          $("#MessageTemplateList").append("<option value=" + i + ">" + data.Data[i]._Title + "</option>");
        }
        $('#DataGrid').datagrid({
          data : data.Data
        });
      }
    }
  })
}
function SelectMessageTemplate() {
  var index = $("#MessageTemplateList").val();
  console.log(index);
  // if (MessageTemplate)
  {
    var index = $("#MessageTemplateList").val();
    $("#SendMsgContent").val(MessageTemplate[index]._Content);
  }
}

function OpenAvg(val, row) {

  if (row.ebon_id_avg <= 0) {
    return "未生成受理号！";
  } else {
    return "<a style=\"margin-left: auto;margin-right: auto;width:100%;\" class=\"btn btn-primary btn-xs\" href=\"javascript:void(0);\" data-id=\"" + row.ebon_id_avg
      + "\" onclick=\"OpenVisaSign(this)\"  role=\"button\" >" + row.ebon_id_avg + "</a>\r\n"
  }
}

function OpenEptName(val, row) {
  return "<span>" + ProductTypeName[row.ebop_id_Ept] + "</span>"
}

function OpenActName(val, row) {
  return "<span>" + CountryName[row.ebop_id_act] + "</span>"
}

function OpenWayBillImage(val, row) {

  return "<div><a style=\"margin-left: auto;margin-right: auto;width:100%;\" class=\"btn btn-primary btn-xs\" href=\"javascript:void(0);\"  onclick=\"PrintWayBillImage('" + row.BillImage
    + "')\"	role=\"button\" >打印快递单</a></div>\r\n"
    + "<div><a style=\"margin-left: auto;margin-right: auto;width:100%;\" class=\"btn btn-info btn-xs\" href=\"javascript:void(0);\"  onclick=\"QueryBillRoute('" + row.orderID
    + "')\"	role=\"button\" >查看物流</a></div>\r\n" + "<div><a style=\"margin-left: auto;margin-right: auto;width:100%;\" class=\"btn btn-default btn-xs\" target=\"_blank\" href=\"/SFWayBillImage/"
    + row.BillImage + "\" role=\"button\" >查看快递单</a></div>\r\n"
}

function OpenWayBillNo(val, row) {

  return "<center><div>" + row.mailNo + "</div><div style=\"color: #ababab;\">【" + row.orderID + "】</div><div>" + row.mailDate + "</div></center>";
}

function OpenPostRequest_Address(val, row) {

  return "<div><span>地址：</span><span>" + row.consignerProvince + "&nbsp;</span><span>" + row.consignerCity + "&nbsp;</span><span>" + row.consignerCounty + "&nbsp;</span>" + "<span>"
    + row.PostRequest_Address + "</span></div>" + "<div><span>联系人：</span><span>" + row.consignerName + "</span></div><div><span>联系电话：</span><span>" + row.consignerMobile + "</span></div>";
}

function QueryBillRoute(OrderID) {
  OpenWindowLayer("物流信息", "<%=request.getContextPath() %>/Content/SF/Form/ShowOrderRoute.jsp?id=" + OrderID + "&d=" + new Date().getTime(), null, null);
}

function PrintWayBillImage(path) {
  //  var img="<img src='/SFWayBillImage/"+path+"' width='300px'";
  //  alertLayer(img);
  var $loadingToast = loadingToast();
  $.ajax({
    url : 'http://127.0.0.1:58001/?WayBillPrint&path=/SFWayBillImage/' + path,
    type : 'get',
    dataType : 'Json',
    success : function(data) {
      $loadingToast.modal("hide");
      //      console.log(data);
      if (data.ErrCode = 1) {
        //$(".ScanButton").removeAttr("disabled");

        alert("打印完成");
      } else {
        alert(data.ErrMsg);
      }
    },
    error : function(Req, err, e) {
      $loadingToast.modal("hide");
      alert("打印失败");
    }
  })

}


function UpdateBookingOrderHistory() {
  // window.open('<%=request.getContextPath()%>/Content/BookingOrder/Form/VisaSign.jsp?ID='+id);
  OpenWindowLayer('订单备注', '<%=request.getContextPath()%>/Content/BookingOrder/Form/UpdateBookingOrderHistory.jsp?ID=<%=ID %>&d='+new Date().getTime() , function() {
    GetHistoryList();
  },{width:"400px",height:"500px"});

}


function UpdatePostAddress(OrderID) {
  var json =  {
    "OrderID" : '<%=OrderJson.getString("ebo_SourceOrderNo")%>'
  } ;

  $.post("<%=request.getContextPath()%>/web/visa/ota/UpdateOrderPostAddress.json", JSON.stringify(json), function(data) {
    // console.log(data);
    if (data.MsgID != 1) {
      alertLayer(data.MsgText);
    } else {
      alertLayer('联系人信息更新成功！',function(){
        window.location='<%=request.getContextPath()%>/Content/BookingOrder/Form/BookingOrderInfo.jsp?ID=<%=ID%>';
      });
    }
  }, "json");
  
  
}



layui.use(['element','laytpl'], function(){
  var $ = layui.jquery
  ,element = layui.element //Tab的切换功能，切换事件监听等，需要依赖element模块
  ,laytpl = layui.laytpl; //Tab的切换功能，切换事件监听等，需要依赖element模块

//  var HistoryListTabTpl =$("#HistoryListTabTpl").html();
//  
//  for (i in HistoryListType){
//
//    var d={'id':i,'name':HistoryListType[i]} ;
//    var innerHTML='';
//    laytpl(HistoryListTabTpl).render(d, function(html){
//      innerHTML = html;
//    });
//    
//    element.tabAdd('HistoryListTab', {
//      title: HistoryListType[i]
//      ,content: innerHTML
//      ,id: 'HistoryListTab'+i //实际使用一般是规定好的id，这里以时间戳模拟下
//    });
//  }  
  //element.tabChange('HistoryListTab', 'HistoryListTab0');

//  $('.easyui-datagrid').datagrid();
  
  

  layui.element.tabChange('HistoryListTab', 'HistoryListTab0');
  
});




