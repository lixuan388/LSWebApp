var app = angular.module('OrderSendGoodsApp', []);

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

app.controller('OrderSendGoodsCtrl', function($scope, $http, $location,$timeout,$compile) {
  
  $scope.QueryText="";  
  $scope.MailPayType=1;
  $scope.OrderDetil=[];
  $scope.OrderDetilListtCount=[];
  $scope.CanCreateExpress=false;
  $scope.CanPrintExpress=false;
  $scope.contactor={};
  $scope.MailCheckBox=0;
  $scope.AddrDifferent=false;

  $scope.SendPhone='';
  $scope.SendMsgContent='';

  $scope.invoice='发票待处理';
  
  
  $scope.Query=function(){
    if ($scope.QueryText==""){
      layer.alert('请输入查询条件！', "错误");
      return;
    }
    layui.BookingOrderSelect.Query($scope.QueryText,function(OrderID){
      $scope.OpenBookingInfo(OrderID);
    });
  }
  
  $scope.OpenBookingInfo=function(ID){

    LoadingShow();
    $http({
      method: 'get',
      url : config.ContextPath+'/web/visa/ota/BookingOrderInfoQuery.json?ID='+ID+'&d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      var data=response.data;
      LoadingHide();
      console.log(data);

      $scope.OrderDetil=[];
      if (data.MsgID==1){
        $scope.AddrDifferent=false;
        
        for (i in data.NameList){
          data.NameList[i].checkbox=true;
        }
        
        $scope.OrderDetil.push(data);
        $scope.contactor=data.contactor;
        $scope.SendPhone=data.OrderInfo._Phone;
        $scope.CanCreateExpress=true;
        $scope.CanPrintExpress=false;
        
        var BindOrder=data.BindOrder;
        for (i in BindOrder){
          for (j in BindOrder[i].NameList){
            BindOrder[i].NameList[j].checkbox=false;
          }
          $scope.OrderDetil.push(BindOrder[i]);
          if (BindOrder[i].contactor.post_address!=$scope.contactor.post_address){

            $scope.AddrDifferent=true;
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

  $scope.OrderDetilListTabFinish=function(){
    console.log('OrderDetilListTabFinish');
    if (layui.element){
      layui.element.render();      
    }

    if (layui.form){
      layui.form.render(null,'OrderDetilListTab');
    }
    $('.layui-colla-content:first').addClass('layui-show');

    $('.OrderDetilTitle'+$scope.MailCheckBox).addClass('OrderDetilTitleMailCheckBox');
    $('.OrderDetilTitle'+$scope.MailCheckBox).addClass('OrderDetilTitleSelect');
    
  }
  $scope.OrderDetilListTabFinish2=function(){
    console.log('OrderDetilListTabFinish');
    if (layui.form){
      layui.form.render(null,'OrderDetilListTab');
    }
  }
  $scope.OrderDetilListTableFinish=function(){
//    console.log('OrderDetilListTableFinish');
//    if (layui.form){
//      layui.form.render('checkbox','OrderDetilListTab');
//    }
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
//          console.log('GetMessageTemplate');
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

  $scope.ExpressCode='';
  $scope.BillImage='';

  $scope.CreateExpress= function(){      
    //console.log(data.field);
//    console.log($scope.contactor);

    LoadingShow();
    
    var jsonData={
      "PayType": $scope.MailPayType,
      "Document": 'off',
      "invoice": $scope.invoice,
      "SMS": $scope.SendMsgContent==''?'off':'on',
      "Province": $scope.contactor.post_province,
      "City": $scope.contactor.post_city,
      "County":$scope.contactor.post_area,
      "Contact":$scope.contactor.name,
      "Tel": $scope.contactor.phone,
      "Address": $scope.contactor.post_address,
      "SendPhone": $scope.SendPhone,
      "SendMsgContent": $scope.SendMsgContent,
      "SourceOrderNo": $scope.OrderDetil[$scope.MailCheckBox].OrderInfo._SourceOrderNo,
      "EboID": $scope.OrderDetil[$scope.MailCheckBox].OrderInfo._id,
    }
//    console.log(jsonData);
//    return;
    
    var orderData=[]
    for (i in $scope.OrderDetil){

      var orderDetil={}

      orderDetil.OrderID=$scope.OrderDetil[i].OrderInfo._SourceOrderNo;
      orderDetil.EboID=$scope.OrderDetil[i].OrderInfo._id;
      orderDetil.SendGoodsList=$scope.OrderDetil[i].OrderInfo.SendGoodsList;
      orderDetil.contactor=$scope.OrderDetil[i].contactor;
      orderDetil.SendInvoice=$scope.invoice;
      orderDetil.checkList=$.map($scope.OrderDetil[i].NameList,function(value,index){
        if (value.checkbox){
          return value;
        }
        else {
          return null;
        }
      })
      if (orderDetil.checkList.length>0){
        orderData.push(orderDetil);
      }
    }

    jsonData.OrderList=orderData;
    console.log(jsonData);
    if (jsonData.OrderList.length==0){
      LoadingHide();
      layer.alert("请选择客人！", "错误");        
      return ;
    }

    $http({
      method: 'post',
      data:jsonData,
      url : config.ContextPath+'/web/visa/ota/OrderSendGoods.json',
    }).then(function successCallback(response) {
      var data=response.data;
      LoadingHide();
      console.log(data)
      if (data.MsgID!=1){
        layer.alert(data.MsgText, "错误");        
      }
      else{        
        $scope.ExpressCode=data.MailNo;
        if (data.BillImage==''){
          $scope.BillImage='';
        }
        else{

          $scope.BillImage="/SFWayBillImage/"+data.BillImage;
        }
        $scope.CanPrintExpress=true;
      }
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
    
  };
  
  function PrintWayBillImage(MailNo,path) {
    OpenWindowLayer("打印快递单",config.ContextPath+"/Content/SF/Form/PrintBillImage.jsp?MailNo="+MailNo+"&BillImage="+path,null,{'width':'600px'});    
  }
  
  $scope.OpenBillImage=function(){
    PrintWayBillImage($scope.ExpressCode,$scope.BillImage);
  }

  $scope.CheckAll=function(index,value){
    for (i in $scope.OrderDetil[index].NameList){
      $scope.OrderDetil[index].NameList[i].checkbox=value;      
    }
    layui.form.render(null,'OrderDetilListTab');
  }
  
  $scope.OrderTitleClick=function(index){
    console.log(index);
    $('.OrderDetilDiv .layui-colla-content').removeClass('layui-show');
    $('.OrderDetilDiv'+index+' .layui-colla-content ').addClass('layui-show');
    
    $('.OrderDetilTitleSelect').removeClass('OrderDetilTitleSelect');
    $('.OrderDetilTitle'+index+'').addClass('OrderDetilTitleSelect');
    
  }
  $scope.GetMessageTemplate();
  
  if (ID!=''){
//    $scope.QueryText=ID;
    $scope.OpenBookingInfo(ID);
  }  
});