var app = angular.module('InvoiceQueryApp', ['ngSanitize']);

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
app.directive('onFinishRenderFilters', ['$timeout', function ($timeout) {
  return {
    restrict: 'A',
    link: function(scope,element,attr) {
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

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////


app.controller('InvoiceQueryCtrl', function($scope, $http, $location,$timeout,$compile) {
  
  $scope.QueryData={
  };

  $scope.GridData=[];
  

  $scope.GridColume=[
    {title:'选择',data:{width: 35}},
    {title:'序号',data:{width: 35}},
    {title:'申请人<br>申请时间',data:{width: 80}},
    {title:'来源订单号<br>发票状态',data:{width: 80}},
    {title:'发票信息',data:{}},
    {title:'电子邮箱',data:{width: 120}},
    {title:'财务开票人',data:{width: 120}},
    {title:'客服处理人',data:{width: 120}},
  ]
  
  for (i in $scope.GridColume){
    $scope.GridColume[i].data.field="a"+i;
  }
  
  $scope.Query=function(){
    LoadingShow();
    $http({
      method: 'post',
      data:$scope.QueryData,
      url : config.ContextPath+'/web/Invoice/InvoiceQuery.json?d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      var data=response.data;
      LoadingHide();
      console.log(data);
    
      $scope.OrderDetil=[];
      if (data.MsgID==1){
        $scope.GridData=data.Data;
        
//        console.log($scope.GridData.length);
        if ($scope.GridData.length==0){
          //$('[lay-filter="ExpressGrid"]').find('tbody').html('');
          $timeout(function () {
            //layui.ExpressQueryLayui.ExpressGridInit();
          });
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

  $scope.GridDataFinish=function(){
    if (layui.table){
      layui.InvoiceQueryLayui.GridInit();
      
      $('.layui-table-body .layui-table tbody tr').each(function(){
        $compile(this)($scope);
      });   

    }

    if (layui.form){
      layui.form.render();
    }
  }
  
  $scope.GridColumeFinish=function(){
    if (layui.table){
      layui.InvoiceQueryLayui.GridInit();
    }
  }
  


  $scope.SelectAllOn=function(){
    for (i in $scope.GridData){
      $scope.GridData[i].checkbox=true;
    }

    $timeout(function () {
      layui.form.render();
    });
  }
  $scope.SelectAllOff=function(){
    for (i in $scope.GridData){
      $scope.GridData[i].checkbox=false;
    }
    $timeout(function () {
      layui.form.render();
    });
  }

  $scope.InvoiceCheck=function(Type){
    var data=[];
    for (i in $scope.GridData){
      if ($scope.GridData[i].checkbox==true){
        data.push($scope.GridData[i].aia_id);
      }
    }
    console.log(data);
    if (data.length==0){
      layer.alert('请勾选开票记录！', "错误");
      return;
    }

    layer.confirm('是否确认开票?', {icon: 3, title:'提示'}, function(index){
      //do something
      layer.close(index);
      var json={'Data':data,'Type':Type};

      $http({
        method: 'post',
        data:json,
        url : config.ContextPath+'/web/Invoice/CheckInvoice.json?d=' + new Date().getTime(),
      }).then(function successCallback(response) {
        var data=response.data;      
    
        //console.log(data);
        if (data.MsgID==1){
          $scope.Query();
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


  $scope.InvoiceCancel=function(){
    var data=[];
    for (i in $scope.GridData){
      if ($scope.GridData[i].checkbox==true){
        data.push($scope.GridData[i].aia_id);
      }
    }
    if (data.length==0){
      layer.alert('请勾选撒销记录！', "错误");
      return;
    }

    layer.confirm('是否确认撒销?', {icon: 3, title:'提示'}, function(index){
      //do something
      layer.close(index);
      var json={'Data':data};

      $http({
        method: 'post',
        data:json,
        url : config.ContextPath+'/web/Invoice/CancelInvoice.json?d=' + new Date().getTime(),
      }).then(function successCallback(response) {
        var data=response.data;      
    
        //console.log(data);
        if (data.MsgID==1){
          $scope.Query();
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

  $scope.InvoiceEMail=function(){
    var data=[];
    for (i in $scope.GridData){
      if ($scope.GridData[i].checkbox==true){
        data.push($scope.GridData[i].aia_id);
      }
    }
    if (data.length==0){
      layer.alert('请勾选发送记录！', "错误");
      return;
    }

    layer.confirm('是否确认发送邮箱?', {icon: 3, title:'提示'}, function(index){
      //do something
      layer.close(index);
      var json={'Data':data};

      $http({
        method: 'post',
        data:json,
        url : config.ContextPath+'/web/Invoice/EMailInvoice.json?d=' + new Date().getTime(),
      }).then(function successCallback(response) {
        var data=response.data;      
    
        //console.log(data);
        if (data.MsgID==1){
          $scope.Query();
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
  
  
});

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
