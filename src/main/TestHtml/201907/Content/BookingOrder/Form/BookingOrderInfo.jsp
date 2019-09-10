<%@page import="com.ecity.java.web.WebFunction"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.SupplierInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.CountryJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
<%@page import="com.ecity.java.json.JSONObject"%>
<%@page import="com.ecity.java.web.ls.Content.BookingOrder.BookingOrderInfoClass"%>
<%@	page isELIgnored="true"%>
<%@	page language="java" contentType="text/html;	charset=UTF-8" pageEncoding="UTF-8"%>
<%
  

String	ID=request.getParameter("ID")==null?"":request.getParameter("ID");
if	(ID.equals(""))
{
	WebFunction.GoErrerHtml(request,	response,	"缺少参数（ID）2");
	return;
}
BookingOrderInfoClass	BookingOrderInfo=new	BookingOrderInfoClass(ID);
JSONObject	DataJson=BookingOrderInfo.OpenTable();

JSONObject	OrderJson=DataJson.getJSONObject("OrderInfo");



%>
<!DOCTYPE	html>
<html lang="zh-CN" style="height: 100%;">
<head>
<title>订单详情</title>
<jsp:include page="/head.jsp" />
<link rel="stylesheet" type="text/css" href="/Res/js/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="/Res/js/jquery-easyui/themes/icon.css">
<script type="text/javascript" src="/Res/js/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="/Res/js/jquery-easyui/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="/Res/js/Base64.js"></script>
<script src="<%=request.getContextPath()%>/res/js/bootstrap-treeview.min.js"></script>

 <link href="<%=request.getContextPath() %>/layuiadmin/layui/css/layui.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/Content/index.css" rel="stylesheet">

<script src="<%=request.getContextPath() %>/layuiadmin/layui/init.js"></script>
<script src="https://cdn.staticfile.org/angular.js/1.4.6/angular.min.js"></script>

<style>
#BookingOrderInfoDiv [type=button] {
  min-width: 100px;
}

.input-group-addon {
  min-width: 110px;
  text-align: justify;
  text-align-last: justify;
}

.OrderInfo>div {
  margin-left: 20px;
}

.OrderInfo	span.TitleText14 {
  min-width: 100px;
  text-align: justify;
  text-align-last: justify;
  display: inline-block;
}

.OrderInfo	span.value {
  min-width: 150px;
  display: inline-block;
}

body {
  overflow: auto;
}

.Loading {
  position: absolute;
  left: 50%;
  top: 50%;
}

.packageDiv {
  margin: 10px;
}

#WayBillDataGrid .datagrid-row {
  height: 42px;
  text-align: center;
}

.datagrid-row td div {
  white-space: initial;
}

.layui-tab-item{
 height: 100%;

}
</style>
</head>
<body ng-app="BookingOrderInfoApp"   ng-controller="BookingOrderInfoCtrl" >
  <div id="BookingOrderInfoDiv" style="position: relative; padding: 20px; height: 100%; max-width: 1240px; margin-left: auto; margin-right: auto;">
    <div>
      <div style=" padding: 10px;">
        <div style="margin-top: 10px;">
          <span class="TitleText">销售客服：</span> <span class="TitleTagText" FieldName="ebo_SaleName"><%=
                      OrderJson.getString("ebo_SaleName")
                    %>&nbsp;</span>
          <button type="button" class="btn btn-primary" onclick="UpdateSaleName()">绑定销售</button>
        </div>
        <div style="margin-top: 10px;">
          <div>
            <span class="TitleText">短信通知：</span>
          </div>
          <div style="margin- top: 5px;">            
            <div class="row">
              <div class="col-lg-6">           
                <div class="input-group" style="width: 100%">
                  <span class="input-group-addon">接收手机号：</span> <input class="form-control" placeholder="" id="SendMsgPhone" type="text"  value="<%=OrderJson.getString("ebo_Phone")%>">
                </div>
              </div><!-- /.col-lg-6 -->
              <div class="col-lg-6">
                <div class="input-group" style="width: 100%">
                  <span class="input-group-addon">通知模板：</span> <select class="form-control" id="MessageTemplateList" onchange="SelectMessageTemplate()"></select>
                </div>
              </div><!-- /.col-lg-6 -->
            </div><!-- /.row -->
            <div style="margin-top: 5px;">
              <textarea id="SendMsgContent" style="width: 100%; height: 120px; resize: none;"></textarea>
            </div>
            <button type="button" class="btn btn-primary" onclick="CheckKeyWord()" style="margin-top: 5px; width: 100%;">短信发送</button>
          </div>
        </div>
        <div style="margin-top: 10px;">
          
        </div>
        <div style="margin-top: 10px;">
          <div class="layui-tab layui-tab-card" lay-filter="HistoryListTab">
            <ul class="layui-tab-title" >
              <li lay-id="HistoryListTab{{$index}}" class="" ng-repeat="li in HistoryList ">{{li}} <span class="layui-badge" ng-hide="HistoryListCount[$index]<=0">{{HistoryListCount[$index]}}</span><div></div></li>
            </ul>
            <div class="layui-tab-content" style="height: 500px;" >
              <div class="layui-tab-item " ng-repeat="li in HistoryList ">
              
                <div role="tabpanel" class="tab-pane " id="historyList{{$index}}" style="height:100%" >
                  <div style="margin-top: 5px; position: relative; height: 100%;">
                    <div>
                        <input type="hidden" ng-bind="HistoryListDataIndex=$index">
                        <button type="button" class="btn  btn-primary" ng-click="UpdateBookingOrderHistory2($index,li)" HistoryIndex="{{$index}}" HistoryName="{{li}}" style="width: 100%" >增加{{li}}备注</button>
                    </div>
                    <div style="overflow: auto; width: 100%; height: calc(100% - 35px);margin-top: 5px;">
                      <table class="table tableflow table-hover table-striped DataTable DataGrid" id="HistoryListDataGrid{{$index}}" style="overflow: auto; ">
                        <thead>
                          <tr>
                            <th style="width: 100px;text-align: center;">序号</th>
                            <th style="width: 150px;text-align: center;">日期</th>
                            <th style="width: 90px;text-align: center;">操作人</th>
                            <th style="text-align: center;">备注</th>
                          </tr>
                        </thead>
                        <tbody>                    
                          <tr  ng-repeat="h in HistoryListData | filter:{type:li}"> 
                            <input type="hidden" ng-bind="HistoryListCount[HistoryListDataIndex]=$index+1">
                            <th style="text-align: center;">{{$index+1}}</th>
                            <th style="text-align: center;">{{h.date}}</th>
                            <th style="text-align: center;">{{h.OpName}}</th>
                            <th> {{h.Remark}}</th>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                    <!-- <div class="HistoryLoading{{d.id}}" style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 0px; background-color: #9e9e9e33; text-align: center;">
                      <i class="weui-loading Loading"></i>
                    </div>
                    -->
                  </div>
                </div>
              </div>
            </div>
          </div>          
        </div>
      </div>
        <div style="clear: both;"></div>
    </div>
    <!--	订单明细	-->
    <div>
      <!--	签证子单	-->
      <div id="VisaDiv" style="display: none" class="packageDiv">
        <div style="margin-bottom: 10px;">
          <span class="TitleText">签证子单：</span>
          <button type="button" class="btn	btn-default" onclick="AlitripTravelVisaApplicantUpdate(<%=ID%>)">更新申请信信息</button>
          <button id="CreateVisaSignBtn" type="button" class="btn	btn-default" onclick="CreateVisaSign(<%=ID%>)">生成受理号</button>
        </div>
        <div>
          <div style="overflow: auto; width: 100%; height: 100%; position: relative;">
            <table class="table tableflow table-hover table-striped	DataTable easyui-datagrid DataGrid" id="VisaDataGrid" style="overflow: auto; height: 300px;"
              data-options="singleSelect:true,fitColumns:false,method:'get'"
            >
              <thead>
                <tr>
                  <th data-options="field:'index',width: 35,sortable: false,align: 'center',halign:'center'">序号</th>
                  <th data-options="field:'ebon_Name',width: 80,sortable: false,align: 'left',halign:'center'">姓名</th>
                  <th data-options="field:'ebon_PassPort',width: 100,sortable: false,align: 'left',halign:'center'">护照号</th>
                  <th data-options="field:'ebon_StatusOTA2',width: 80,sortable: false,align: 'center',halign:'center'">OTA状态</th>
                  <th data-options="field:'ebon_StatusVisa2',width: 80,sortable: false,align: 'center',halign:'center'">签证状态</th>
                  <th data-options="field:'ebop_ProductCode',width: 80,sortable: false,align: 'left',halign:'center'">产品编码</th>
                  <th data-options="field:'ebop_id_Ept',width: 80,sortable: false,formatter:OpenEptName,align: 'center',halign:'center'">产品类型</th>
                  <th data-options="field:'ebop_id_act',width: 80,sortable: false,formatter:OpenActName,align: 'center',halign:'center'">国家</th>
                  <th data-options="field:'ebop_ProductName',width: 150,sortable: false,align: 'left',halign:'center'">产品</th>
                  <th data-options="field:'ebop_day',width: 50,sortable: false,align: 'center',halign:'center'">工作日</th>
                  <th data-options="field:'ebop_Money',width: 80,sortable: false,align: 'right',halign:'center'">金额</th>
                  <th data-options="field:'ebop_AddMoney',width: 80,sortable: false,align: 'right',halign:'center'">差额</th>
                  <th data-options="field:'ebop_SaleMoney',width: 80,sortable: false,align: 'right',halign:'center'">成交金额</th>
                  <th data-options="field:'ebon_id_avg',width:80,align:'right',formatter:OpenAvg,halign:'center'">受理号</th>
                  <!--
									<th data-options="field:'index',width: 35,sortable: false,align: 'center',halign:'center'">客人ID</td>
									<th data-options="field:'index',width: 35,sortable: false,align: 'center',halign:'center'">签证状态</td>
									<th data-options="field:'index',width: 35,sortable: false,align: 'center',halign:'center'">补料</td>
									<th data-options="field:'index',width: 35,sortable: false,align: 'center',halign:'center'">护照详细信息</td>
									<th data-options="field:'index',width: 35,sortable: false,align: 'center',halign:'center'">护照截图</td>
							-->
                </tr>
              </thead>
              <tbody>
              </tbody>
            </table>
            <div class="VisaLoading" style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 0px; background-color: #9e9e9e33; text-align: center;">
              <i class="weui-loading Loading"></i>
            </div>
          </div>
        </div>
        <div role="tabpanel" class="tab-pane active" id="historyList2">
          <div style="margin-top: 5px; position: relative;">
            <div>
              <span class="TitleText">操作日志：</span>
            </div>
            <div style="overflow: auto; width: 100%; height: 200px">
              <table class="table tableflow table-hover table-striped DataTable easyui-datagrid DataGrid" id="HistoryDataGrid2" style="overflow: auto; height: 100%;"
                data-options="singleSelect:true,fitColumns:false,method:'get'"
              >
                <thead>
                  <tr>
                    <th data-options="field:'index',width: 35,sortable: false,align: 'center',halign:'center'">序号</th>
                    <th data-options="field:'date',width: 125,sortable: false,align: 'left',halign: 'center'">操作日期</th>
                    <th data-options="field:'type',width: 60,sortable: false,align: 'left',halign: 'center'">类型</th>
                    <th data-options="field:'OpName',width: 60,sortable: false,align: 'left',halign: 'center'">操作人</th>
                    <th data-options="field:'Remark',sortable: false,align: 'left',halign: 'center'">备注</th>
                  </tr>
                </thead>
                <tbody>
                </tbody>
              </table>
            </div>
            <div class="HistoryLoading2" style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 0px; background-color: #9e9e9e33; text-align: center;">
              <i class="weui-loading Loading" style=""></i>
            </div>
          </div>
        </div>
      </div>
      
      <!--	保险子单	-->
      <div id="BaoXianDiv" style="display: none" class="packageDiv">
        <div>
          <span class="TitleText">保险子单：</span>
        </div>
        <div>
          <table class="table	table-hover	table-striped	BaoXianDataTable">
            <thead>
              <tr>
                <td>姓名</td>
                <td>护照号</td>
                <td>供应商</td>
                <td>产品编码</td>
                <td>产品类型</td>
                <td>国家</td>
                <td>产品</td>
                <td>天数</td>
                <td>差额</td>
                <td>成交金额</td>
                <td>出发日期</td>
                <td>回程日期</td>
                <td>保单号</td>
                <td>状态</td>
              </tr>
            </thead>
            <tbody>
            </tbody>
          </table>
        </div>
      </div>
      <!--	WIFI子单	-->
      <div id="WifiDiv" style="display: none" class="packageDiv">
        <div>
          <span class="TitleText">WIFI子单：</span>
        </div>
        <div>
          <table class="table	table-hover	table-striped	WifiDataTable">
            <thead>
              <tr>
                <td>供应商</td>
                <td>产品编码</td>
                <td>产品类型</td>
                <td>国家</td>
                <td>产品</td>
                <td>天数</td>
                <td>差额</td>
                <td>成交金额</td>
                <td>出发日期</td>
                <td>回程日期</td>
                <td>供应商订单号</td>
                <td>状态</td>
              </tr>
            </thead>
            <tbody>
            </tbody>
          </table>
        </div>
      </div>
      <!--	电话卡子单	-->
      <div id="PhoneDiv" style="display: none" class="packageDiv">
        <div>
          <span class="TitleText">电话卡子单：</span>
        </div>
        <div>
          <table class="table	table-hover	table-striped	PhoneDataTable">
            <thead>
              <tr>
                <td>供应商</td>
                <td>产品编码</td>
                <td>产品类型</td>
                <td>国家</td>
                <td>产品</td>
                <td>数量</td>
                <td>差额</td>
                <td>成交金额</td>
                <td>出发日期</td>
                <td>回程日期</td>
                <td>供应商订单号</td>
                <td>状态</td>
              </tr>
            </thead>
            <tbody>
            </tbody>
          </table>
        </div>
      </div>
      <!--	差额订单	-->
      <div id="AddMoneyDiv" style="display: none" class="packageDiv">
        <div>
          <span class="TitleText">差额订单：</span>
        </div>
        <div>
          <table class="table	table-hover	table-striped	DataTable">
            <thead>
              <tr>
                <td>序号</td>
                <td>OTA订单号</td>
                <td>金额</td>
                <td>备注</td>
                <td>操作</td>
              </tr>
            </thead>
            <tbody>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <!--	订单信息	-->
    <div class="packageDiv">
      <div>
        <span class="TitleText">订单信息：</span>
      </div>
      <div style="padding: 10px;" class="OrderInfo">
        <div style="display: inline-block;">
          <span class="TitleText14">OTA来源</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_SourceName")	
                        %></span>
        </div>
        <div style="display: inline-block;">
          <span class="TitleText14">OTA订单号</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_SourceOrderNo")	
                        %></span>
        </div>
        <div style="display: inline-block;">
          <span class="TitleText14">昵称</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_SourceGuest")	
                        %><a target="_blank"
            href="http://amos.im.alisoft.com/msg.aw?v=2&uid=<%=
                          OrderJson.getString("ebo_SourceGuest")	
                        %>&site=cntaobao&s=1&charset=utf-8"
          ><img border="0"
              src="http://amos.im.alisoft.com/online.aw?v=2&uid=<%=
                          OrderJson.getString("ebo_SourceGuest")	
                        %>&site=cntaobao&s=1&charset=utf-8"
              alt="点击这里给我发消息"
            /></a></span>
        </div>
        <div></div>
        <div style="display: inline-block;">
          <span class="TitleText14">邮箱</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_EMail")	
                        %></span>
        </div>
        <div style="display: inline-block;">
          <span class="TitleText14">微信</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_WeiXin")	
                        %></span>
        </div>
        <div style="display: inline-block;">
          <span class="TitleText14">QQ号码</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_QQ")	
                        %></span>
        </div>
        <div></div>
        <div style="display: inline-block;">
          <span class="TitleText14">订单支付日期</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_PayDate")	
                        %></span>
        </div>
        <div style="display: inline-block;">
          <span class="TitleText14">订单到账日期</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_AccountDate")	
                        %></span>
        </div>
        <div></div>
        <div style="display: inline-block;">
          <span class="TitleText14">联系人</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_LinkMan")	
                        %></span>
        </div>
        <div style="display: inline-block;">
          <span class="TitleText14">手机</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_Phone")	
                        %></span>
        </div>
        <div></div>
        <div style="display: inline-block;">
          <span class="TitleText14">地址</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_Addr")	
                        %></span>
        </div>
        <div></div>
        <div style="display: inline-block;">
          <span class="TitleText14">订单备注</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_Remark")	
                        %></span>
        </div>
        <div></div>
        <div style="display: inline-block;">
          <span class="TitleText14">订单金额</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_PayMoney")	
                        %></span>
        </div>
        <div style="display: inline-block;">
          <span class="TitleText14">到账总金额</span><span>：</span><span class="value"><%=
                          OrderJson.getString("ebo_AccountMoney")	
                        %></span>
        </div>
        <div></div>
        <div>
          <a role="button" class="btn	btn-default btn-xs"
            href="<%=
                          request.getContextPath() 
                        %>/Content/TaoBao/Form/alitripInfo.jsp?id=<%=
                          OrderJson.getString("ebo_SourceOrderNo")	
                        %>&d=<%=
                          request.getSession().getLastAccessedTime()
                        %>"
            target="_blank"
          >查看原始数据</a> 
          <a role="button" class="btn btn-info btn-xs"
            href="<%=
                          request.getContextPath() 
                        %>/taobao/api/alitripTravelTradeQuery.json?OrderID=<%=
                          OrderJson.getString("ebo_SourceOrderNo")  
                        %>&U=true&d=<%=
                          request.getSession().getLastAccessedTime()
                        %>"
            target="_blank"
          >刷新订单数据</a>
          <a role="button" class="btn btn-warning btn-xs" onclick="UpdatePostAddress('<%=OrderJson.getString("ebo_SourceOrderNo")%>')"
            href="javascript:void(0);"  
          >同步联系人信息</a>
        </div>
      </div>
    </div>
    <!--	发票信息	-->
    <div class="packageDiv">
      <div>
        <span class="TitleText">发票信息：</span>
      </div>
      <div>
        <div class="form-group">
          <div class="input-group">
            <span class="input-group-addon	">发票类型：</span> <input type="text" class="form-control" placeholder="" id="">
          </div>
          <div class="input-group">
            <span class="input-group-addon	">发票性质：</span> <input type="text" class="form-control" placeholder="" id="">
          </div>
          <div class="input-group">
            <span class="input-group-addon	">发票金额：</span> <input type="text" class="form-control" placeholder="" id="">
          </div>
          <div class="input-group">
            <span class="input-group-addon	">发票抬头：</span> <input type="text" class="form-control" placeholder="" id="">
          </div>
          <div class="input-group">
            <span class="input-group-addon	">税号：</span> <input type="text" class="form-control" placeholder="" id="">
          </div>
          <div class="input-group">
            <span class="input-group-addon	">地址：</span> <input type="text" class="form-control" placeholder="" id="">
          </div>
          <div class="input-group">
            <span class="input-group-addon	">电话：</span> <input type="text" class="form-control" placeholder="" id="">
          </div>
          <div class="input-group">
            <span class="input-group-addon	">开户行：</span> <input type="text" class="form-control" placeholder="" id="">
          </div>
          <div class="input-group">
            <span class="input-group-addon	">账号：</span> <input type="text" class="form-control" placeholder="" id="">
          </div>
        </div>
      </div>
      <div>
        <span class="TitleText">发票提交记录：</span>
      </div>
      <div>
        <table class="table	table-hover	table-striped	DataTable">
          <thead>
            <tr>
              <td>时间</td>
              <td>提交人</td>
              <td>抬头</td>
              <td>提交金额</td>
              <td>核销金额</td>
              <td>具体发票信息</td>
              <td>状态</td>
              <td>操作</td>
            </tr>
          </thead>
          <tbody>
          </tbody>
        </table>
      </div>
    </div>
    <!--	财务核算	-->
    <div class="packageDiv">
      <div>
        <span class="TitleText">财务核算：</span>
      </div>
      <div>
        <table class="table	table-hover	table-striped	DataTable">
          <thead>
            <tr>
              <td>名称</td>
              <td>汇总</td>
              <td>签证订单</td>
              <td>保险订单</td>
              <td>WIFI订单</td>
              <td>电话卡</td>
              <td>门票</td>
              <td>差额订单</td>
              <td>快递</td>
            </tr>
          </thead>
          <tbody>
          </tbody>
        </table>
      </div>
    </div>
    <!--	物流信息	-->
    <div class="packageDiv">
      <div>
        <span class="TitleText">物流信息：</span>
      </div>
      <div style="margin: 10px;">
        <button type="button" class="btn	btn-default" onclick="ExpressCreate('<%=OrderJson.getString("ebo_SourceOrderNo")%>')">生成快递单</button>
      </div>
      <div style="overflow: auto; width: 100%; min-height: 200px; position: relative;">
        <table class="table tableflow table-hover table-striped	DataTable easyui-datagrid DataGrid" id="WayBillDataGrid" style="overflow: auto; height: 100%;"
          data-options="singleSelect:true,fitColumns:false,method:'get',fit:false"
        >
          <thead>
            <tr>
              <th data-options="field:'index',width: 35,sortable: false,align: 'center',halign:'center'">序号</th>
              <th data-options="field:'orderID',width: 200,sortable: false,align: 'left',halign:'center',formatter:OpenWayBillNo">订单号</th>
              <th data-options="field:'mailUserName',width: 60,sortable: false,align: 'center',halign:'center'">寄件人</th>
              <th data-options="field:'PayMethod',width: 60,sortable: false,align: 'center',halign:'center'">快递方式</th>
              <th data-options="field:'PostRequest_Address',width: 640,sortable: false,align: 'left',halign:'center',formatter:OpenPostRequest_Address"">地址</th>
              <th data-options="field:'PostResponseHead',width: 80,sortable: false,align: 'center',halign:'center'">状态</th>
              <th data-options="field:'BillImage',width: 80,sortable: false,align: 'center',halign:'center',formatter:OpenWayBillImage">快递单</th>
            </tr>
          </thead>
          <tbody>
          </tbody>
        </table>
        <div class="WayBillLoading" style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 0px; background-color: #9e9e9e33; text-align: center;">
          <i class="weui-loading Loading"></i>
        </div>
      </div>
    </div>
  </div>
  <script id="VisaTemplate" type="text/html">
		<tr>
			<td>${getGuestName(ebop_id_ebon)}</td>
			<td>${getGuestPassPort(ebop_id_ebon)}</td>
			<td>${ebop_StatusType}</td>
			<td>${ebop_ProductCode}</td>
			<td>${ProductTypeName[ebop_id_ept]}</td>
			<td>${CountryName[ebop_id_act]}</td>
			<td>${ebop_ProductName}</td>
			<td>${ebop_day}</td>
			<td>${ebop_Money}</td>
			<td>${ebop_AddMoney}</td>
			<td>${ebop_SaleMoney}</td>
			<td	onclick="OpenVisaSign(this);"	style="cursor:	pointer;"	data-id="${getGuestAvgID(ebop_id_ebon)}">${getGuestAvgID(ebop_id_ebon)}</td>
			<td>${getGuestID(ebop_id_ebon)}</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>	
	</script>
  <script id="DataTemplate" type="text/html">
	<tr>
		<td>${SupplierName[ebop_id_esi]}</td>
		<td>${ebop_ProductCode}</td>
		<td>${ProductTypeName[ebop_id_ept]}</td>
		<td>${CountryName[ebop_id_act]}</td>
		<td>${ebop_ProductName}</td>
		<td>${ebop_day}</td>
		<td>${ebop_AddMoney}</td>
		<td>${ebop_SaleMoney}</td>
		<td>${ebop_DateStart}</td>
		<td>${ebop_DateBack}</td>
		<td>供应商订单号</td>
		<td>${ebop_StatusType}</td>
	</tr>	
	</script>
  <script id="DataTemplate2" type="text/html">
	<tr>
		<td>${getGuestName(ebop_id_ebon)}</td>
		<td>${getGuestPassPort(ebop_id_ebon)}</td>
		<td>${SupplierName[ebop_id_esi]}</td>
		<td>${ebop_ProductCode}</td>
		<td>${ProductTypeName[ebop_id_ept]}</td>
		<td>${CountryName[ebop_id_act]}</td>
		<td>${ebop_ProductName}</td>
		<td>${ebop_day}</td>
		<td>${ebop_AddMoney}</td>
		<td>${ebop_SaleMoney}</td>
		<td>${ebop_DateStart}</td>
		<td>${ebop_DateBack}</td>
		<td>供应商订单号</td>
		<td>${ebop_StatusType}</td>
	</tr>	
	</script>
  <script type="text/javascript">
var	PackageJson=<%=DataJson.getJSONArray("PackageInfo").toString()%>
var	NameList=<%=DataJson.getJSONArray("NameList").toString()%>
var	ProductTypeName=<%=new	ProductTypeJson().GetJsonDataString()%>
var	CountryName	=	<%=new	CountryJson().GetJsonDataString()%>
var	SupplierName	=	<%=new	SupplierInfoJson().GetJsonDataString()%>


var HistoryListType=['补料备注','退款备注','须寄回材料备注','OTA操作','操作备注'];

var ebo_SourceOrderNo='<%=OrderJson.getString("ebo_SourceOrderNo")%>';
var ebo_id=<%=OrderJson.getString("ebo_id")%>

</script>
  <script type="text/javascript">
	<%@ include file = "/Content/BookingOrder/Form/BookingOrderInfo.js" %>
</script>


<script src="<%=request.getContextPath()%>/Content/BookingOrder/Form/BookingOrderInfo2.js?1"></script>



</body>
</html>