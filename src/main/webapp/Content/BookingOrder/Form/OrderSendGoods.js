//<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
layui.config({
  base : '<%=request.getContextPath() %>/layuiadmin/' // 静态资源所在路径
  ,ContextPath : '<%=request.getContextPath() %>' //
  ,version : '<%=version.Version%>'//
}).extend({
  index : 'lib/index' // 主入口模块
}).use(['index', 'admin','table', 'form' ],function() {
  var table = layui.table
  ,form = layui.form
  ,admin = layui.admin
  ,setter=layui.setter
  $ = layui.$;

  var MessageTemplate;
  var GetMessageTemplate=function(){
    admin.req({
      url: '<%=request.getContextPath() %>/web/visa/ota/system/MessageTemplateGet.json?d=' + new Date().getTime(),
      type: 'get',
      dataType: 'Json',
      success: function (data) {
        if (data.MsgID != 1)
        { 
          return;
        } 
        else
        {

          MessageTemplate=data.Data;
          $("#MessageTemplateList").html();

          $("#MessageTemplateList").append("<option style='display: none'></option>");
          for (var i=0;i<data.Data.length;i++)
          {
            $("#MessageTemplateList").append("<option value="+i+">"+data.Data[i]._Title+"</option>");
          }
          form.render('select');
        }
      }
    })

  }
  //监听指定开关
  form.on('select(MessageTemplateList)', function(data){
    console.log(data);
    var index=data.value;
    $("#SendMsgContent").val(MessageTemplate[index]._Content);
  });
  

  table.render({
    elem: '#NameListTable'
    ,limit: 100
    ,url:''
    ,cols: [[
      {type:'checkbox'}
      ,{field:'_index',width:80, align:'center', title:'序号'}
      ,{field:'_Name',width:100, align:'center', title:'姓名'}
      ,{field:'_PackageName', align:'center', title:'产品'}
      ,{field:'_StatusType',width:200, align:'center', title:'办理人状态'}

    ]]
    ,data:null
    ,page: false
  });
  
  var event = {
    Query : function(self) { // 获取选中数据
      var queryText = encodeURIComponent(encodeURIComponent($("#QueryText").val()));
      var json={"ID":queryText};
      admin.req({
        url: setter.ContextPath+'/web/visa/ota/BookingOrderInfoQuery.json'
        ,type: 'get'
        ,data:json
        ,success: function(res){    
          console.log(res)
          if (res.MsgID==1)
          {
            // 表单初始赋值
            form.val('SendGoodsForm', {
              "SendToAddr": res.OrderInfo._Addr
              ,"SendPhone":res.OrderInfo._Phone
              ,"_SourceName":res.OrderInfo._SourceName
              ,"_SourceOrderNo":res.OrderInfo._SourceOrderNo
               ,"_PayDate":res.OrderInfo._PayDate
               ,"_SourceGuest":res.OrderInfo._SourceGuest
               ,"EboID":res.OrderInfo._id
               ,"Province":res.contactor.post_province
               ,"City":res.contactor.post_city
               ,"County":res.contactor.post_area
               ,"Contact":res.contactor.name
               ,"Tel":res.contactor.phone
               ,"Address":res.contactor.post_address
               ,"PayType":'1'
               ,"Document": ''
               ,"invoice":''
               ,"SMS":'',
               'SendMsgContent':'',
               'SendGoodsList':'',
               'SendInvoice':'',  
                   
               
            })

            $('.mainForm').removeClass('doing');
          }
          else{
            layer.alert(res.MsgText); 
          }
          
          var TemplateData=$.map( res.NameList, function( item,index ) {
            var NewItem={};
            NewItem._index=index+1;
            NewItem._Name=item._Name;
            NewItem._PackageName=res.OrderInfo._PackageName;
            NewItem._StatusType=item._StatusType;
            NewItem._id=item._id;
            NewItem._ApplyId=item._ApplyId;
            NewItem._currentApplyStatus=item._currentApplyStatus;
            return NewItem;
          });

          table.reload('NameListTable', {
            // 更新数据
            data: TemplateData,
          });
        }
      });
    }
    ,CreateExpress:function(self){
      console.log(form.val('SendGoodsForm'));
    }
  };

  $('[lay-event]').on('click', function() {
    var type = $(this).attr('lay-event');
    event[type] ? event[type].call(this) : '';
  });
  
  form.on('submit(CreateExpress)', function(data){
    //console.log(data.field);
    
    var jsonData={
      "PayType": data.field.PayType,
      "Document": data.field.Document|| 'off',
      "invoice": data.field.invoice|| 'off',
      "SMS": data.field.SMS|| 'off',
      "Province": data.field.Province,
      "City": data.field.City,
      "County":data.field.County,
      "Contact":data.field.Contact,
      "Tel": data.field.Tel,
      "Address": data.field.Address,
      "SendPhone": data.field.SendPhone,
      "SendMsgContent": data.field.SendMsgContent,
    }
    var orderData=[]
    $('.OrderDetil').each(function(){
      var orderDetil={}
      orderDetil.OrderID=$(this).find('[name=_SourceOrderNo]').val();
      orderDetil.EboID=$(this).find('[name=EboID]').val();
      orderDetil.SendGoodsList=$(this).find('[name=SendGoodsList]').val();
      orderDetil.SendInvoice= $(this).find('[name=SendInvoice]').val();
      orderDetil.checkList=table.checkStatus('NameListTable').data;
      orderData.push(orderDetil);
    })
    
    jsonData.OrderList=orderData;
    console.log(jsonData);
    admin.req({
      url: '<%=request.getContextPath() %>/web/visa/ota/OrderSendGoods.json',
      type: 'post',
      data:JSON.stringify(jsonData),
      dataType: 'Json',
      success: function (data) {
        console.log(data)
        if (data.MsgID!=1){
          alert(data.MsgText);
        }
        else{
          
          $('#ExpressCode').val(data.MailNo);
          var BillImage="/SFWayBillImage/"+data.BillImage;
          $('#BillImage').attr('href',BillImage);
          $('#OpenBillImage').on('click', function() {
            PrintWayBillImage(BillImage);
          });
          $('.mainForm').addClass('doing');
        }

      }
    })
    return false;
  });
  GetMessageTemplate();
  

  function PrintWayBillImage(path) {
    //  var img="<img src='/SFWayBillImage/"+path+"' width='300px'";
    //  alertLayer(img);
    var $loadingToast = loadingToast();
    $.ajax({
      url : 'http://127.0.0.1:58001/?WayBillPrint&path=' + path,
      type : 'get',
      dataType : 'Json',
      success : function(data) {
        $loadingToast.modal("hide");
              console.log(data);
        if (data.ErrCode == 1) {
          //$(".ScanButton").removeAttr("disabled");

          layer.alert("打印完成");
        } else {
          layer.alert(data.ErrMsg);
        }
      },
      error : function(Req, err, e) {
        $loadingToast.modal("hide");
        layer.alert("打印失败");
      }
    })

  }

});
