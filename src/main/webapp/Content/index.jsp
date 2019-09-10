<%@page import="com.ecity.java.web.ls.Parameter.Json.SourceSupplierInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.SourceInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.VisaTypeJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.VisaSpeedJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.CountryJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.EVisaAreaJson"%>
<%@page import="com.ecity.java.mvc.service.system.SystemService"%>
<%@page import="com.java.version"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Iterator" %>

<!DOCTYPE html>
<html lang="zh-CN" >
<head>

  <meta charset="utf-8">
  <title>后台管理模板系统</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="../layuiadmin/layui/css/layui.css" media="all">
  <link rel="stylesheet" href="../layuiadmin/style/admin.css" media="all">
	<link href="<%=request.getContextPath() %>/res/css/Default.css" rel="stylesheet">
  <script type="text/javascript" src="/Res/js/date.js"></script>
  
		<script src="/Res/js/jquery.min.js"></script>

	<script type="text/javascript" src="/Res/js/ECityAlert.js"></script>
	<script src="/Res/js/bootstrap.min.js"></script>
	<!-- <link href="/Res/css/bootstrap.css" rel="stylesheet"> -->
<script src="https://cdn.staticfile.org/angular.js/1.5.8/angular.min.js"></script>
		
    
  <script src="../layuiadmin/layui/layui.js"></script>
  
  <script src="<%=request.getContextPath() %>/layuiInit.jsp"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/res/js/ParameterData.js?20190805"></script>
  
  
<style type="text/css">
.main-layout-side .m-logo {

    width: 100%;
    height: 40px;
    background: #00b5f9;
    text-align: center;
    line-height: 40px;
    font-weight: 800;
    font-size: 20px;
    color: white;
    font-style: oblique;
}
.layui-nav .layui-nav-item {
    line-height: 40px;
}

</style>
</head> 
<body >
<body class="layui-layout-body">
  
  <div id="LAY_app">
    <div class="layui-layout layui-layout-admin">
      <div class="layui-header">
        <!-- 头部区域 -->
        <ul class="layui-nav layui-layout-left">
          <li class="layui-nav-item layadmin-flexible" lay-unselect>
            <a href="javascript:;" layadmin-event="flexible" title="侧边伸缩" lay-tips="侧边伸缩">
              <i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
            </a>
          </li>
          <li class="layui-nav-item" lay-unselect>
            <a href="javascript:;" layadmin-event="refresh" title="刷新">
              <i class="layui-icon layui-icon-refresh-3"></i>
            </a>
          </li>
        </ul>
        <ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">
          <li class="layui-nav-item" lay-unselect>
            <a lay-hrefx="app/message/index.html" layadmin-event="message" lay-text="消息中心">
              <i class="layui-icon layui-icon-notice"></i>  
              
              <!-- 如果有新消息，则显示小圆点 -->
              <span class="layui-badge-dot"></span>
            </a>
          </li>
          <li class="layui-nav-item layui-hide-xs" lay-unselect>
            <a href="javascript:;" layadmin-event="theme">
              <i class="layui-icon layui-icon-theme"></i>
            </a>
          </li>
          <li class="layui-nav-item layui-hide-xs" lay-unselect>
            <a href="javascript:;" layadmin-eventx="note">
              <i class="layui-icon layui-icon-note"></i>
            </a>
          </li>
          <li class="layui-nav-item layui-hide-xs" lay-unselect>
            <a href="javascript:;" layadmin-event="fullscreen">
              <i class="layui-icon layui-icon-screen-full"></i>
            </a>
          </li>
          <li class="layui-nav-item" lay-unselect>
            <a href="javascript:;">
              <cite>【<%=request.getSession().getAttribute("DepartmentName") %>】<%=request.getSession().getAttribute("UserName") %></cite>
            </a>
            <dl class="layui-nav-child">
              <dd><a lay-hrefX="set/user/info.html">基本资料</a></dd>
              <dd><a lay-hrefX="set/user/password.html">修改密码</a></dd>
              <hr>
              <dd layadmin-event="logout" style="text-align: center;"><a>退出</a></dd>
            </dl>
          </li>
          
          <li class="layui-nav-item layui-hide-xs" lay-unselect>
            <a href="javascript:;" layadmin-event="about"><i class="layui-icon layui-icon-more-vertical"></i></a>
          </li>
          <li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-unselect>
            <a href="javascript:;" layadmin-event="more"><i class="layui-icon layui-icon-more-vertical"></i></a>
          </li>
        </ul>
      </div>
      
      <!-- 侧边菜单 -->
      <div class="layui-side layui-side-menu">
        <div class="layui-side-scroll">
          <div class="layui-logo" lay-hrefX="home/console.html">
            <span>WebApp管理系统</span>
          </div>
          <ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
          </ul>
        </div>
      </div>

      <!-- 页面标签 -->
      <div class="layadmin-pagetabs" id="LAY_app_tabs">
        <div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
        <div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div>
        <div class="layui-icon layadmin-tabs-control layui-icon-down">
          <ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
            <li class="layui-nav-item" lay-unselect>
              <a href="javascript:;"></a>
              <dl class="layui-nav-child layui-anim-fadein">
                <dd layadmin-event="closeThisTabs"><a href="javascript:;">关闭当前标签页</a></dd>
                <dd layadmin-event="closeOtherTabs"><a href="javascript:;">关闭其它标签页</a></dd>
                <dd layadmin-event="closeAllTabs"><a href="javascript:;">关闭全部标签页</a></dd>
              </dl>
            </li>
          </ul>
        </div>
        <div class="layui-tab" lay-unauto lay-allowClose="true" lay-filter="layadmin-layout-tabs">
          <ul class="layui-tab-title" id="LAY_app_tabsheader">
            <li lay-id="home" lay-attr="home" class="layui-this"><i class="layui-icon layui-icon-home"></i><span style="padding: 0px 10px;display: inline-block;">控制台</span></li>
          </ul>
        </div>
      </div>
      
      
      <!-- 主体内容 -->
      <div class="layui-body" id="LAY_app_body">
        <div class="layadmin-tabsbody-item layui-show" style="overflow: scroll;">
					<jsp:include page="/Content/HomePage.jsp"/>
        </div>
      </div>

      <!-- 辅助元素，一般用于移动设备下遮罩 -->
      <div class="layadmin-body-shade" layadmin-event="shade"></div>
    </div>
  </div>

    <script src="menuList.js?d=<%=version.Version%>"></script>
  <script src="mainIndex.js?d=<%=version.Version%>"></script>
<script type="text/javascript">
  var VisaAreaName=<%=new EVisaAreaJson().GetJsonDataString()%>
  SetParameterData('VisaAreaName',VisaAreaName);
  var StatusName=<%=new SystemService().GetBookingOrderStatusNameJson().toString()%>; 
  SetParameterData('StatusName',StatusName);

  var CountryName = <%=new CountryJson().GetJsonDataString()%>
  SetParameterData('CountryName',CountryName);
  var VisaSpeedName= <%=new VisaSpeedJson().GetJsonDataString()%>
  SetParameterData('VisaSpeedName',VisaSpeedName);
  var VisaTypeName= <%=new VisaTypeJson().GetJsonDataString()%>
  SetParameterData('VisaTypeName',VisaTypeName);
  var SourceInfoName= <%=new SourceInfoJson().GetJsonDataString()%>
  SetParameterData('SourceInfoName',SourceInfoName);
  var SourceSupplierInfoName= <%=new SourceSupplierInfoJson().GetJsonDataString()%>
  SetParameterData('SourceSupplierInfoName',SourceSupplierInfoName);
  
  

  var OrderStatus=<%=new SystemService().GetOrderStatusJson().toString()%>; 
  SetParameterData('OrderStatus',OrderStatus);
  
  
</script>

</body>
</html>
