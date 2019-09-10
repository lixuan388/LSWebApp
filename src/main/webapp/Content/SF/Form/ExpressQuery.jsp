
<%@page import="com.java.version"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layuihead2018.jsp" />
<script src="https://cdn.staticfile.org/angular.js/1.5.8/angular.min.js"></script>
<script src="https://cdn.staticfile.org/angular.js/1.5.0-beta.0/angular-sanitize.min.js"></script>

<link href="ExpressQuery.css" rel="stylesheet">

<title>物流单处理</title>
<style type="text/css">
</style>
</head>
<body id="ExpressQueryApp" ng-app="ExpressQueryApp" ng-controller="ExpressQueryCtrl">
  <div class="layui-fluid" style="height: calc(100% - 23px);">
    <div class="layui-form" style="height: 100%;">
      <div class="layui-card Query" style="padding: 5px;">
        <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label">搜索：</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input" ng-model="QueryData.QueryText" style="width: 248px;" >
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">操作人：</label>
            <div class="layui-input-block"  style="width: 100px;">
              <input type="text" class="layui-input" ng-model="QueryData.CreateUserName" >
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">打印状态：</label>
            <div class="layui-input-block" style="width: 100px;">
              <select name="city"  ng-model="QueryData.PrintState" >
                <option value="">全部</option>
                <option value="未打印">未打印</option>
                <option value="已打印">已打印</option>
                <option value="无需打印">无需打印</option>
              </select>
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">有效性：</label>
            <div class="layui-input-block" style="width: 100px;">
              <select name="city"  ng-model="QueryData.Valid" >
                <option value="">全部</option>
                <option value="有效">有效</option>
                <option value="无效">无效</option>
              </select>
            </div>
          </div>
        </div>
        
        <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label">生成时间：</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input DateSelect" ng-model="QueryData.CreateDateFr" >
            </div>
          </div>
          <div class="layui-inline To">
            <label class="layui-form-label ">至</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input DateSelect" ng-model="QueryData.CreateDateTo" >
            </div>
          </div>
        </div>
        
        <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label">打印时间：</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input DateSelect" ng-model="QueryData.PrintDateFr" >
            </div>
          </div>
          <div class="layui-inline To">
            <label class="layui-form-label ">至</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input DateSelect" ng-model="QueryData.PrintDateTo" >
            </div>
          </div>
        </div>
        
        <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label">交件时间：</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input DateSelect" ng-model="QueryData.ReceiveDateFr" >
            </div>
          </div>
          <div class="layui-inline To">
            <label class="layui-form-label ">至</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input DateSelect" ng-model="QueryData.ReceiveDateTo" >
            </div>
          </div>
        </div>
        
        <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label">交件人：</label>
            <div class="layui-input-block"  style="width: 100px;">
              <input type="text" class="layui-input" ng-model="QueryData.ReceiveName" >
            </div>
          </div>
        </div>
        <div class="layui-form-item">
          <button class="layui-btn layui-btn-danger" ng-click="Query()">查询</button>
        </div>
      </div>  
        <div class=""style="background-color: #fff;padding: 5px;">
          <button class="layui-btn " ng-click="SelectAllOn()">全选</button>
          <button class="layui-btn " ng-click="SelectAllOff()">全不选</button>
          <button class="layui-btn layui-btn-normal" ng-click="DoPrint()">一键打印快递单</button>
          <button class="layui-btn layui-btn-normal" ng-click="DoInvalid()">一键标记作废</button>
          <button class="layui-btn layui-btn-normal layui-btn-disabled" ng-click="">一键交件并打印名单</button>
          <a  class="layui-btn layui-btn-primary" href="/Dpr/LSWebPlug.rar" target="_black">下载打印插件</a>
        </div>
      <div class="layui-card Grid" style="height: calc(100% - 141px);padding: 5px;overflow: auto;">
        <table class="layui-table" lay-size="sm" lay-even='true' lay-filter="ExpressGrid">
          <thead>
            <tr>
              <th ng-repeat="col in GridColume"  lay-data="{{col.data}}" style="width: {{col.data.width}}px;" on-finish-render-filters="GridColumeFinish">{{col.title}}</th>
            </tr>
          </thead>
          <tbody>
            <tr  ng-repeat="d in GridData" on-finish-render-filters="GridDataFinish" class="{{d.Valid}}" >
              <td >
                <input type="hidden" ng-bind='rowIndex=$index'>
                
                <input  type="checkbox" lay-skin="primary" ng-model="GridData[rowIndex].checkbox" ng-checked="GridData[rowIndex].checkbox">
              </td>
              <td >{{$index+1}}</td>
              <td >{{GridData[rowIndex].CreateDateStr}}</td>
              <td >{{GridData[rowIndex].PayType|PayType}}</td>
              <td ><div>{{GridData[rowIndex].MailNo}}</div></td>
              <td >{{GridData[rowIndex].SourceOrderNo}}</td>
              <td ><div ng-bind-html="GridData[rowIndex].Bind"></div></td>
              <td >{{GridData[rowIndex].Valid}}</td>
              <td >{{GridData[rowIndex].CreateUserName}}</td>
              <td >{{GridData[rowIndex].PrintState}}</td>
              <td >{{GridData[rowIndex].PrintDateStr}}</td>
              <td >{{GridData[rowIndex].ReceiveName}}</td>
              <td >{{GridData[rowIndex].ReceiveDate}}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <!-- ------------------------------------------------------------------------------------------------------------ -->
  <script src="ExpressQuery_angular.js?123"></script>
  <script src="ExpressQuery_layui.js"></script>
</body>
</html>