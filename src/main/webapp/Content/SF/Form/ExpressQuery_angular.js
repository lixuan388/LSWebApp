var app = angular.module('ExpressQueryApp', ['ngSanitize']);

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


app.controller('ExpressQueryCtrl', function($scope, $http, $location,$timeout,$compile) {
  $scope.QueryData={
  };
  
  $scope.GridData=[];
  
  $scope.GridColume=[
    {title:'选择',data:{field:'checkbox',width: 30}},
    {title:'序号',data:{field:'a1',width: 30}},
    {title:'生成时间',data:{field:'a2',width: 80}},
    {title:'快递方式',data:{field:'a3',width: 80}},
    {title:'物流单号',data:{field:'a4',width: 110}},
    {title:'主订单号',data:{field:'a5'}},
    {title:'关联订单',data:{field:'a6',width: 100}},
    {title:'物流状态',data:{field:'a7',width: 80}},
    {title:'操作人',data:{field:'a8',width: 80}},
    {title:'打印状态',data:{field:'a9',width: 80}},
    {title:'打印时间',data:{field:'a10',width: 80}},
    {title:'交件人',data:{field:'a11',width: 80}},
    {title:'交件时间',data:{field:'a12',width: 80}},
  ]
  
  $scope.Query=function(){
    //      if ($scope.QueryText==""){
    //        layer.alert('请输入查询条件！', "错误");
    //        return;
    //      }
    LoadingShow();
    $http({
      method: 'post',
      data:$scope.QueryData,
      url : config.ContextPath+'/web/SF/ExpressQuery.json?d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      var data=response.data;
      LoadingHide();
      console.log(data);
    
      $scope.OrderDetil=[];
      if (data.MsgID==1){
        $scope.GridData=data.Data;
        
        
        for (i in $scope.GridData){
          var OrderList=$scope.GridData[i].OrderList;
          if (OrderList.length<=1){
            $scope.GridData[i].Bind="无";            
          }
          else {

            $scope.GridData[i].Bind="";            
            for (j in OrderList ){
              if (OrderList[j].OrderID!=$scope.GridData[i].SourceOrderNo){
                $scope.GridData[i].Bind=$scope.GridData[i].Bind+"<div>"+OrderList[j].OrderID+"</div>";   
              }
            }
          }
        }
        console.log($scope.GridData.length);
        if ($scope.GridData.length==0){
          //$('[lay-filter="ExpressGrid"]').find('tbody').html('');
          $timeout(function () {
            layui.ExpressQueryLayui.ExpressGridInit();
          });
//          
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
  $scope.GridColumeFinish=function(){
    if (layui.table){
      layui.ExpressQueryLayui.ExpressGridInit();
    }
  }

  $scope.GridDataFinish=function(){
    if (layui.table){
      layui.ExpressQueryLayui.ExpressGridInit();
      
      $('.layui-table-body .layui-table tbody tr').each(function(){
        $compile(this)($scope);
      });   

    }

    if (layui.form){
      layui.form.render();
    }
  }
  $scope.DoInvalid=function(){
    var List=[];
    for (i in $scope.GridData){
      if ($scope.GridData[i].checkbox){
        List.push($scope.GridData[i]._id.$oid)
      }
    }
    console.log(List);
    if (List.length==0){

      layer.alert('请勾选要作废的记录！', "错误");
      return;
    }
    LoadingShow();
    $http({
      method: 'post',
      data:{'List':List},
      url : config.ContextPath+'/web/SF/ExpressInvalid.json?d=' + new Date().getTime(),
    }).then(function successCallback(response) {
      var data=response.data;
      LoadingHide();
      console.log(data);
    
      $scope.OrderDetil=[];
      if (data.MsgID==1){
        layer.alert("作废成功", function(index){
          
          layer.close(index);
          $scope.Query();
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
  $scope.DoPrint=function(){
    var BillImageList=[];
    var IDList=[];
    for (i in $scope.GridData){
      if ($scope.GridData[i].checkbox){
        BillImageList.push($scope.GridData[i].BillImage)
        IDList.push($scope.GridData[i]._id.$oid)
      }
    }
    console.log(BillImageList);
    if (BillImageList.length==0){

      layer.alert('请勾选要作废的记录！', "错误");
      return;
    }
    var url='';
    for (i in BillImageList){
      url=url+'%20/SFWayBillImage/'+BillImageList[i];
    }
    console.log(url);
    
    layer.open({
      type: 2, 
      content: 'LSWebPlug:Print'+url 
      ,area: ['500px', '300px']
      ,offset: 'auto'
      ,btn: ['取消', '打印成功', '下载打印插件']
      ,yes: function(index, layero){
        //按钮【按钮一】的回调
        layer.close(index);        
      }
      ,btn2: function(index, layero){
        //按钮【按钮二】的回调
        layer.close(index);        
        LoadingShow();
        $http({
          method: 'post',
          data:{'Key':'_id','List':IDList},
          url : config.ContextPath+'/web/SF/ExpressPrintSuccess.json?d=' + new Date().getTime(),
        }).then(function successCallback(response) {
          var data=response.data;
          LoadingHide();
          console.log(data);
          if (data.MsgID==1){
            layer.alert("打印成功", function(index){
              layer.close(index);
              $scope.Query();
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
      ,btn3: function(index, layero){
        //按钮【按钮三】的回调
        window.open('/Dpr/LSWebPlug.rar');
        //return false 开启该代码可禁止点击该按钮关闭
      }
    });
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
});

/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

app.filter('PayType', function() { //可以注入依赖
    return function(text) {
//      console.log('PayType:'+text);
      if (!isNaN(text)){
//        console.log('!isNaN');
        text=text*1;
        switch(text) {
        case 1:
//          console.log('寄付月结');
          return '寄付月结';
        case 2:
//          console.log('到付寄出');
          return '到付寄出';
        case 3:
//          console.log('客人自取');
          return '客人自取';
        case 4:
//          console.log('材料退件');
          return '材料退件';
        default:
//          console.log('default:'+text);
          return text;
        } 
         
      }
      else{
        console.log('isNaN');
        return text;
      }
    }
});
