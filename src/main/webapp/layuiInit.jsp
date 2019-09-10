<%@page import="com.java.version"%>
<%@ page language="java" contentType="application/javascript; charset=UTF-8" pageEncoding="UTF-8"%>


var layuiTableName='<%=request.getContextPath().substring(1)%>.layuiAdmin'

layui.cache.tableName =layuiTableName;
var WebConfig={};

WebConfig.tableName =layuiTableName;
WebConfig.ContextPath='<%=request.getContextPath()%>';

layui.cache.base = WebConfig.ContextPath + '/layuiadmin/';
layui.cache.ContextPath = WebConfig.ContextPath ;

WebConfig.Version='<%=version.Version%>';
layui.cache.version = WebConfig.Version ;
layui.cache.tableName =layuiTableName;


var config=WebConfig;

 