<%@page import="com.ecity.java.web.WebFunction"%>
<%@page import="com.java.version"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

String ID=request.getParameter("ID")==null?"":request.getParameter("ID");
if (ID.equals(""))
{
  WebFunction.GoErrerHtml(request, response,"缺少参数（ID）");
  return;
}

String OrderID=request.getParameter("OrderID")==null?"":request.getParameter("OrderID");
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<jsp:include page="/layuihead2018.jsp" />
<script src="https://cdn.staticfile.org/angular.js/1.5.8/angular.min.js"></script>
<script src="https://cdn.staticfile.org/angular.js/1.5.0-beta.0/angular-sanitize.min.js"></script>
<title>发票申请</title>
<style type="text/css">
body{
max-width: 800px;
margin: auto;
}

</style>
</head>

<body id="InvoiceApplyInsertApp" ng-app="InvoiceApplyInsertApp" ng-controller="InvoiceApplyInsertCtrl">
  <div class="layui-fluid">
    <div class="layui-form"">
      <div class="layui-card" >
        <div class="layui-card-header">
          <span class="TitleText">发票信息</span>
        </div>        
        <div class="layui-card-body">
          <!------------------------------------------------- -->
          <div class="layui-form layui-form-pane">
          
            <div class="layui-form-item">
              <label class="layui-form-label">开票状态</label>
              <div class="layui-input-block">
                <input type="text"  class="layui-input"ng-model="Data._StatusType" ReadOnly >
              </div>
            </div>
            <div class="layui-form-item">
              <label class="layui-form-label">发票类型</label>
              <div class="layui-input-block">

                <select class="form-control" ng-model="Data._InvoiceType"  ng-disabled="ReadOnly">
                  <option style='display: none' value="-1"></option>
                  <option value='1'> 增值税专用发票</option>
                  <option value='2'> 增值税普通发票</option>
                  <option value='3'> 增值税电子普通发票</option>
                </select>
              </div>
            </div>
            <div class="layui-form-item">
              <label class="layui-form-label">开票内容</label>
              <div class="layui-input-block">
                <select class="form-control"ng-model="Data._Content" ng-disabled="ReadOnly">
                  <option style='display: none' value="-1"></option>
                  <option value='旅游签证费'>旅游签证费</option>
                  <option value='旅游费'>旅游费</option>
                  <option value='旅游团费'>旅游团费</option>
                </select>
              </div>
            </div>
            <div class="layui-form-item">
              <label class="layui-form-label">发票金额</label>
              <div class="layui-input-block">
                <input type="text"  class="layui-input"ng-model="Data._Money"ng-disabled="ReadOnly">
              </div>
            </div>
            <div class="layui-form-item">
              <label class="layui-form-label">发票抬头</label>
              <div class="layui-input-block">
                <input type="text"  class="layui-input"ng-model="Data._Company"ng-disabled="ReadOnly">
              </div>
            </div>
            <div class="layui-form-item">
              <label class="layui-form-label">税号</label>
              <div class="layui-input-block">
                <input type="text"  class="layui-input"ng-model="Data._GuestIDCode"ng-disabled="ReadOnly">
              </div>
            </div>
            <div class="layui-form-item">
              <label class="layui-form-label">地址</label>
              <div class="layui-input-block">
                <input type="text"  class="layui-input"ng-model="Data._GuestAddr"ng-disabled="ReadOnly">
              </div>
            </div>
            <div class="layui-form-item">
              <label class="layui-form-label">电话</label>
              <div class="layui-input-block">
                <input type="text"  class="layui-input"ng-model="Data._GuestTel"ng-disabled="ReadOnly">
              </div>
            </div>
            <div class="layui-form-item">
              <label class="layui-form-label">开户行</label>
              <div class="layui-input-block">
                <input type="text"  class="layui-input"ng-model="Data._GuestBankName"ng-disabled="ReadOnly">
              </div>
            </div>
            <div class="layui-form-item">
              <label class="layui-form-label">账号</label>
              <div class="layui-input-block">
                <input type="text"  class="layui-input"ng-model="Data._GuestBankCode" ng-disabled="ReadOnly">
              </div>
            </div>
            <div class="layui-form-item">
              <label class="layui-form-label">电子邮箱</label>
              <div class="layui-input-block">
                <input type="text"  class="layui-input"ng-model="Data._GuestEMail" ng-disabled="ReadOnly">
              </div>
            </div>
        
          <!------------------------------------------------- -->
          </div>
        </div>
      </div>
    </div>
    <div class="layui-card">      
      <div class="layui-card-header" style="height: 0;">
      </div>        
      <div class="layui-card-body">
        <button class="layui-btn layui-btn-danger" style="width: 100%;" ng-show="ID==-1" ng-click="submit()" ng-show="CanEdit">提交数据</button>
      </div>
    </div>
  </div>
<script type="text/javascript">
var ID='<%=ID%>';
var OrderID='<%=OrderID%>';

</script>
  
  <script src="InvoiceApplyInsert_angular.js?<%=version.Version%>"></script>
  
  <script src="InvoiceApplyInsert_layui.js?<%=version.Version%>"></script>
</body>
</html>