<%@page import="com.ecity.java.web.WebFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String ID=request.getParameter("ID")==null?"":request.getParameter("ID");
if (ID.equals(""))
{
  WebFunction.GoErrerHtml(request, response, "缺少参数（ID）");
  return;
}
String Type=request.getParameter("Type")==null?"操作备注":request.getParameter("Type");

//byte[] byteArray1=Type.getBytes("ISO-8859-1");//这个很安全，UTF-8不会造成数据丢失

//Type=new String(byteArray1,"UTF-8");
    

%>      
<!DOCTYPE html>
<html  style="height: 100%;">
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<%=request.getContextPath() %>/layuiadmin/layui/css/layui.css" media="all">
<title><%=Type%></title>
</head>
<body style="height: 100%;">
  <form class="layui-form layui-form-pane" action="" lay-filter="HistoryForm" style="height: 100%;" >
    <input type="hidden" name="eboID" value="<%=ID%>">
    <input type="hidden" name="Type" value="<%=Type%>">
    <div class="layui-form-item layui-form-text" style="height: calc(100% - 70px);"> 
      <div class="layui-input-block" style="height: 100%;">
        <textarea placeholder="请输入内容" class="layui-textarea" id="LAY_editor" name="Remark" style="height: 100%;resize: none;" ></textarea>
      </div>
    </div>
    <div class="layui-form-item">
      <button class="layui-btn" lay-submit="" lay-filter="post" style="width: calc(100% - 40px);margin-left: 20px;margin-right: 20px;">保存</button>
    </div>
  </form>
  
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
  
});
</script>  
</body>
</html>