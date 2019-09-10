var app = angular.module('InvoiceApplyInsertApp', ['ngSanitize']);

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


app.controller('InvoiceApplyInsertCtrl', function($scope, $http, $location,$timeout,$compile) {
  $scope.Data={};
  
  $scope.ID=ID;
  $scope.ReadOnly=true;
  $scope.Query=function(){
    LoadingShow();
    $http({
      method: 'get',
      url : config.ContextPath+'/web/Invoice/InvoiceApplyOpen.json?ID='+ID+'&OrderID='+OrderID+'&d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      var data=response.data;
      LoadingHide();
      console.log(data);
    
      $scope.Data={};
      if (data.MsgID==1){
        $scope.Data=data.Data;
        if (ID==-1){
          $scope.ReadOnly=false;
        }
        if (layui.form){
          $timeout(function () {
            layui.form.render();
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
  $scope.Query();
  
  $scope.submit=function(){
    if ($scope.Data._InvoiceType==-1){
      layer.alert("请选择【发票类型】！", "错误");
      return;
    }

    if ($scope.Data._Content==''){
      layer.alert("请填写【开票内容】！", "错误");
      return;
    }
    if (isNaN($scope.Data._Money)){
      layer.alert("【发票金额】格式错误！", "错误");
      return;
    }

    if ($scope.Data._Money*1.00<=0){
      layer.alert("【发票金额】必需大于0！", "错误");
      return;
    }

    if ($scope.Data._Company==''){
      layer.alert("请填写【发票抬头】！", "错误");
      return;
    }
    
    LoadingShow();
    var json={"Data":$scope.Data};
    $http({
      method: 'post',
      data:json,
      url : config.ContextPath+'/web/Invoice/InvoicePost.json',
    }).then(function successCallback(response) {
      var data=response.data;
      LoadingHide();
      console.log(data);
    
      if (data.MsgID==1){
        $scope.ID=data._id;
        $scope.ReadOnly=true;

        $timeout(function () {
          layui.form.render();
        });
        layer.alert("数据保存成功！",function(){
          var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
          parent.layer.close(index); //再执行关闭     
        });
      }
      else{
        layer.alert(data.MsgText, "错误");
        return;
      }      
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
  }
  
});

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////


