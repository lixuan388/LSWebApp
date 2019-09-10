//<%@page pageEncoding="UTF-8"%>
$(function() {
  for (item in data.VisaSignInfo) {
    var f = $(".VisaSignInfo [FieldName=" + item + "]");
    if (f.length > 0) {
      f.data("value", data.VisaSignInfo[item]);
      if (f.hasClass('lookup')) {
        if (item == 'avg_id_act') {
          f.val(CountryName[data.VisaSignInfo[item]]);
        } else if (item == 'avg_id_avs') {
          f.val(VisaSpeedName[data.VisaSignInfo[item]]);
        } else if (item == 'avg_id_type') {
          f.val(VisaTypeName[data.VisaSignInfo[item]]);
        } else if (item == 'avg_id_asi') {
          f.val(SourceInfoName[data.VisaSignInfo[item]]);
        } else {
          f.val(data.VisaSignInfo[item]);
        }
      } else {
        f.val(data.VisaSignInfo[item]);
      }
    }
  }
  $(".VisaSignDetil .DataTable>tbody").html("");
  $("#DetilTableTemplate").tmpl(data.VisaSignDetil).appendTo($(".VisaSignDetil .DataTable>tbody"));
  CreateVisaSign_GetReturnDate();
  $('.form_datetime').datetimepicker({
    weekStart : 0, // 一周从哪一天开始
    todayBtn : 1, //
    autoclose : 1,
    todayHighlight : 1,
    startView : 2,
    minView : 2,
    forceParse : 0,
    showMeridian : 1,
    language : 'zh-CN',
    format : 'yyyy-mm-dd',
    startDate : '2017-01-01'
  });

  var tableWidth = 0;
  $(".DataTable thead>tr>td").each(function() {
    var w = $(this).attr("width") * 1;
    $(this).css("width", w + "px");
    tableWidth = tableWidth + w;
  })
  $(".DataTable").css("width", tableWidth + "px");

  var avg_SupplierID=data.VisaSignInfo['avg_SupplierID'];
  $('.avg_SupplierID').select2({
      placeholder: {
        id: avg_SupplierID, // the value of the option
        text:SourceSupplierInfoName[avg_SupplierID]
      }
  });
})

function CreateVisaSign_Post() {
  var $loadingToast = loadingToast();

  var avg_SupplierID=$('.avg_SupplierID').val();
  if (!avg_SupplierID || (avg_SupplierID=='0')){
    alert("请选择【供应商】！");

    $loadingToast.modal("hide");
    return;    
  }
  var Data = {}
  $(".VisaSignInfo [FieldName]").each(function() {
    var FieldName = $(this).attr("FieldName");
    var FieldValue = $(this).data("value");
    Data[FieldName] = FieldValue;
  })
  Data['avg_date_rtn'] = $('.VisaSignInfo [FieldName=avg_date_rtn]').val();
  Data['avg_date_send'] = $('.VisaSignInfo [FieldName=avg_date_send]').val();
  Data['avg_remark'] = $('.VisaSignInfo [FieldName=avg_remark]').val();
  Data['avg_Source_link'] = $('.VisaSignInfo [FieldName=avg_Source_link]').val();
  Data['avg_Source_tel'] = $('.VisaSignInfo [FieldName=avg_Source_tel]').val();
  Data['avg_Source_addr'] = $('.VisaSignInfo [FieldName=avg_Source_addr]').val();
  Data['avg_SupplierID'] =avg_SupplierID;
//  console.log(Data);
//  return;
  var DataRows = [];
  DataRows[0] = Data;

  var DataSignRows = []
  var DataEbonRows = []
  $(".VisaSignDetil>table>tbody>tr").each(function(index) {
    var data = {}

    $(this).find("[FieldName]").each(function() {
      var FieldName = $(this).attr("FieldName");
      var FieldValue = $(this).val();
      data[FieldName] = FieldValue;
    })
    DataSignRows[index] = data;

    DataEbonRows[index] = {
      "ebon_id" : $(this).data("ebon_id"),
      "ebon_name" : $(this).find("[FieldName=ava_name_c]").val(),
      "ebon_passport" : $(this).find("[FieldName=ava_PassPortNo]").val(),
      "ebon_id_avg" : $(this).find("[FieldName=ava_id_avg]").val(),
      "ebon_id_ava" : $(this).find("[FieldName=ava_id]").val()
    }
  })

  var json = {
    "DataRows" : DataRows,
    "DataSignRows" : DataSignRows,
    "DataEbonRows" : DataEbonRows
  };

  $.post("<%=request.getContextPath()%>/Content/VisaSign/VisaSignPost.json?d=" + new Date().getTime(), JSON.stringify(json), function(data) {
    // console.log(data);
    $loadingToast.modal("hide");
    if (data.MsgID != 1) {
      alert(data.MsgText);
    } else {
      alert("订单信息保存成功！");
      $("[FieldName]").attr("disabled", "disabled");
      $("#saveButton").html('关闭');
      $("#saveButton").on('click', function() {
        window.close();
      })

      $("#PrintVisaButton").removeAttr("disabled");

    }
  }, "json");
}

function CreateVisaSign_GetReturnDate() {
  var $loadingToast = loadingToast();

  var json = {
    "avsID" : $('[FieldName=avg_id_avs]').data('value'),
    "actID" : $('[FieldName=avg_id_act]').data('value'),
    "SendDate" : $('[FieldName=avg_date_send]').val()
  };

  $.post("<%=request.getContextPath()%>/web/system/GetVisaReturnDate.json?d=" + new Date().getTime(), JSON.stringify(json), function(data) {
    // console.log(data);
    $loadingToast.modal("hide");
    if (data.MsgID != 1) {
      alert(data.MsgText);
    } else {
      $('[FieldName=avg_date_rtn]').val(data.ReturnDate)
    }
  }, "json");
}

function CreateVisaSign_GetNextWorkDate() {
  var $loadingToast = loadingToast();

  var json = {
    "avsID" : $('[FieldName=avg_id_avs]').data('value'),
    "actID" : $('[FieldName=avg_id_act]').data('value'),
    "SendDate" : $('[FieldName=avg_date_send]').val()
  };

  $.post("<%=request.getContextPath()%>/web/system/GetVisaNextWorkDate.json?d=" + new Date().getTime(), JSON.stringify(json), function(data) {
    // console.log(data);
    $loadingToast.modal("hide");
    if (data.MsgID != 1) {
      alert(data.MsgText);
    } else {
      $('[FieldName=avg_date_send]').val(data.ReturnDate);
      CreateVisaSign_GetReturnDate();

    }
  }, "json");
}

function CreateVisaSign_Scan(id) {

  var WaitScan = loadingToast("请放入护照");

  $.ajax({
    url : 'http://127.0.0.1:58001/?Scan',
    type : 'get',
    dataType : 'Json',
    success : function(data) {
      // console.log(data);
      if (data.ErrCode == '1') {
        var tr = $("tr[data-id=" + id + "]");
        console.log(tr);
        tr.find("[FieldName=ava_name_c]").val(data.Field2);
        tr.find("[FieldName=ava_name_e]").val(data.Field3);
        tr.find("[FieldName=ava_PassPortNo]").val(data.Field1);
        if (data.Field23 == "男") {
          tr.find("[FieldName=ava_sex]").val(1);
        } else {
          tr.find("[FieldName=ava_sex]").val(2);
        }

        tr.find("[FieldName=ava_date_birth]").val(data.Field5);
        tr.find("[FieldName=ava_Date_Sign]").val(data.Field16);
        tr.find("[FieldName=ava_Date_End]").val(data.Field6);
        tr.find("[FieldName=ava_place_issue]").val(data.Field15);
        tr.find("[FieldName=ava_country_code]").val(data.Field12);

        var d = new Date() - new Date(data.Field5);
        d = d / (1000 * 60 * 60 * 24 * 365)
        tr.find("[FieldName=ava_age]").val(d.toFixed(0));
      }
      WaitScan.modal("hide");
    }
  })
}
function CreateVisaSign_DeviceInit() {

  var $loadingToast = loadingToast();

  $.ajax({
    url : 'http://127.0.0.1:58001/?DeviceInit',
    type : 'get',
    dataType : 'Json',
    success : function(data) {
      $loadingToast.modal("hide");
      // console.log(data);
      if (data.ErrCode == '1') {
        $(".ScanButton").removeAttr("disabled");
      } else {
        alert(data.ErrMsg);
      }
    },
    error : function(Req, err, e) {
      $loadingToast.modal("hide");
      alert("扫描仪连接失败");
    }
  })
}

function CreateVisaSign_PrintVisa(id) {

  window.open('LSWebPlug:VisaLablePrint%20'+id);
//  var $loadingToast = loadingToast();
//
//  $.ajax({
//    url : 'http://127.0.0.1:58001/?VisaPrint&id=' + id,
//    type : 'get',
//    dataType : 'Json',
//    success : function(data) {
//      $loadingToast.modal("hide");
//      // console.log(data);
//      if (data.ErrCode = 1) {
//        //$(".ScanButton").removeAttr("disabled");
//
//        alert("打印完成");
//      } else {
//        alert(data.ErrMsg);
//      }
//    },
//    error : function(Req, err, e) {
//      $loadingToast.modal("hide");
//      alert("打印失败");
//    }
//  })
}
