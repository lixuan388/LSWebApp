<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
  
String BillImage=request.getParameter("BillImage")==null?"-1":request.getParameter("BillImage");
String MailNo=request.getParameter("MailNo")==null?"-1":request.getParameter("MailNo");
BillImage=BillImage.replace("\\", "/");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layuihead2018.jsp" />

<style type="text/css">
.layui-btn{
  width: 100%;
  margin-top: 10px;
  margin-bottom: 10px;
}

img{
  border: 1px solid red;
}
</style>
<title>打印快递单</title>
</head>
<body>
  <div  style="max-width:600px;padding: 20px;margin: auto;">
  
    <button class='layui-btn' onclick="PrintWayBillImage()">打印快递单</button> 
    <img style="width:100%" src="<%=BillImage%>">
    <button class='layui-btn' onclick="PrintWayBillImage()">打印快递单</button> 
  </div>

  <script type="text/javascript">
    function PrintWayBillImage() {

      if (window.Webapp){
        if (window.PrintWayBill('<%=BillImage%>')){
          layer.alert("打印成功");
        }
        else{
          layer.alert("打印失败，请重试");
        }
      }
      else{

        layer.open({
          type: 2, 
          content: 'LSWebPlug:Print%20<%=BillImage%>' 
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
            if ('<%=MailNo%>' != '-1'){
              //LoadingShow();
              var IDList={'Key':'MailNo','List':['<%=MailNo%>']};
              
              $.post(config.ContextPath+'/web/SF/ExpressPrintSuccess.json?d=' + new Date().getTime(),JSON.stringify(IDList),function(data){
                console.log(data);
                //LoadingHide();
                if (data.MsgID==1){
                  layer.alert("打印成功", function(index){
                    layer.close(index);
                  });
                }
                else{
                  layer.alert(data.MsgText, "错误");
                  return;
                }      
              },"json");
              
            }
          }
          ,btn3: function(index, layero){
            //按钮【按钮三】的回调
            window.open('/Dpr/LSWebPlug.rar');
            //return false 开启该代码可禁止点击该按钮关闭
          }
        }); 
      }
      
    }
  </script>

</body>
</html>