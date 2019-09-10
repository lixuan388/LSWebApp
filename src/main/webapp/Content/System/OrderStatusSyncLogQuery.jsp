<%@ page isELIgnored="true" %>
<%@page import="com.java.version"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN"	style="height: 100%;">
<head>
	<jsp:include page="/layuihead2018.jsp"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/res/js/alitrip.js?d=<%=version.Version%>"></script>
	<title>WebApp</title>
	
	<style type="text/css">
.layui-table-cell {
    height: inherit;
}	
	.layui-btn{
		margin-right: 10px;
	}
  .logTextIcon{
    display: inline-block;
    transition: all 0.2s linear 0s;
  }
  .logText{
    transition: all 1s linear 0s;
  }
  .logTextIcon.open{
    transform: rotate(180deg);
  }
	</style>
</head> 
<div  style="position: relative;height: calc(100vh - 20px);padding: 10px;">

        <div class="layui-form" style2="margin-top: 10px; margin-left: 20px;">
          <div class="layui-form-item">
            <div class="layui-inline">
              <label class="layui-form-label">推送情况：</label>
              <div class="layui-input-inline" style="width: 120px;">
                <select id="QueryStatus" lay-filter="QueryStatus">
                  <option value="" selected>全部</option>
                  <option value="0" >推送成功</option>
                  <option value="1" >推送失败</option>
                </select>
              </div>
            </div>
            <div class="layui-inline" style="margin-right: 0px;">
              <label class="layui-form-label">推送日期：</label>
              <div class="layui-input-inline" style="width: 95px;">
                <input type="text" name="QueryDateFr" autocomplete="off" class="layui-input " id="QueryDateFr">
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label" style="width: 15px;">至</label>
              <div class="layui-input-inline" style="width: 95px;">
                <input type="text" name="QueryDateTo" autocomplete="off" class="layui-input " id="QueryDateTo">
              </div>
            </div>
            <div class="layui-inline">
              <button class="layui-btn layui-btn-xs" layadmin-event="Query">查询</button>
            </div>
          </div>  
        </div>
        <div style="margin: 10px 20px; border: 1px solid silver;"></div>

	<table id='OrderStatusSyncTable' lay-filter="OrderStatusSyncTable">

	</table>

</div>
<script type="text/html" id="EosCodeTpl">
	<div style="line-height: 1.5em;display: inline-block;">
		<div>{{d.ebon_currentApplyStatus}}</div>
		<div>{{VisaStateName[d.ebon_currentApplyStatus]}}</div>
	</div>
	<i class="layui-icon layui-icon-next"></i>
	<div style="line-height: 1.5em;display: inline-block;">
		<div>{{d.ebon_SyncState}}</div>
		{{VisaStateName[d.ebon_SyncState]}}
	</div>
</script>


<script type="text/html" id="eboSourceordernoTpl">
	<div style="line-height: 1.5em;">
		<a href="javascript:;" lay-event="OpenOrder" title="打开订单">
			<span>{{d.ebo_sourceorderno}}</span>
			<i class="layui-icon layui-icon-search"></i>
		</a>
	</div>
</script>


<script type="text/html" id="ebonIDTpl">
  <div style="line-height: 1.5em;">
    <div>{{d.ebon_id}}</div>
    <div>applyid:{{d.ebon_applyid}}</div>
  </div>
</script>

<script type="text/html" id="SyncDateTpl">
    <div style="line-height: 1.5em;"><span style="white-space: normal;">{{d.ebon_SyncDate}}</span></div>
</script>

<script type="text/html" id="PackageNameTpl">
    <div style="line-height: 1.5em;"><span style="white-space: normal;">{{d.ebo_packagename}}</span></div>
</script>




<script type="text/html" id="ResultTpl">
  <div style="line-height: 1.5em;text-align: left;">
    <a href="javascript:;" lay-event="OpenLog" title="查看日志记录">
{{# if (d.ebon_SyncFlag==false){}}
    <span style="color:red">推送失败</span>
{{#} else {}}
    <span style="color:blue">推送成功</span>    
{{#}}}
      <i class="layui-icon  logTextIcon">&#xe625;</i>
    </a>
    <div class="logText"></div>
  </div>
</script>



<script>
<%@ include file = "/Content/System/OrderStatusSyncLogQuery.js" %>
</script>
</html>