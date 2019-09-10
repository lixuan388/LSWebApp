
var app = angular.module('TimeTaskLogApp', []);
app.controller('TimeTaskLogCtrl', function($scope, $http, $interval) {
  $scope.Data=[];
  $scope.InitDate;
  /////////////////////////
  Init=function(){
    //console.log('do Init' );
    $http({
      method: 'GET',
      url:config.ContextPath+'/web/system/TimeTaskLog.json'
    }).then(function successCallback(response) {
      var data=response.data;
      if (data.MsgID==1){
        $scope.Data=data.Data;
        $scope.InitDate=new Date().Format('yyyy-MM-dd HH:mm:ss');
        //console.log(data.Data);
      }
      else{
        layer.alert("获取作业状态失败！<br>"+data.MsgText, "错误");
        return;
      }      
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
  }
  Init();
  $interval(Init, 1000*60);
}); 