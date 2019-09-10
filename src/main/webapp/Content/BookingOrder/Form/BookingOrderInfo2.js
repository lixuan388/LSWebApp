var app = angular.module('BookingOrderInfoApp', []);

app.directive('onFinishRenderFilters', ['$timeout', function ($timeout) {
  return {
    restrict: 'A',
    link: function(scope,element,attr) {
//      console.log("-----onFinishRenderFilters-------");
//      console.log(scope);
//      console.log(element);
      if (scope.$last === true) {
        var finishFunc=scope.$parent[attr.onFinishRenderFilters];
        if(finishFunc)
        {
          $timeout(function () {
            finishFunc();
          });
        }
      }
    }
  };
}])



app.controller('BookingOrderInfoCtrl', function($scope, $http, $location,$timeout,$compile) {
  $scope.HistoryList=HistoryListType;
  $scope.HistoryListCount=[];
  for (i in $scope.HistoryList){
    $scope.HistoryListCount[i]=0;
  }
  $scope.OrderInfo={};
  
  $scope.avgid=-1;
  
  $scope.CanCreateVisaSign=false;
  

//  $scope.InvoiceData={"aia_GuestBankCode":"1",
//    "aia_GuestBankName":"1",
//    "aia_GuestTel":"1",
//    "aia_GuestAddr":"1",
//    "aia_GuestIDCode":"1",
//    "aia_Company":"1",
//    "aia_Money":"1",
//    "aia_Content":"1",
//    "aia_InvoiceType":"1"
//  };
  $scope.InvoiceData={};
  $scope.BookingInvoice={};
  $scope.InvoiceReadOnly=true;  
  $scope.InvoiceDataIndex=0;
  
  $scope.CostData={
    'PayMoney':'0.00',
    'AccountMoney':'0.00',
    'Compensation':'0.00',
    'Express':'0.00',
    'VisaCost':'0.00',
    'Profit':'0.00'
  };

  
  
  
  $scope.BookingOrderInfo=function(){
    LoadingShow();
    $http({
      method: 'get',
      url : config.ContextPath+'/web/visa/base/BookingOrderInfo.json?ID='+ebo_id+'&d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      var data=response.data;
      LoadingHide();
//      console.log(data);
      if (data.MsgID==1){
//        console.log(data.Data);
        $scope.OrderInfo=data.Data.OrderInfo;
        $scope.GetVisaNameList();

        $scope.GetHistoryListData();
        $scope.GetMessageTemplate();
        GetWayBillList();
        $scope.BindOrderQuery();
        $scope.BookingInvoiceQuery();
        $scope.BookingOrderCost();
      }
      else{
        layer.alert(data.MsgText, "错误");
        return;
      }      
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
  }
  

  $scope.BookingOrderCost=function(){
    $http({
      method: 'get',
      url : config.ContextPath+'/web/visa/base/BookingOrderCost.json?ID='+ebo_id+'&d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      var data=response.data;
//      console.log(data);
      if (data.MsgID==1){
        $scope.CostData=data.Data;
        $scope.CostData.Profit=$scope.CostData.PayMoney-$scope.CostData.VisaCost-$scope.CostData.Compensation;
      }
      else{
        return;
      }      
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
  }
  

  $scope.GetVisaNameList=function(){

    $(".VisaLoading").show();

    $http({
      method: 'get',
      url : config.ContextPath+'/web/visa/ota/BookingOrderNameListByVisa.json?ID='+ebo_id+'&d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      var data=response.data;
      
//      console.log(data);
      if (data.MsgID==1){
        $(".VisaLoading").hide();
        $scope.BookingOrderNameList=data.Data;

        $scope.CanCreateVisaSign=false;
        for (i in data.Data){
          if (data.Data[i].ebon_id_avg!=-1){
            $scope.avgid=data.Data[i].ebon_id_avg;
          }
          else {
            $scope.CanCreateVisaSign=true;
          }
        }
      }
      else{
        layer.alert(data.MsgText, "错误");
        return;
      }      
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
    
  }
  $scope.BindOrderQuery=function(){

    $(".BindOrderLoading").show();

    $http({
      method: 'get',
      url : config.ContextPath+'/web/visa/ota/BindOrderQuery.json?ID='+$scope.OrderInfo.ebo_SourceOrderNo+'&d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      var data=response.data;

      $(".BindOrderLoading").hide();
      
//      console.log(data);
      if (data.MsgID==1){
        $scope.BindOrderData=data.Data;
      }
      else{
        layer.alert(data.MsgText, "错误");
        return;
      }      
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
    
  }
  
  $scope.GetHistoryListData=function(){
    $http({
      method: 'get',
      url : config.ContextPath+'/web/visa/ota/BookingOrderHistory.json?ID='+ebo_id+'&d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      var data=response.data;

//    console.log("GetHistoryListData");
//    console.log(data);
      if (data.MsgID==1){
        $scope.HistoryListData=data.Data;
        for (i in $scope.HistoryListData){
          $scope.HistoryListData[i].type2=$scope.HistoryListData[i].type
          if ($scope.HistoryListData[i].type=='补料备注'){
            
          }
          else if  ($scope.HistoryListData[i].type=='退款备注'){
            
          }
          else if  ($scope.HistoryListData[i].type=='赔付'){
            $scope.HistoryListData[i].type='退款备注';     
          }
          else if  ($scope.HistoryListData[i].type=='须寄回材料备注'){
            
          }
          else if  ($scope.HistoryListData[i].type=='OTA操作'){
            
          }
          else  {
            $scope.HistoryListData[i].type='操作记录';            
          }
            
        }
//        console.log(layui.element);
        if (layui.element){
          layui.element.tabChange('HistoryListTab', 'HistoryListTab0');
        }
      }
      else{
        layer.alert(data.MsgText, "错误");
        return;
      }      
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
  }


  
  $scope.UpdateBookingOrderHistory2=function (index,name) {
    OpenWindowLayer(name, config.ContextPath+'/Content/BookingOrder/Form/UpdateBookingOrderHistory.jsp?ID='+ebo_id+'&Type='+name+'&d='+new Date().getTime() , function() {
      $scope.GetHistoryListData();
//      GetHistoryList();
    },{width:"calc(100vw - 400px)",height:"calc(100vh - 200px)"});
  }

  
  $scope.AddCompensation=function (index,name) {
    OpenWindowLayer(false, config.ContextPath+'/Content/BookingOrder/Form/AddCompensation.jsp?ID='+ebo_id+'&d='+new Date().getTime() , function() {
      $scope.GetHistoryListData();
      $scope.BookingOrderCost();
//      GetHistoryList();
    },{width:"calc(500px)",height:"calc(100vh - 200px)",shadeClose:true});
  }
  
  $scope.UpdatePostAddress=function(){
    var json =  {
      "OrderID" : $scope.OrderInfo['ebo_SourceOrderNo']
    };
    $http({
      method: 'post',
      data:json,
      url : config.ContextPath+'/web/visa/ota/UpdateOrderPostAddress.json',
    }).then(function successCallback(response) {
      var data=response.data;      
      //console.log(data);
      if (data.MsgID==1){
        $scope.BookingOrderInfo();
      }
      else{
        layer.alert(data.MsgText, "错误");
        return;
      }      
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
  }
  
  $scope.MessageTemplate=[];
  $scope.GetMessageTemplate=function(){

    $http({
      method: 'get',
      url : config.ContextPath+'/web/visa/ota/system/MessageTemplateGet.json?d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      var data=response.data;      
      //console.log(data);
      if (data.MsgID==1){
        $scope.MessageTemplate = data.Data;
//        console.log('GetMessageTemplate');
      }
      else{        
        return;
      }      
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
  }
  
  $scope.SelectMessageTemplate=function(){

    console.log('SelectMessageTemplate');
      $scope.SendMsgContent=$scope.MessageTemplate[$scope.SelectMessageTemplateValue]._Content;

  }
  $scope.MessageTemplateListFinish= function(){      
    if (layui.form){
      layui.form.render('select','MessageTemplateListDiv');
    }
  }

  $scope.WayBillDataGridFinish= function(){      
//    console.log('WayBillDataGridFinish');
    if (layui.table){

//      console.log('WayBillDataGridFinish2');
      layui.table.init('WayBillDataGrid', { //转化静态表格
         height: '480',limit:100

        ,done: function(res, curr, count){
          //如果是异步请求数据方式，res即为你接口返回的信息。
          //如果是直接赋值的方式，res即为：{data: [], count: 99} data为当前页数据、count为数据总长度
//          console.log('layui.table.init done');
//          console.log(res);
          $('#WayBillDataGridDiv [ng-click]').each(function(){
//            console.log(this);
            $compile(this)($scope);
          });
        }
      }); 
      
    }
  }

//  $scope.HistoryListTabFinish= function(){      
//    console.log('HistoryListTabFinish');
//    if (layui.table){
//      layui.table.init($('.HistoryListTab .layui-table'), { //转化静态表格
//        //height: 'full-500'
//      }); 
//    }
//  }
  
  $scope.WayBillData=[];

  function GetWayBillList() {
    $(".WayBillLoading").show();
    $http({
      method: 'get',
      url : config.ContextPath+'/web/SF/GetSFOrderInfo.json?ID='+$scope.OrderInfo.ebo_SourceOrderNo+'&d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      var data=response.data;      
//       console.log(data);
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
            d.index = indexNo + 1;
            jsonArrey2[indexNo] = d;
            indexNo = indexNo + 1; 
          }
        }
        $scope.WayBillData=jsonArrey2;
//        console.log($scope.WayBillData);
      }
      $(".WayBillLoading").hide();
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
    
  }
  $scope.ExpressCreate=function(){
//    console.log(id);
    OpenWindowLayer('生成快递单',config.ContextPath+'/Content/BookingOrder/Form/OrderSendGoods2019.jsp?ID=' + $scope.OrderInfo.ebo_SourceOrderNo + '&d=' + new Date().getTime(),  function() {
      GetWayBillList();
    },{height:'100%',width:'100%'});
  }

  $scope.CheckKeyWord=function(){
    LoadingShow();
    var json = {
      "content" : $scope.SendMsgContent
    };
    
    $http({
      method: 'post',
      data:json,
      url : config.ContextPath+'/zjun/v2smsvCheckKeyWord?d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      LoadingHide();
      var data=response.data;      
      if (data.MsgID != 1) {
        alert(data.MsgText);
      } else {
        if (data.Message == "没有包含屏蔽词") {
          SendMessage();
        } else {
          layer.alert(data.MsgText, "错误");
        }
      }
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
  }

  function SendMessage() {
    LoadingShow();
//    var json = {
//      "EboID" : ebo_id,
//      "mobile" :$scope.OrderInfo.ebo_Phone,
//      "content" :$scope.SendMsgContent
//    };
    var json = 'EboID='+ebo_id+'&mobile='+$scope.OrderInfo.ebo_Phone+'&content=' +$scope.SendMsgContent;
     console.log(json);

    $http({
      method: 'post',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
      }, 
      
      data:json,
      url : config.ContextPath+'/zjun/v2smsSend?&d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      LoadingHide();
      var data=response.data;      
      if (data.MsgID != 1) {
        layer.alert("短信发送失败！<br>" + data.MsgText, "错误");
      } else {
        layer.alert("短信发送成功！");
        $scope.GetHistoryListData();
      }
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
    
  }

  $scope.UpdateSaleName=function(){

    LoadingShow();
    var json = [ {
      "OrderID" :ebo_id
    } ];
    
    $http({
      method: 'post',
      data:json,
      url : config.ContextPath+'/web/visa/ota/UpdateOrderSalename.json',
    }).then(function successCallback(response) {
      LoadingHide();
      var data=response.data;          
      if (data.MsgID != 1) {
        layer.alert(data.MsgText);
      } else {
        $scope.OrderInfo.ebo_SaleName=data.SaleName;
        $scope.GetHistoryListData();
        layer.alert("销售绑定成功！");
      }
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
  }
  

  $scope.AlitripTravelVisaApplicantUpdate=function(){

    OpenWindowLayer('更新申请人信息',config.ContextPath+'/Content/BookingOrder/Form/AlitripTravelVisaApplicantUpdate.jsp?ID=' + $scope.OrderInfo.ebo_id,  function() {
      $scope.BookingOrderInfo();
    });

  }
  $scope.CreateVisaSign=function(){
    // window.open('<%=request.getContextPath()%>/Content/BookingOrder/Form/CreateVisaSign.jsp?ID='+id);
    OpenWindowLayer('生成受理号', config.ContextPath+'/Content/BookingOrder/Form/CreateVisaSign.jsp?ID='+ $scope.OrderInfo.ebo_id, function() {
      $scope.GetVisaNameList();
      $scope.GetHistoryList();
    });

  }


  $scope.PrintWayBillImage=function(path){
    console.log('PrintWayBillImage');
    OpenWindowLayer("打印快递单",config.ContextPath+'/Content/SF/Form/PrintBillImage.jsp?BillImage=/SFWayBillImage/'+path,null,{'width':'450px'});
  }

  $scope.QueryBillRoute=function(OrderID){
//    $('#WayBillDataGridDiv [ng-click]').each(function(){
//      $compile(this)($scope);
//    });
//    
//    console.log(OrderID);
//    layer.alert(OrderID);
    OpenWindowLayer("物流信息", config.ContextPath+"/Content/SF/Form/ShowOrderRoute.jsp?id=" + OrderID + "&d=" + new Date().getTime(), null, null);
  }

  
//  $scope.BookingOrderInfo();
  
  

  $scope.HistoryListTabTableFinish0=function(){
    layui.table.init('HistoryListTabTable0',{height:'275',limit:200})
  }
//
//  $scope.HistoryListTabTableFinish1=function(){
//    layui.table.init('HistoryListTabTable1',{height:'275',limit:200})
//  }
//
//  $scope.HistoryListTabTableFinish2=function(){
//    layui.table.init('HistoryListTabTable2',{height:'275',limit:200})
//  }
//
//  $scope.HistoryListTabTableFinish3=function(){
//    layui.table.init('HistoryListTabTable3',{height:'275',limit:200})
//  }
//
//$scope.HistoryListTabTableFinish4=function(){
//layui.table.init('HistoryListTabTable4',{height:'275',limit:200})
//}
  
  $scope.HistoryListTabChange=function(index){
      layui.table.init('HistoryListTabTable'+index,{height:'275',limit:200})
  }

  $scope.OpenVisaSign=function(id) {
    // window.open('<%=request.getContextPath()%>/Content/BookingOrder/Form/VisaSign.jsp?ID='+id);
    OpenWindowLayer('查看订单',WebConfig.ContextPath+'/Content/BookingOrder/Form/VisaSign.jsp?ID=' + id,  null,null);

  }
  
  $scope.CreateVisaSign_PrintVisa=function(){
    window.open('LSWebPlug:VisaLablePrint%20'+$scope.avgid);
  }
  
  $scope.UnBindOrder=function(child){
    console.log(child);
    layer.confirm('是否确认解除绑定关系？', {icon: 3, title:'提示'}, function(index){
      //do something

      LoadingShow();
      var json =  {
        "Parent" :$scope.OrderInfo['ebo_SourceOrderNo'],
        "Child":child,
      } ;
      
      $http({
        method: 'post',
        data:json,
        url : config.ContextPath+'/web/visa/ota/UnBindOrder.json',
      }).then(function successCallback(response) {
        LoadingHide();
        var data=response.data;
        if (data.MsgID != 1) {
          layer.alert(data.MsgText);
        } else {
          $scope.BindOrderQuery();
          layer.alert("订单解绑成功！");
        }
      }, function errorCallback(response) {
        // 请求失败执行代码
      });
//      console.log(1);
      layer.close(index);
    }, function(index){
      
      layer.close(index);
    });
    return;
    
  }
  $scope.BindOrder=function(){
    layui.BookingOrderSelect.Search('关联订单',function(OrderID){
//      console.log("BindOrder");
//      console.log(OrderID);

      LoadingShow();
      var json =  {
        "Parent" :$scope.OrderInfo['ebo_SourceOrderNo'],
        "Child":OrderID,
      } ;
      
      $http({
        method: 'post',
        data:json,
        url : config.ContextPath+'/web/visa/ota/BindOrder.json',
      }).then(function successCallback(response) {
        LoadingHide();
        var data=response.data;
        if (data.MsgID != 1) {
          layer.alert(data.MsgText);
        } else {

          $scope.BindOrderQuery();
          layer.alert("订单绑定成功！");
        }
      }, function errorCallback(response) {
        // 请求失败执行代码
      });
    });
  }
  $scope.OpenOrderInfo=function(EboID){
    window.open(config.ContextPath+'/Content/BookingOrder/Form/BookingOrderInfo.jsp?ID='+EboID);
  }
  
  $scope.InvoiceApplyInsert=function(){
    OpenWindowLayer('新增发票',WebConfig.ContextPath+'/Content/Invoice/InvoiceApplyInsert.jsp?ID=-1&OrderID='+ebo_id+'&d='+new Date().getTime(),  
      function(){
        console.log('InvoiceApplyInsert');
        $scope.BookingInvoiceQuery();
      }
      ,{'width':'800px','height':'650px'});
  }
  

  $scope.BookingInvoiceQuery=function(){
//    console.log("BookingInvoiceQuery");
    $http({
      method: 'get',
      url : config.ContextPath+'/web/Invoice/BookingInvoiceQuery.json?ID='+ebo_id+'&d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      var data=response.data;      

      //console.log(data);
      if (data.MsgID==1){
        $scope.InvoiceData={};
        $scope.BookingInvoice = data.Data;
        if ($scope.BookingInvoice.length>0){
          $scope.SelectInvoice(0);
        }        
      }
      else{        
        return;
      }      
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
  }
  
  $scope.CancelInvoice=function(){
    if ($scope.InvoiceData.aia_StatusType=="未开票"){
      
      layer.confirm('是否确认撤销此发票?', {icon: 3, title:'提示'}, function(index){
        //do something
        layer.close(index);

        var data={'data':[$scope.InvoiceData.aia_id]};
        
        $http({
          method: 'post',
          data:data,
          url : config.ContextPath+'/web/Invoice/CancelInvoice.json?d=' + new Date().getTime(),
        }).then(function successCallback(response) {
          var data=response.data;      
      
          //console.log(data);
          if (data.MsgID==1){
            $scope.BookingInvoiceQuery();
          }
          else{
            layer.alert(data.MsgText, "错误");
            return;
          }      
        }, function errorCallback(response) {
          // 请求失败执行代码
        });
      });       
      
      
    }
    
  }
  $scope.SelectInvoice=function(index){

//    console.log("SelectInvoice");
//    console.log($scope.BookingInvoice[index]);
    $scope.InvoiceData= $scope.BookingInvoice[index];
    $scope.InvoiceDataIndex=index;
  }

  $scope.GetInvoiceStyle=function(index){
    if ($scope.InvoiceDataIndex==index){
      return {"background-color" : "#1E9FFF","color": "white"};
    }
    else{

      return {"background-color" : "white","color": "#333",    "border-color": "#D2D2D2"};      
    }
  }
  $scope.GetCancelInvoiceStyle=function(index){
    if ($scope.InvoiceData.aia_StatusType!="未开具"){
      return {"background-color" : "white","color": "#e6e6e6",    "border-color": "#D2D2D2"};      
    }
    else{
      return {"background-color" : "#FF5722","color": "white"};

    }
  }
  
  
}); 


