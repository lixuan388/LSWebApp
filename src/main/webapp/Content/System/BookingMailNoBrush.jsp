<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

  <jsp:include page="/layuihead2018.jsp"/>
<script src="https://cdn.staticfile.org/angular.js/1.5.8/angular.min.js"></script>

<style type="text/css">
.doing .mark,.posting .mark {
    width: calc(100% - 40px);
    position: absolute;
    height: 100%;
    z-index: 1000;
    /*background-color: #e6e6e6;*/
    /*opacity: 0.5;*/
    display: inherit;
}
 .loadingToast,.mark {
    display: none;
}

 .loadingToast.posting {
    display: inherit;
}

.weui-mask, .weui-mask_transparent {
    position: absolute;
}

.ErrText{
  color:red;
}
</style>
<title>批量更新快递单号</title>
</head>
<body>
<div style="margin: 10px;height: calc(100vh - 20px);" 
  ng-app="BookingMailNoBrushApp" 
  ng-controller="BookingMailNoBrushCtrl" >
  <div style="width:320px;height:calc(100vh - 20px - 28px);float: left;">
    <textarea style="width:100%;height: calc(100vh - 20px - 28px);resize: none;" id ="MailNoList" ng-model="MailNoList" wrap="off" ></textarea>     
    <button class="layui-btn" ng-click='GetMailNoList()' style="width: 100%;">读取列表</button>
             
  </div>
  <div style="width:calc(100vw - 20px - 20px - 320px);height:calc(100vh - 20px);float: left;">
    <div style="padding: 0px;" class="loadingToast">
      <div class="mark">
        <div id="loadingToast" style="">
          <div class="weui-mask_transparent"></div>
          <div class="weui-toast">
            <i class="weui-loading weui-icon_toast"></i>
            <p class="weui-toast__content">数据提交中  </p>
          </div>
        </div>
      </div>
    </div>
    <div style="margin: 10px;">
      <div style="display: inline-block; margin-right: 10px;margin-bottom: 10px;" ng-repeat="b in ButtonList">
        <button class="layui-btn layui-btn-normal layui-btn-xs" ng-click='BrushMailNo(b)' style="">{{OrderStatus[b]}}【{{b}}】</button>
      </div>
      <!--  <button class="layui-btn" ng-click='BrushMailNo()' style="width: 100%;">提交快递号</button>-->
    </div>
    <div>
      <ul ng-repeat="d in Data">
        <div style="border: 1px solid silver;margin: 1px;">
          <div style="display: inline-block; width:250px;">
            <div><span>订单号:{{d.OrderID}}</span></div>
            <div><span>快递号:{{d.MailNo}}</span></div>
            <div id="MsgID{{d.OrderID}}" class="ErrText">{{d.ErrText}}</div>
          </div>
          <div style="display: inline-block; width:calc(100% - 260px)">
            <li ng-repeat="n in d.NameList">
              <div style="padding: 5px;">
                <span>客户姓名:{{n._Name}}/{{n._name_e}}</span>
                <span>护照号:{{n._passPortNo}}</span>
                <span>ID:{{n._ApplyId}}</span>
                <span>状态:{{OrderStatus[n._currentApplyStatus]}}</span>
                <span>下一步:{{n._nextApplyStatus}}</span>
              </div>
            </li>
          </div>
        </div>
      </ul>
    </div>
  </div>
</div>
<script>

var app = angular.module('BookingMailNoBrushApp', []);
app.controller('BookingMailNoBrushCtrl', function($scope, $http, $location) {
  $scope.Data=[];
  $scope.OrderStatus=GetParameterData('OrderStatus');
  
  $scope.ButtonList=[1001,1003,1004,1005,1006,1007,1009,1012,1013];
  /////////////////////////
  $scope.GetMailNoList=function(){
    $scope.MailNoList=$scope.MailNoList.replace(/[\t]/g," ").replace(/["]/g,'').replace('  ',' ');
    var MailNoList=$scope.MailNoList.split("\n");
    console.log(MailNoList);
    var Data=[];
    for (i in MailNoList){
      var d=MailNoList[i].split(" ");
      console.log(d)
      var j ={'OrderID':d[0],'MailNo':d[1]};
      Data.push(j);
    }
    $(".loadingToast").addClass('posting');
    var json ={'Data':Data}
    $http({
      method: 'POST',
      data:JSON.stringify(json),
      url:'<%=request.getContextPath() %>/web/visa/ota/BookingMailNoBruchQuery.json'
    }).then(function successCallback(response) {
      var data=response.data;
      $(".loadingToast").removeClass('posting');
      if (data.MsgID==1){
        layer.alert("数据数取成功！", "提示");
        $scope.Data=data.Data;
      }
      else{
        layer.alert(data.MsgText, "错误");
        return;
      }      
    }, function errorCallback(response) {
      // 请求失败执行代码
    });
  }
  /////////////////////////
  $scope.BrushMailNo=function(code){
    var Data=$scope.Data;

    $(".loadingToast").addClass('posting');
    var json ={'StateCode':code,'Data':Data};
    //console.log(json);
    //return;
    $http({
      method: 'POST',
      data:JSON.stringify(json),
      url:'<%=request.getContextPath() %>/web/visa/ota/BookingMailNoBruchPost.json'
    }).then(function successCallback(response) {
      var data=response.data;
      $(".loadingToast").removeClass('posting');
      if (data.MsgID==1){
        layer.alert("快递单号提交完成！", "提示");
        $scope.Data=data.Data;
        console.log(data.Data);
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
</script>
</body>
</html>