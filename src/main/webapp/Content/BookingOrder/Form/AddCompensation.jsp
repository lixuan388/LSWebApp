<%@page import="com.ecity.java.web.WebFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String ID=request.getParameter("ID")==null?"":request.getParameter("ID");
if (ID.equals(""))
{
  WebFunction.GoErrerHtml(request, response, "缺少参数（ID）");
  return;
}
%>      
<!DOCTYPE html>
<html  style="height: 100%;">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/layuiadmin/layui/css/layui.css" media="all">
<link href="<%=request.getContextPath() %>/res/css/Default.css" rel="stylesheet">
<title>赔付</title>
</head>
<body style="height: 100%;">


      <div class="layui-card">
        <div class="layui-card-header">
          <span class="TitleText">赔付</span>  
        </div>
        
        <form class="layui-form layui-form-pane" action="" lay-filter="HistoryForm" style="height: 100%;" >
        
          <input type="hidden" name="eboID" value="<%=ID%>">
          <input type="hidden" name="Type" value="赔付">
          <div class="layui-card-body CostCard">
            <div class="layui-form-item">
              <div class="layui-inline " style="width:100%;">
                <label class="layui-form-label">赔付金额</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" name="Money" value="0" >
                </div>
              </div>
  
              <div class="layui-form-item layui-form-text" style="height: calc(100vh - 170px);"> 
                <div class="layui-input-block" style="height: 100%;">
                  <textarea placeholder="请输入内容" class="layui-textarea" id="LAY_editor" name="Remark" style="height: 100%;resize: none;" ></textarea>
                </div>
              </div>
              <div class="layui-form-item">
                <button class="layui-btn" lay-submit="" lay-filter="post" style="width: calc(50% - 42px);margin-left: 20px;margin-right: 20px;">保存</button>
                <button class="layui-btn layui-btn-danger" lay-submit="" lay-filter="Close" style="width: calc(50% - 42px);margin-left: 20px;margin-right: 20px;">关闭</button>
              </div>
      
            </div>
          </div>
        </form>
      </div>
      
      
  
<script type="text/javascript" src="/Res/js/layer/layui/layui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/layuiInit.jsp"></script>

<script>
layui.extend({
  index : 'lib/index' // 主入口模块
}).use([ 'index', 'admin','form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,admin = layui.admin
  ,layedit = layui.layedit
  ,laydate = layui.laydate
  ,setter = layui.setter;

  //监听提交
  form.on('submit(post)', function(data){
    console.log(data);
    data.field.Remark=data.field.Remark+";金额："+data.field.Money;
    admin.req({
      url : setter.ContextPath+'/web/visa/ota/UpdateBookingOrderHistory.json' // 实际使用请改成服务端真实接口
      ,type : 'post',
      data : JSON.stringify(data.field),
      success : function(res) {
        console.log(res);
        if (res.MsgID!=1){
          layer.alert(res.MsgText);
          return false;
        }
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.layer.close(index); //再执行关闭   
        return false;
      }
    });
    return false;
  });

  //监听提交
  form.on('submit(Close)', function(data){
    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
    parent.layer.close(index); //再执行关闭   
  });
  
});
</script>  
</body>
</html>