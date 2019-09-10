<%@ page isELIgnored="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  
String  ID=request.getParameter("ID")==null?"":request.getParameter("ID");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layuihead.jsp" />
<title></title>
</head>
<body>
  <div style="padding: 20px;">
    <form class="layui-form" action="" lay-filter="table">
      <div class="layui-form-item">
        <label class="layui-form-label">名称</label>
        <div class="layui-input-block">
          <input type="text" name="_name" autocomplete="off" placeholder="请输入操作名称 " class="layui-input" FieldName="_name">
        </div>
      </div>
      <div class="layui-form-item">
        <label class="layui-form-label">控件</label>
        <div class="layui-input-block">
          <input type="text" name="_ButtonName" autocomplete="off" placeholder="请输入控件名称 " class="layui-input" FieldName="_ButtonName">
        </div>
      </div>
      <div class="layui-form-item">
        <label class="layui-form-label">排序</label>
        <div class="layui-input-block">
          <input type="text" name="_index" autocomplete="off" class="layui-input" FieldName="_index">
        </div>
      </div>
      <div class="layui-form-item">
        <label class="layui-form-label">状态</label>
        <div class="layui-input-block">
          <input type="text" name="_status" autocomplete="off" class="layui-input" FieldName="_status">
        </div>
      </div>
      <input type="hidden" name="_id" FieldName="_id">
    </form>
    <div>
      <div style="width: calc(50% - 5px); padding: 10px; display: inline-block;">
        <button style="width: 100%;" class="layui-btn" data-type="PostData">保存</button>
      </div>
      <div style="width: calc(50% - 5px); padding: 10px; display: inline-block;">
        <button style="width: 100%;" class="layui-btn layui-btn-danger" data-type="CloseWindows">关闭</button>
      </div>
    </div>
  </div>
  <script>
layui.config({
  base: '<%=request.getContextPath() %>/layuiadmin/' //静态资源所在路径
}).extend({
  index: 'lib/index' //主入口模块
}).use(['index','form'], function(){
  var form = layui.form
  ,admin=layui.admin;

  $body = $('body');
 
  //表单初始赋值
  form.val('table', {
    "_id": "-1" // "name": "value"
    ,"_name": ""
    ,"_ButtonName": ""
    ,"_index": 1000
    ,"_status": "I"
  })
  var events={

    CloseWindows:function()
    {
      var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
      parent.layer.close(index); //再执行关闭   
    }
    ,Query:function()
    {
      <%
      if (!ID.equals(""))
      {
      %>
      admin.req({
        url: '<%=request.getContextPath() %>/web/system/OperationButtonQuery.json'
        ,type: 'get'
        ,data: {
          ID: <%=ID%>
        }
        ,success: function(res){
          if (res.MsgID==-1)
          {
            if (<%=ID%>!=-1)
            {
              layer.alert(res.MsgText,  function(index){
                //do something            
                layer.close(index);
                active.CloseWindows();
              });
            }
          }
          else{
            form.val('table', {
              "_id": res.Data[0]._id// "name": "value"
              ,"_name": res.Data[0]._name
              ,"_index": res.Data[0]._index
              ,"_ButtonName": res.Data[0]._ButtonName
              ,"_status": res.Data[0]._status
            })
          }
        }
      });
      <%
      }
      %>
    }
    
    ,PostData:function()
    {
      var $loadingToast =loadingToast();
      var Data={}
      $("form  [FieldName]").each(function(){
          var FieldName='sob'+$(this).attr("FieldName");
          var FieldValue=$(this).val();
          Data[FieldName]=FieldValue;
        })
        
      if (Data.sob_ButtonName=='')
      {
          alertLayer('请填写控件名称！');
          return;
      }
      if (Data.sob_name==''){
        alertLayer('请填写名称！');
        return;
      }
        
        
        
        var DataRows=[];  
        DataRows[0]=Data; 
        var json={"DataRows":DataRows};
        
        //console.log(json);
        //return;
        admin.req({
          url: '<%=request.getContextPath() %>/web/system/OperationButtonPost.json',
              type : 'post',
              data : JSON.stringify(json),
              success : function(res) {

                $loadingToast.modal("hide");
                if (res.MsgID == '-1') {
                  layer.alert(res.MsgText, function(index) {
                    //do something            
                    layer.close(index);
                  });
                } else {
                  layer.alert('保存成功！', function(index) {
                    //do something            
                    layer.close(index);
                    active.CloseWindows();
                  });
                }
              }
            });

          }
        }

        //点击事件
        $body.on('click', '*[data-type]', function() {
          var othis = $(this)

          , attrEvent = othis.attr('data-type');
          //console.log($(this));
          events[attrEvent] && events[attrEvent].call(this, othis);
        });

        events.Query();

      });
    </script>
</body>
</html>