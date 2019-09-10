<%@ page isELIgnored="true"%>
<%@page import="com.java.version"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN" style="height: 100%;">
<head>
<jsp:include page="/layuihead.jsp" />
<title>WebApp</title>
<style type="text/css">
.layui-table-cell {
  height: inherit;
  line-height: inherit;
}

.layui-table-view .layui-form-radio>i {
  margin-right: 8px;
  font-size: 22px;
}
</style>
</head>
<body>
  <div id="MianDiv" style="position: relative; height: 100vh; padding: 10px;">
    <div class="layui-btn-group demoTable" style="margin-bottom: 10px;">
      <button class="layui-btn" layadmin-event="InsertData">新增</button>
    </div>
    <table id='OperationButtonTable' lay-filter="OperationButtonTable">
    </table>
    <script type="text/html" id="barDemo">
      <a class="layui-btn layui-btn-xs" lay-event="edit">修改</a>
      <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    </script>
    <div></div>
  </div>
  <script>
<%@ include file = "/Content/Base/Form/OperationButton.js" %>
</script>
</body>
</html>