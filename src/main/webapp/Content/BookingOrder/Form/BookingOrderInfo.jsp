<%@page import="com.ecity.java.web.WebFunction"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.SupplierInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.CountryJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
<%@page import="com.ecity.java.json.JSONObject"%>
<%@page import="com.ecity.java.web.ls.Content.BookingOrder.BookingOrderInfoClass"%>
<%@page import="com.java.version"%>
<%@	page isELIgnored="true"%>
<%@	page language="java" contentType="text/html;	charset=UTF-8" pageEncoding="UTF-8"%>
<%
  

String ID=request.getParameter("ID")==null?"":request.getParameter("ID");
if (ID.equals(""))
{
  WebFunction.GoErrerHtml(request, response,"缺少参数（ID）");
  return;
}
%>
<!DOCTYPE	html>
<html lang="zh-CN" style="height: 100%;">
<head>
<title>订单详情</title>
<jsp:include page="/layuihead2018.jsp" />

<script type="text/javascript" src="/Res/js/Base64.js"></script>
<script src="https://cdn.staticfile.org/angular.js/1.5.8/angular.min.js"></script>


<style>
.layui-form-item .layui-inline {
  margin-bottom: 0px;
  margin-right: 0px;
}
.layui-form-item {
  margin-bottom: 1px;
}
.OrderInfo span.value {
    min-width: 150px;
    display: inline-block;
}
.OrderInfo span.TitleText14 {
    min-width: 100px;
    text-align: justify;
    text-align-last: justify;
    display: inline-block;
}

table.layui-table tr th {
  text-align: center;
  color:#000;
}

table.layui-table tr td {
  text-align: center;
  color:#000;
}

.layui-table-cell {
  height: inherit;
}

.layui-table-view .layui-table[lay-size="sm"] .layui-table-cell {
  height: inherit;
  line-height: inherit;
}

.layui-table-cell, .layui-table-tool-panel li {
  white-space: inherit;
}
.layui-col-md12 + .layui-col-md12 {
    margin-top: 5px;
}


.CostCard label{
  float: initial;
  width: 100%;
  text-align: center;
}
.CostCard .layui-input{
  padding-left: 0;
  text-align: right;
}

.CostCard .layui-input-block{
  margin-left: 0;
}
.CostCard .layui-inline{
  border: 1px solid silver;
}



</style>
</head>
<body id="BookingOrderInfoApp" ng-app="BookingOrderInfoApp"   ng-controller="BookingOrderInfoCtrl" >
  <div id="BookingOrderInfoDiv" class="layui-fluid" >
    <div class="layui-row layui-col-space15">
      <!-- ------------------------------------------------------------------------------------- -->
      <div class="layui-col-md6">
        <div class="layui-card">
          <div class="layui-card-header"><span class="TitleText">短信通知</span></div>
          <div class="layui-card-body">
            <div class="layui-form layui-form-pane">
              <div class="layui-form-item ">           
                <div class="layui-inline " style="width: calc(50% - 2px);">
                  <label class="layui-form-label">接收手机号</label>
                  <div class="layui-input-block">
                    <input type="text" class="layui-input" id="SendMsgPhone" type="text" ng-model='OrderInfo.ebo_Phone'>
                  </div>
                </div>
                <div class="layui-inline" style="width: calc(50% - 2px);">
                  <label class="layui-form-label">通知模板</label>
                  <div class="layui-input-block layui-form"  lay-filter="MessageTemplateListDiv">
                    <select class="form-control" id="MessageTemplateList" ng-change="SelectMessageTemplate()"  ng-model="SelectMessageTemplateValue">
                      <option style='display: none'></option>
                      <option ng-repeat="mt in MessageTemplate" value="{{$index}}" on-finish-render-filters="MessageTemplateListFinish"  >{{mt._Title}}</option>
                    </select>
                  </div>
                </div>
              </div>
              <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">文本域</label>
                <div class="layui-input-block">
                  <textarea id="SendMsgContent" class="layui-textarea" style="height: 199px; resize: none;" ng-model="SendMsgContent"></textarea>
                </div>
              </div>
              <button type="button" class="layui-btn layui-btn-normal" ng-click="CheckKeyWord()" style="margin-top: 5px; width: 100%;">短信发送</button>
            </div>
          </div>
        </div>
      </div>
      <!-- ------------------------------------------------------------------------------------- -->
      <div class="layui-col-md6">
        <div class="layui-card">
          <div class="layui-card-header" style="height: inherit;">
            <span class="TitleText">发票信息</span>
            <button class="layui-btn layui-btn-danger" style="margin-left: 10px;"   ng-click="InvoiceApplyInsert()">新增发票</button>
            
            <button class="layui-btn layui-btn-primary" ng-repeat="Invoice in BookingInvoice " style="margin-left: 5px;" ng-style="GetInvoiceStyle($index)"  ng-click="SelectInvoice($index)">发票{{$index+1}}【{{Invoice.aia_StatusType}}】</button>            
            
          </div>
          
          <div class="layui-card-body">
              <div class="layui-form-item">
                <label class="layui-form-label">开票状态</label>
                <div class="layui-input-block">
                  <input type="text"  class="layui-input"ng-model="InvoiceData.aia_StatusType" ng-disabled="InvoiceReadOnly" style="width: calc(100% - 99px);display: inline-block;">
                  
                  <button class="layui-btn layui-btn-primary" style="" ng-style="GetCancelInvoiceStyle($index)"  ng-click="CancelInvoice(InvoiceData.aia_id)">撤销发票</button>  
                  
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">发票类型</label>
                <div class="layui-input-block"> 
                
                  <input type="text"  class="layui-input"  value="{{InvoiceData.aia_InvoiceType|InvoiceTypeFormat}}" ng-disabled="InvoiceReadOnly">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">开票内容</label>
                <div class="layui-input-block">
                  <input type="text"  class="layui-input"ng-model="InvoiceData.aia_Content" ng-disabled="InvoiceReadOnly">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">发票金额</label>
                <div class="layui-input-block">
                  <input type="text"  class="layui-input"ng-model="InvoiceData.aia_Money"ng-disabled="InvoiceReadOnly">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">发票抬头</label>
                <div class="layui-input-block">
                  <input type="text"  class="layui-input"ng-model="InvoiceData.aia_Company"ng-disabled="InvoiceReadOnly">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">税号</label>
                <div class="layui-input-block">
                  <input type="text"  class="layui-input"ng-model="InvoiceData.aia_GuestIDCode"ng-disabled="InvoiceReadOnly">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">地址</label>
                <div class="layui-input-block">
                  <input type="text"  class="layui-input"ng-model="InvoiceData.aia_GuestAddr"ng-disabled="InvoiceReadOnly">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">电话</label>
                <div class="layui-input-block">
                  <input type="text"  class="layui-input"ng-model="InvoiceData.aia_GuestTel"ng-disabled="InvoiceReadOnly">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">开户行</label>
                <div class="layui-input-block">
                  <input type="text"  class="layui-input"ng-model="InvoiceData.aia_GuestBankName"ng-disabled="InvoiceReadOnly">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">账号</label>
                <div class="layui-input-block">
                  <input type="text"  class="layui-input"ng-model="InvoiceData.aia_GuestBankCode" ng-disabled="InvoiceReadOnly">
                </div>
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label">电子邮箱</label>
                <div class="layui-input-block">
                  <input type="text"  class="layui-input"ng-model="InvoiceData.aia_GuestEMail" ng-disabled="ReadOnly">
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    
      <!-- ------------------------------------------------------------------------------------- -->
     
      <div class="layui-col-md12">
        <div class="layui-card">
          <div class="layui-card-header">
            <span class="TitleText">销售客服：</span> <span class="TitleTagText" FieldName="ebo_SaleName">【{{OrderInfo.ebo_SaleName}}】</span>
            <button type="button" class="layui-btn layui-btn-primary"  ng-click="UpdateSaleName()">绑定销售</button>
            <span class="TitleText" style="margin-left: 20px;">签证子单：</span>
            <button type="button" class="layui-btn layui-btn-primary" ng-click="AlitripTravelVisaApplicantUpdate()">更新申请信信息</button>
            <button id="CreateVisaSignBtn" type="button" class="layui-btn layui-btn-primary" ng-show='CanCreateVisaSign'  ng-click="CreateVisaSign()">生成受理号</button>
            <button  type="button" class="layui-btn layui-btn-primary " ng-hide='avgid==-1'  ng-click="CreateVisaSign_PrintVisa()">打印标签</button>
          </div>
          
          <div class="layui-card-body">
            <div style="overflow: auto; width: 100%;  position: relative;min-height: 100px;">
              <table class="layui-table" lay-size="sm" lay-even='true'id="VisaDataGrid" lay-filter="VisaDataGrid" style="overflow: auto; height2: 300px;">
                <thead>
                  <tr>
                    <th style="width: 13px;" >序号</th>
                    <th >姓名</th>
                    <!--<th >护照号</th>-->
                    <th >OTA状态</th>
                    <th >签证状态</th>
                    <th >预计出签时间</th>
                    <th style="width: 24px;" >产品类型</th>
                    <th >国家</th>
                    <th >产品</th>
                    <th >工作日</th>
                    <th >金额</th>
                    <th >差额</th>
                    <th >成交金额</th>
                    <th >受理号</th>
                  </tr>
                </thead>
                <tbody>
                  <tr  ng-repeat="n in BookingOrderNameList ">
                    <td >{{$index+1}}</td>
                    <td >
                      <div >{{n.ebon_Name}}</div>
                      <div style="color: #959595;">{{n.ebon_PassPort|PassPortFormat}}</div>
                    </td>
                    <td >{{n.ebon_StatusOTA2}}</td>
                    <td >{{n.ebon_StatusVisa2}}</td>
                    <td >{{n.avg_date_rtn}}</th>
                    <td >{{n.ebop_id_Ept|ProductTypeNameFormat}}</td>
                    <td style="width: 36px;">{{n.ebop_id_act|CountryNameFormat}}</td>
                    <td >
                      <div>{{n.ebop_ProductName}}</div>
                      <div style="color: #959595;">产品编号：{{n.ebop_ProductCode}}</div>
                    </td>
                    <td >{{n.ebop_day}}</td>
                    <td >{{n.ebop_Money |CurrencyFormat}}</td>
                    <td >{{n.ebop_AddMoney |CurrencyFormat}}</td>
                    <td >{{n.ebop_SaleMoney |CurrencyFormat}}</td>
                    <td ><button class='layui-btn' ng-show='n.ebon_id_avg!=-1' ng-click='OpenVisaSign(n.ebon_id_avg)'>查看</button></td>
                  </tr>
                </tbody>
              </table>
              <div class="VisaLoading" style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 0px; background-color: #9e9e9e33; text-align: center;">
                <i class="weui-loading Loading"></i>
              </div>
            </div>
          </div>
      </div>
    </div>
    
    <!-- ------------------------------------------------------------------------------------- -->
    
    <div class="layui-col-md12">
      <div class="layui-card">
        <div class="layui-tab layui-tab-card HistoryListTab"  lay-filter="HistoryListTab">
          <ul class="layui-tab-title" >
            <li lay-id="HistoryListTab{{$index}}" class="" ng-repeat="li in HistoryList " on-finish-render-filters="HistoryListTabFinish"  ><span class="TitleText">{{li}}</span> <span class="layui-badge" ng-hide="HistoryListCount[$index]<=0">{{HistoryListCount[$index]}}</span><div></div></li>
          </ul>
          <div class="layui-tab-content" style="height: 325px;" >
            <div class="layui-tab-item " ng-repeat="li in HistoryList ">
              <div role="tabpanel" class="tab-pane " id="historyList{{$index}}" style="height:100%" >
                <div style="margin-top: 5px; position: relative; height: 100%;">
                  <div>
                      <input type="hidden" ng-bind="HistoryListDataIndex=$index">
                      <button type="button" class="layui-btn layui-btn-primary" ng-click="UpdateBookingOrderHistory2($index,li)" HistoryIndex="{{$index}}" HistoryName="{{li}}" style="width: 100%" ng-hide="li=='操作记录'" >增加{{li}}备注</button>
                  </div>
                  <div style="overflow: auto; width: 100%; height: calc(100% - 35px);margin-top: 5px;">
                    <table class="layui-table"  lay-size="sm" lay-even='true' id="HistoryListDataGrid{{$index}}" style="overflow: auto; " lay-filter="HistoryListTabTable{{$index}}">
                      <thead>
                        <tr>
                          <th lay-data="{field:'index', width:30}" style="width: 30px;">序号</th>
                          <th lay-data="{field:'date', width:140}"  style="width: 140px;">日期</th>
                          <th lay-data="{field:'OpName', width:50}"  style="width: 50px;">操作人</th>
                          <th lay-data="{field:'Type', width:60}"  style="width: 50px;">类型</th>
                          <th lay-data="{field:'Remark'}" >备注</th>
                        </tr>
                      </thead>
                      <tbody>                    
                        <tr  ng-repeat="h in HistoryListData | filter:{type:li}" on-finish-render-filters="HistoryListTabTableFinish{{HistoryListDataIndex}}" > 
                          <input type="hidden" ng-bind="HistoryListCount[HistoryListDataIndex]=$index+1">
                          <td >{{$index+1}}</td>
                          <td >{{h.date}}</td>
                          <td >{{h.OpName}}</td>
                          <td >{{h.type2}}</td>
                          <td ><div style="text-align: left;">{{h.Remark}}</div></td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>          
      </div>
    </div>
    
    
    <!-- ------------------------------------------------------------------------------------- -->
    
    <div class="layui-col-md12">
      <div class="layui-card">
        <div class="layui-card-header"><span class="TitleText">订单信息</span></div>
        <div class="layui-card-body">
          <div style="padding: 10px;" class="OrderInfo layui-form layui-form-pane  layui-row">
            <div class="layui-form-item">
              <div class="layui-inline layui-col-md4">
                <label class="layui-form-label">OTA来源</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_SourceName" readonly>
                </div>
              </div>
              <div class="layui-inline layui-col-md4">
                <label class="layui-form-label">OTA订单号</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_SourceOrderNo" readonly>
                </div>
              </div>
              <div class="layui-inline layui-col-md4">
                <label class="layui-form-label">昵称</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_SourceGuest" readonly  style="width: calc(100% - 82px);display: inline-block;">
                  <a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid={{OrderInfo.ebo_SourceGuest}}&site=cntaobao&s=1&charset=utf-8" style="display: inline-block;">
                    <img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid={{OrderInfo.ebo_SourceGuest}}&site=cntaobao&s=1&charset=utf-8" alt="点击这里给我发消息"/></a>
                    
                  <!--
                    <span class="TitleText14">昵称</span><span>：</span><span class="value">{{OrderInfo.ebo_SourceGuest}}<a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid={{OrderInfo.ebo_SourceGuest}}&site=cntaobao&s=1&charset=utf-8">
                    <img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid={{OrderInfo.ebo_SourceGuest}}&site=cntaobao&s=1&charset=utf-8" alt="点击这里给我发消息"/></a></span>
                  -->
                </div>
              </div>
            </div>
    
            <div class="layui-form-item">
              <div class="layui-inline layui-col-md4">
                <label class="layui-form-label">邮箱</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_EMail" readonly>
                </div>
              </div>
              <div class="layui-inline layui-col-md4">
                <label class="layui-form-label">微信</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_WeiXin" readonly>
                </div>
              </div>
              <div class="layui-inline layui-col-md4">
                <label class="layui-form-label">QQ号码</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_QQ" readonly>
                </div>
              </div>
            </div>
            
            <div class="layui-form-item">
              <div class="layui-inline layui-col-md6">
                <label class="layui-form-label">支付日期</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_PayDate" readonly>
                </div>
              </div>
              <div class="layui-inline layui-col-md6">
                <label class="layui-form-label">到账日期</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_AccountDate" readonly>
                </div>
              </div>
            </div>
            
            <div class="layui-form-item">
              <div class="layui-inline layui-col-md6">
                <label class="layui-form-label">联系人</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_LinkMan" readonly>
                </div>
              </div>
              <div class="layui-inline layui-col-md6">
                <label class="layui-form-label">手机</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_Phone" readonly>
                </div>
              </div>
            </div>
            
            <div class="layui-form-item">
                <label class="layui-form-label">地址</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_Addr" readonly>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">订单备注</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_Remark" readonly>
                </div>
            </div>
            
            <div class="layui-form-item">
            
              <div class="layui-inline layui-col-md6">
                <label class="layui-form-label">订单金额</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_PayMoney" readonly>
                </div>
              </div>
              <div class="layui-inline layui-col-md6">
                <label class="layui-form-label">到账金额</label>
                <div class="layui-input-block">
                  <input type="text" class="layui-input" ng-model="OrderInfo.ebo_AccountMoney" readonly>
                </div>
              </div>              
            </div>
            
            
            <div></div>
            <div style="margin-top: 5px;">
              <a role="button" class="layui-btn layui-btn-primary" href="<%=request.getContextPath()%>/Content/TaoBao/Form/alitripInfo.jsp?id={{OrderInfo.ebo_SourceOrderNo}}&d=<%=request.getSession().getLastAccessedTime()%>" target="_blank">查看原始数据</a> 
              <a role="button" class="layui-btn layui-btn-primary" href="<%=request.getContextPath()%>/taobao/api/alitripTravelTradeQuery.json?OrderID={{OrderInfo.ebo_SourceOrderNo}}&U=true&d=<%=request.getSession().getLastAccessedTime()%>" target="_blank">刷新订单数据</a>
              <a role="button" class="layui-btn layui-btn-primary" ng-click="UpdatePostAddress()" href="javascript:void(0);">同步联系人信息</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    <!-- ------------------------------------------------------------------------------------- -->
    <div class="layui-col-md12">
      <div class="layui-card">
        <div class="layui-card-header">
          <span class="TitleText">关联订单</span>
          <button type="button" class="layui-btn layui-btn-primary" ng-click="BindOrder()">关联订单</button></div>
        
        <div class="layui-card-body">
          <div style="overflow: auto; width: 100%; position: relative;" id="BindOrderGridDiv">
            <table class="layui-table" lay-size="sm" lay-even='true' id="WayBillDataGrid" lay-filter="BindOrderGrid" style="overflow: auto;"  >
              <thead>
                <tr>
                  <th lay-data="{field:'a1',width:30}" style="width: 30px;">序号</th>
                  <th lay-data="{field:'a2',width:160}" style="width: 30px;">OTA来源</th>
                  <th lay-data="{field:'a3',width:50}" style="width: 100px;">OTA订单号</th>
                  <th lay-data="{field:'a4',width:60}" style="width: 80px;">订单状态</th>
                  <th lay-data="{field:'a4',width:60}" style="width: 80px;">成交日期</th>
                  <th lay-data="{field:'a4',width:60}" style="width: 80px;">昵称</th>
                  <th lay-data="{field:'a4',width:60}" style="width2: 50px;">成交商品</th>
                  <th lay-data="{field:'a4',width:60}" style="width: 50px;">数量</th>
                  <th lay-data="{field:'a4',width:60}" style="width: 80px;">送签领区</th>
                  <th lay-data="{field:'a4',width:60}" style="width: 80px;">金额</th>
                  <th lay-data="{field:'a4',width:60}" style="width: 100px;">联系人</th>
                  <th lay-data="{field:'a4',width:60}" style="width: 80px;">操作</th>
                </tr>
              </thead>
              <tbody>                  
                <tr  ng-repeat="b in BindOrderData " on-finish-render-filters="BindOrderDataGridFinish" > 
                  <td >{{$index+1}}</td>
                  <td >{{b.ebo_sourcename}}</td>
                  <td ><div>{{b.Ebo_SourceOrderNo}}</div>
                  <div><button type="button" class="layui-btn layui-btn-xs layui-btn-primary" style="width:100%" ng-click="OpenOrderInfo(b.ebo_id)">打开订单</button></div>
                  </td>
                  
                  <td >{{b.ebo_statustype}}</td>
                  <td >{{b.ebo_paydate|DateTimeFormat}}</td>
                  <td >
                    <div>{{b.ebo_sourceguest}}</div>
                    <div>
                      <a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid={{b.ebo_sourceguest}}&site=cntaobao&s=1&charset=utf-8" >
                        <img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid={{b.ebo_sourceguest}}&site=cntaobao&s=1&charset=utf-8" alt="点击这里给我发消息" />
                      </a>
                    </div>
                  </td>
                  <td >{{b.ebo_packagename}}</td>
                  <td >{{b.NameCount}}</td>
                  <td >{{b.ebo_id_eva|AreaNameFormat}}</td>
                  <td >{{b.ebo_paymoney |CurrencyFormat}}</td>
                  <td ><div>{{b.ebo_linkman}}</div><div>{{b.ebo_phone}}</div></td>
                  <td ><div><button type="button" class="layui-btn layui-btn-primary" ng-click="UnBindOrder(b.Ebo_SourceOrderNo)">取消关联</button></div></td>                  
                </tr>
              </tbody>
            </table>
            <div class="BindOrderLoading" style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 0px; background-color: #9e9e9e33; text-align: center;">
              <i class="weui-loading Loading"></i>
            </div>
          </div>          
        </div>
      </div>
    </div>
    <!-- --------------------------------成本利润-------------------------------------------- -->
    <div class="layui-col-md12">
      <div class="layui-card">
        <div class="layui-card-header">
          <span class="TitleText">成本利润</span>
          <button type="button" class="layui-btn layui-btn-primary" ng-click="AddCompensation()">赔付金额</button>          
        </div>
        
        <div class="layui-card-body CostCard">
          <div class="layui-form-item">
            <div class="layui-inline layui-col-md2">
              <label class="layui-form-label">订单金额</label>
              <div class="layui-input-block">
                <input type="text" class="layui-input" value="{{CostData.PayMoney | CurrencyFormat}}" readonly>
              </div>
            </div>
            <div class="layui-inline layui-col-md2">
              <label class="layui-form-label">到账金额</label>
              <div class="layui-input-block">
                <input type="text" class="layui-input" value="{{CostData.AccountMoney|CurrencyFormat}}" readonly>
              </div>
            </div>
            <div class="layui-inline layui-col-md2">
              <label class="layui-form-label">赔付金额</label>
              <div class="layui-input-block">
                <input type="text" class="layui-input" value="{{CostData.Compensation|CurrencyFormat}}" readonly>
              </div>
            </div>
            <div class="layui-inline layui-col-md2">
              <label class="layui-form-label">快递金额</label>
              <div class="layui-input-block">
                <input type="text" class="layui-input" value="{{CostData.Express|CurrencyFormat}}" readonly>
              </div>
            </div>
            <div class="layui-inline layui-col-md2">
              <label class="layui-form-label">成本金额</label>
              <div class="layui-input-block">
                <input type="text" class="layui-input" value="{{CostData.VisaCost|CurrencyFormat}}" readonly>
              </div>
            </div>
            <div class="layui-inline layui-col-md2">
              <label class="layui-form-label">利润</label>
              <div class="layui-input-block">
                <input type="text" class="layui-input" value="{{CostData.Profit|CurrencyFormat}}" readonly>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- --------------------------------物流信息-------------------------------------------- -->
    <div class="layui-col-md12">
      <div class="layui-card">
        <div class="layui-card-header"><span class="TitleText">物流信息</span>
          <button type="button" class="layui-btn layui-btn-primary" ng-click="ExpressCreate()">生成快递单</button>
        </div>
        
        <div class="layui-card-body">
          <div style="overflow: auto; width: 100%; min-height: 200px; position: relative;height:500px;" id="WayBillDataGridDiv">
            <table class="layui-table" lay-size="sm" lay-even='true' id="WayBillDataGrid" lay-filter="WayBillDataGrid" style="overflow: auto;"  >
              <thead>
                <tr>
                  <th lay-data="{field:'a1',width:30}" style2="width: 30px;">序号</th>
                  <th lay-data="{field:'a2',width:160}" style2="width: 160px;">订单号</th>
                  <th lay-data="{field:'a3',width:50}" style2="width: 40px;">寄件人</th>
                  <th lay-data="{field:'a4',width:60}" style2="width: 50px;">快递方式</th>
                  <th lay-data="{field:'a5'}" >地址</th>
                  <th lay-data="{field:'a6',width:60}" style2="width: 60px;">状态</th>
                  <th lay-data="{field:'a7',width:80}" style2="width: 80px;">快递单</th>
                </tr>
              </thead>
              <tbody>                  
                <tr  ng-repeat="w in WayBillData " on-finish-render-filters="WayBillDataGridFinish" > 
                  <td >{{$index+1}}</td>
                  <td >
                    <div>{{w.mailNo}}</div>
                    <div style="color: #ababab;">【{{w.orderID}}】</div>
                    <div>{{w.mailDate}}</div>
                  </td>
                  <td>{{w.mailUserName}}</td>
                  <td >{{w.PayMethod}}</td>
                  <td >
                    <div style="text-align: left;">
                      <div>
                        <span>地址：</span>
                        <span>{{w.consignerProvince}}&nbsp;</span>
                        <span>{{w.consignerCity}}&nbsp;</span>
                        <span>{{w.consignerCounty}}&nbsp;</span>
                        <span>{{w.PostRequest_Address}}</span>
                      </div>
                      <div>
                        <span>联系人：</span><span>{{w.consignerName}}</span>
                      </div>
                      <div>  
                        <span >联系电话：</span>
                        <span>{{w.consignerMobile}}</span>
                      </div>
                    </div>
                  </td>
                  <td >{{w.PostResponseHead}}</td>
                  <td style="width: 80px;">
                    <div><a style="margin-left: auto;margin-right: auto;width:100%;" class="layui-btn layui-btn-primary layui-btn-xs" href="javascript:void(0);"  ng-click="PrintWayBillImage('{{w.BillImage}}')" role="button" >打印快递单</a></div>
                    <div><a style="margin-left: auto;margin-right: auto;width:100%;" class="layui-btn layui-btn-primary layui-btn-xs" href="javascript:void(0);"  ng-click="QueryBillRoute('{{w.orderID}}')" role="button" >查看物流</a></div>
                    <div><a style="margin-left: auto;margin-right: auto;width:100%;" class="layui-btn layui-btn-primary layui-btn-xs" target="_blank" href="/SFWayBillImage/{{w.BillImage}}" role="button" >查看快递单</a></div>
                  </td>
                </tr>
              </tbody>
            </table>
            <div class="WayBillLoading" style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 0px; background-color: #9e9e9e33; text-align: center;">
              <i class="weui-loading Loading"></i>
            </div>
          </div>      
        </div>
      </div>
    </div>
  </div>

<script type="text/javascript">


var ProductTypeName=<%=new  ProductTypeJson().GetJsonDataString()%>
var CountryName = <%=new  CountryJson().GetJsonDataString()%>


var HistoryListType=['补料备注','退款备注','须寄回材料备注','OTA操作','操作记录'];

var ebo_SourceOrderNo='1';
var ebo_id=<%=ID%>;

</script>


<script src="BookingOrderInfo2.js?<%=version.Version%>"></script>
<script src="BookingOrderInfo_fileter.js?<%=version.Version%>"></script>

<script src="BookingOrderInfo_layui.js?<%=version.Version%>"></script>


<jsp:include page="/Content/BookingOrder/Form/BookingOrderSelect.jsp" />


</body>
</html>