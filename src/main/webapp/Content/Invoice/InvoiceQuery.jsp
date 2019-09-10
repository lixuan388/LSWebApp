
<%@page import="com.java.version"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layuihead2018.jsp" />
<script src="https://cdn.staticfile.org/angular.js/1.5.8/angular.min.js"></script>
<script src="https://cdn.staticfile.org/angular.js/1.5.0-beta.0/angular-sanitize.min.js"></script>

<link href="InvoiceQuery.css?d=20190910" rel="stylesheet">

<title>发票查询</title>
<style type="text/css">
</style>
</head>
<body id="InvoiceQueryApp" ng-app="InvoiceQueryApp" ng-controller="InvoiceQueryCtrl">
  <div class="layui-fluid" style="height: calc(100% - 15px);">
    <div class="layui-form" style="height: 100%;">
      <div class="layui-card Query" style="padding: 5px;">
        <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label">搜索：</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input"  placeholder="抬头/订单号/金额/内容" ng-model="QueryData.QueryText" style="width: 248px;" >
            </div>
          </div>
        </div>
        <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label">发票状态：</label>
            <div class="layui-input-inline" style="width: 120px;">
              <select id="" lay-filter="" ng-model="QueryData.Status" >
                <option value="" selected>全部</option>
                <option value="待开发票" selected>待开发票</option>                
                <option value="已开具" selected>已开具</option>
                <option value="已撤销" selected>已撤销</option>
                
              </select>
            </div>
          </div>
        </div>
        
        <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label">申请人：</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input" ng-model="QueryData.CreateUserName" >
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">申请时间：</label>
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
            <label class="layui-form-label">开票人：</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input" ng-model="QueryData.CWUserName" >
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">开票时间：</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input DateSelect" ng-model="QueryData.CWDateFr" >
            </div>
          </div>
          <div class="layui-inline To">
            <label class="layui-form-label ">至</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input DateSelect" ng-model="QueryData.CWDateTo" >
            </div>
          </div>
        </div>
        
        
        <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label">财务状态：</label>
            <div class="layui-input-block">
              <select id="" lay-filter=""  ng-model="QueryData.CWStatus" >
                <option value="" selected>全部</option>
                <option value="已开具" selected>已开具</option>
              </select>
            </div>
          </div>
        </div>
          
        <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label">处理人：</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input " ng-model="QueryData.TakeUserName" >
            </div>
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">处理时间：</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input DateSelect" ng-model="QueryData.TakeDateFr" >
            </div>
          </div>
          <div class="layui-inline To">
            <label class="layui-form-label ">至</label>
            <div class="layui-input-block">
              <input type="text" class="layui-input DateSelect" ng-model="QueryData.TakeDateTo" >
            </div>
          </div>
        </div>
        <div class="layui-form-item">
          <div class="layui-inline">
            <label class="layui-form-label">客服状态：</label>
            <div class="layui-input-block">
              <select id="" lay-filter="" ng-model="QueryData.TakeStatus" >
                <option value="" selected>全部</option>
                <option value="未处理" selected>未处理</option>
                <option value="已处理" selected>已处理</option>
                
              </select>
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
          
          <button class="layui-btn  layui-btn-danger " style="margin-left: 50px;" ng-click="InvoiceCheck(1)">开具发票</button>
          <button class="layui-btn  layui-btn-danger " style="margin-left: 20px;" ng-click="InvoiceCheck(2)">作废重开</button>          
          <button class="layui-btn  layui-btn-danger " style="margin-left: 20px;" ng-click="InvoiceCancel()">撒销申请</button>
          <button class="layui-btn  layui-btn-danger " style="margin-left: 20px;" ng-click="InvoiceEMail()">发送邮箱</button>
          <!-- 
          <button class="layui-btn layui-btn-normal" ng-click="DoPrint()">一键打印快递单</button>
          <button class="layui-btn layui-btn-normal" ng-click="DoInvalid()">一键标记作废</button>
          <button class="layui-btn layui-btn-normal layui-btn-disabled" ng-click="">一键交件并打印名单</button>
          <a  class="layui-btn layui-btn-primary" href="/Dpr/LSWebPlug.rar" target="_black">下载打印插件</a>
           -->
        </div>
      <div class="layui-card Grid" style="height: calc(100% - 99px);padding: 5px;overflow: auto;">
        <table class="layui-table" lay-size="sm" lay-even='true' lay-filter="InvoiceGrid">
          <thead>
            <tr>
              <th ng-repeat="col in GridColume"  lay-data="{{col.data}}" style2="width: {{col.data.width}}px;" on-finish-render-filters="GridColumeFinish"  ng-bind-html="col.title"></th>
            </tr>
          </thead>
          <tbody>
            <tr  ng-repeat="d in GridData" on-finish-render-filters="GridDataFinish" class="{{d.Valid}}" >
              <td style="width:35px" >
                <input type="hidden" ng-bind='rowIndex=$index'>                
                <input  type="checkbox" lay-skin="primary" ng-model="GridData[rowIndex].checkbox" style="padding-left: 18px;" ng-checked="GridData[rowIndex].checkbox">
              </td>
              <td  style="width:35px" >{{$index+1}}</td>
              <td style="width: 80px;">
                <div>{{GridData[rowIndex].aia_User_OP}}</div>
                <div>{{GridData[rowIndex].aia_Date_OP|DateTimeFormat}}</div>
              </td>
              
              <td style="width: 133px;">
                <div style="font-size: 11px;">{{GridData[rowIndex].Ebo_SourceName}}</div>
                <div style="font-size: 11px;">{{GridData[rowIndex].Ebo_SourceOrderNo}}</div>
                <div  ng-if="GridData[rowIndex].aia_StatusType!='已开具'">【{{GridData[rowIndex].aia_StatusType}}】</div>
              </td>
              <td style="text-align: left;">
                <div><span class="InvoiceInfo">发票类型</span><span>：<span>{{GridData[rowIndex].aia_InvoiceType|InvoiceTypeFormat}}</div>
                
                <div><span class="InvoiceInfo">发票金额</span><span>：<span>{{GridData[rowIndex].aia_Money|CurrencyFormat}}</div>
                <div><span class="InvoiceInfo">抬头</span><span>：<span>{{GridData[rowIndex].aia_Company}}</div>
                <div><span class="InvoiceInfo">开票内容</span><span>：<span>{{GridData[rowIndex].aia_Content}}</div>
                <div style="text-align: left;">
                  <div><span class="InvoiceInfo">税号</span><span>：<span></span></span><span>{{GridData[rowIndex].aia_GuestIDCode}}</span></div>
                  <div><span class="InvoiceInfo">地址</span><span>：<span><span>{{GridData[rowIndex].aia_GuestAddr}}</span></div>
                  <div><span class="InvoiceInfo">电话</span><span>：<span><span>{{GridData[rowIndex].aia_GuestTel}}</span></div>
                  <div><span class="InvoiceInfo">开户行</span><span>：<span><span>{{GridData[rowIndex].aia_GuestBankName}}</span></div>
                  <div><span class="InvoiceInfo">账号</span><span>：<span><span>{{GridData[rowIndex].aia_GuestBankCode}}</span></div>
                </div>              
              </td>     
    
              <td >{{GridData[rowIndex].aia_GuestEMail}}</td>
              <td >
                    
                <div ng-if="GridData[rowIndex].aia_User_KP!='' && GridData[rowIndex].aia_StatusType=='已开具'">
                  <div>{{GridData[rowIndex].aia_User_KP}}</div>
                  <div>{{GridData[rowIndex].aia_Date_KP|DateTimeFormat}}</div>
                  <div>【{{GridData[rowIndex].aia_StatusType}}】</div>
                </div>
                <!-- 
                <div ng-if="GridData[rowIndex].aia_User_KP==''&& GridData[rowIndex].aia_StatusType!='撤销'">
                  <div>未开具</div>
                </div>
                <div ng-if="GridData[rowIndex].aia_StatusType=='撤销'">
                  <div>撒销开具</div>
                </div>
                 -->
              </td>
              <td >
                <div ng-if="GridData[rowIndex].aia_user_Take!='' && GridData[rowIndex].aia_StatusType=='已开具'">
                  <div>{{GridData[rowIndex].aia_user_Take}}</div>
                  <div>{{GridData[rowIndex].aia_Date_Take|DateTimeFormat}}</div>
                  <div>已处理</div>
                </div>
                <div ng-if="GridData[rowIndex].aia_user_Take==''">
                  <div>未处理</div>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
  <!-- ------------------------------------------------------------------------------------------------------------ -->
  
  <script type="text/javascript">

  
  </script>
  <script src="InvoiceQuery_angular.js"></script>
  <script src="InvoiceQuery_layui.js"></script>
  
  <script src="<%=request.getContextPath() %>/Content/BookingOrder/Form/BookingOrderInfo_fileter.js?<%=version.Version%>"></script>

</body>
</html>