
<%@page import="com.ecity.java.web.ls.Parameter.Json.AreaJson"%>
<%@ page isELIgnored="true"%>
<%@page import="com.java.version"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN" style="height: 100%;">
<head>
<jsp:include page="/layuihead2018.jsp" />
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

.layui-table-view  .layui-form-checkbox {
  margin-right: 5px;
}
.checkboxDiv{
  display: inline-block;
  float: left;
  margin: 5px;
}

</style>
</head>
<body>
  <div id="MianDiv" style="position: relative; height: calc(100vh - 20px); padding: 10px;">
    <div class=" demoTable" style="margin-bottom: 10px;">
      <div class="layui-form" style2="margin-top: 10px; margin-left: 20px;">
        <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label" style="width: 45px;">区域：</label>
            <div class="layui-input-inline" style="width: 200px;">
              <select id="SelectArea"><option value="0">全部</option></select>
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label" style="width: 45px;">搜索：</label>
            <div class="layui-input-inline" style="width: 320px;">
              <input type="text" name="QueryText" autocomplete="off" class="layui-input" placeholder="国家名称" id="QueryText">
            </div>
          </div>
          <div class="layui-inline">
            <button class="layui-btn layui-btn-normal" layadmin-event="Query">查询</button>
          </div>
          <div class="layui-inline">
            <button class="layui-btn layui-btn-danger" layadmin-event="PostData">保存</button>
          </div>
        </div>
      </div>
      <div style="margin: 10px 20px; border: 1px solid silver;"></div>
    </div>
    <table id='CountryOperationButtonTable' lay-filter="CountryOperationButtonTable">
    </table>
    <div></div>
  </div>

<script type="text/html" id="barDemo">
  <div></div>
</script>
      
<script type="text/html" id="act_nameTpl">
  <div style="line-height: 3em;">{{d.act_name}}</div>
</script>
      
  <script>
  var AreaName = <%=new AreaJson().GetJsonDataString()%>  
<%@ include file = "/Content/Base/Form/CountryOperationButton.js" %>
</script>
</body>
</html>