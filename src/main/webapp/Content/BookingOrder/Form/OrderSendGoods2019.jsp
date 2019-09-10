<%@page import="com.java.version"%>
<%@ page isELIgnored="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
String ID=request.getParameter("ID")==null?"":request.getParameter("ID");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layuihead2018.jsp" />
<link href="OrderSendGoods2019.css?1" rel="stylesheet">
<script src="https://cdn.staticfile.org/angular.js/1.5.8/angular.min.js"></script>
<title>发货</title>

</head>
<body id="OrderSendGoodsApp" ng-app="OrderSendGoodsApp" ng-controller="OrderSendGoodsCtrl">
  <div class="layui-fluid">
    <div class="layui-form  layui-form-pane " action="" >
      <div class="layui-row ">
        <!-- ------------------------------------------------------------------------------------------------------------ -->
        <div class="layui-col-md9">
          <div class="layui-col-md6">
            <div class="layui-card">
              <div class="layui-form-item">
                <label class="layui-form-label">搜索</label>
                <div class="layui-input-block">
                  <input type="text" autocomplete="off" placeholder="OTA订单号/OTA昵称/联系人姓名/手机 " class="layui-input" ng-model="QueryText" id="QueryText" style="width: calc(100% - 70px); display: inline-block;"ng-keypress="($event.which === 13)?Query():0">
                  <button type="button" class="layui-btn layui-btn-primary" ng-click="Query()">查询</button>
                </div>
              </div>
            </div>
          </div>
          <div class="layui-col-md6">
            <div class="layui-card">
              <div class="layui-form-item">
                <input type="radio" name="MailPayType" value="1" ng-model="MailPayType" title="寄付月结" ng-checked="MailPayType==1"> 
                <input type="radio" name="MailPayType" value="2" ng-model="MailPayType" title="到付寄出" ng-checked="MailPayType==2"> 
                <input type="radio" name="MailPayType" value="3" ng-model="MailPayType" title="客人自取" ng-checked="MailPayType==3"> 
                <input type="radio" name="MailPayType" value="4" ng-model="MailPayType" title="材料退件" ng-checked="MailPayType==4">
              </div>
            </div>
          </div>
          
          <div class="layui-col-md12">
            <div class="layui-col-md4">
              <div class="layui-card">
                <div class="layui-form-item" style="margin-bottom: 4px;">
                  <label class="layui-form-label">通知模板</label>
                  <div class="layui-input-block layui-form" lay-filter="MessageTemplateListDiv">
                    <select class="form-control" id="MessageTemplateList" ng-change="SelectMessageTemplate()" ng-model="SelectMessageTemplateValue">
                      <option style='display: none'></option>
                      <option ng-repeat="mt in MessageTemplate" value="{{$index}}" on-finish-render-filters="MessageTemplateListFinish">{{mt._Title}}</option>
                    </select>
                  </div>
                </div>
                <div class="layui-form-item" style="margin-bottom: 0px;">
                  <label class="layui-form-label">接收手机</label>
                  <div class="layui-input-block" style="">
                    <input type="text" placeholder="请输入手机号码" class="layui-input" ng-model="SendPhone">
                  </div>
                </div>
              </div>
            </div>
            <div class="layui-col-md8">
              <div class="layui-card">
                <div class="layui-form-itemt">
                  <label class="layui-form-label" style="line-height: 43px; height: 60px;">短信内容</label>
                  <div class="layui-input-block" style="">
                    <textarea placeholder="请输入短信内容" class="layui-textarea"  style="height: 60px;min-height: inherit;font-size: 11px;line-height: 1.2em;padding: 2px;"   ng-model="SendMsgContent"
                    ></textarea>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="layui-col-md3">
          <div class="layui-col-md12" >
            <div class="layui-card ExpressOPButton">
              <div class="layui-form-item">
                <button type="button" class="layui-btn layui-btn-danger" style="width: 100%" ng-click="CreateExpress()"  ng-disabled="!CanCreateExpress">生成快递单</button>
              </div>
            </div>
            
            <div class="layui-card ExpressOPButton">
              <div class="layui-form-item">
                <button type="button" class="layui-btn layui-btn-normal"  style="width: 100%" ng-click="OpenBillImage()" ng-disabled="BillImage==''">打印快递单</button>
              </div>
            </div>
          
          </div>
          <div class="layui-col-md12">
            <div class="layui-card " style="height: 60px;">
              <div class="layui-form-item">
                <label class="layui-form-label ExpressCodeLabel" style="width: 89px;">物流单号</label> 
                <input type="text" class="layui-input" ng-model="ExpressCode" readonly style="width: calc(100% - 89px);">
                <!--  
                <a  id='BillImage' class='BillImage layui-btn' target="_blank" href="/SFWayBillImage/" role="button" >查看快递单</a>
                <a  id='OpenBillImage' class='BillImage layui-btn' lay-submit="" href="javascript:void(0)" role="button" >打印快递单</a>
                -->
              </div>
              <div class="layui-form-item">
                <label class="layui-form-label ExpressCodeLabel" style="width: 89px;">运费</label> 
                <input type="text" class="layui-input" readonly style="width: calc(100% - 89px);">
                <!--  
                <a  id='BillImage' class='BillImage layui-btn' target="_blank" href="/SFWayBillImage/" role="button" >查看快递单</a>
                <a  id='OpenBillImage' class='BillImage layui-btn' lay-submit="" href="javascript:void(0)" role="button" >打印快递单</a>
                -->
              </div>
            </div>
          </div>
        </div>
        <!-- ------------------------------------------------------------------------------------------------------------ -->
        <div class="layui-col-md12">
          <div class="layui-card">
            <div class="layui-card-header">
              <span class="TitleText">收件地址</span>
              <span class="" style="font-size: 12px;color: #f00;margin-left: 20px;" ng-show="AddrDifferent">关联订单地址不一致</span>
            </div>
            <div class="layui-card-body ">
            
              <div class="layui-col-md2">
                <div class="layui-form-item" style="margin-bottom: 4px;">
                  <label class="layui-form-label">联系人</label>
                  <div class="layui-input-block">
                    <input type="text" class="layui-input" ng-model="contactor.name">
                  </div>
                </div>
              </div>
              <div class="layui-col-md3">
                <div class="layui-form-item" style="margin-bottom: 0px;">
                  <label class="layui-form-label">电话</label>
                  <div class="layui-input-block" style="">
                    <input type="text" class="layui-input" ng-model="contactor.phone">
                  </div>
                </div>
              </div>
              <div class="layui-col-md7">
                <div class="layui-form-itemt">
                  <label class="layui-form-label" style2="line-height: 43px; height: 60px;">地址</label>
                  <div class="layui-input-block" style="">
                    <input type="text" class="layui-input" ng-model="contactor.post_address">
                  </div>
                </div>
              </div>
              <div style="clear: both;"></div>
            </div>
          </div>
        </div>
        <!-- ------------------------------------------------------------------------------------------------------------ -->
        <div class="layui-col-md12">
          <div class="layui-col-md12">
            <div class="layui-card" style="min-height: calc(100vh - 20px)">
              <div class="layui-card-header">
                <span class="TitleText">订单详情</span>
              </div>
              <div class="layui-card-body layui-form" lay-filter="OrderDetilListTab">
                <div class="layui-btn layui-btn-primary OrderDetilTitle OrderDetilTitle{{$index}}" ng-repeat="o in OrderDetil "  on-finish-render-filters2="OrderDetilListTabFinish" style2="padding: 0 5px;" ng-click="OrderTitleClick($index)">
                  <input type="hidden" ng-bind="OrderDetilDataIndex=$index">
                  <div  style="float: left;">
                  <span class="TitleText" style='font-size: 13px;'>{{o.OrderInfo._SourceOrderNo}}</span>
                  <span class="layui-badge" ng-hide="OrderDetilListCount[$index]<=0">{{OrderDetilListtCount[$index]}}</span>
                  </div>
                </div>
                  <div class="layui-colla-item1 OrderDetilDiv OrderDetilDiv{{$index}}" ng-repeat="o in OrderDetil "  on-finish-render-filters="OrderDetilListTabFinish">                  
                    <input type="hidden" ng-bind="OrderDetilDataIndex=$index">
                    
        
                    <div class="layui-colla-content ">
                      <div id="historyList{{$index}}" style="height: 100%">
                        <div style="" class="layui-col-md12">                        
                            <div class="layui-card">            
                                <div class="layui-col-md1 ">
                                    <div class="layui-form-item2" style="margin-bottom: 4px;">
                                      <input  class="MailCheckBox"  type="radio" value="{{$index}}"  name="MailCheckBox" title="主单"
                                        OrderIndex="{{OrderDetilDataIndex}}" lay-skin="primary" ng-model="MailCheckBox" ng-checked="MailCheckBox==OrderDetilDataIndex">
                                    </div>
                                </div>                    
                                <div class="layui-col-md2">
                                  <div class="layui-form-item" style="margin-bottom: 4px;">
                                    <label class="layui-form-label">联系人</label>
                                    <div class="layui-input-block">
                                      <input type="text" class="layui-input" ng-model="o.contactor.name">
                                    </div>
                                  </div>
                                </div>
                                <div class="layui-col-md3">
                                  <div class="layui-form-item" style="margin-bottom: 0px;">
                                    <label class="layui-form-label">电话</label>
                                    <div class="layui-input-block" style="">
                                      <input type="text" class="layui-input" ng-model="o.contactor.phone">
                                    </div>
                                  </div>
                                </div>
                                <div class="layui-col-md6">
                                  <div class="layui-form-itemt">
                                    <label class="layui-form-label" style2="line-height: 43px; height: 60px;">地址</label>
                                    <div class="layui-input-block" style="">
                                      <input type="text" class="layui-input" ng-model="o.contactor.post_address">
                                    </div>
                                  </div>
                                </div>
                                <div style="clear: both;"></div>
                            </div>
                        </div>
                        <div style="" class="layui-col-md9">
                          <div style="overflow: auto; width: 100%; height: calc(100% - 35px);">
                            <div class="layui-card">
                              <div class="layui-form-item OrderDetilListTabHearForm">
                                <div class="layui-inline">
                                  <label class="layui-form-label">成交日期</label>
                                  <div class="layui-input-inline">
                                    <input type="text" class="layui-input" ng-model="o.OrderInfo._PayDate"readonly >
                                  </div>
                                </div>
                                <div class="layui-inline">
                                  <label class="layui-form-label">来源</label>
                                  <div class="layui-input-inline">
                                    <input type="text" class="layui-input" ng-model="o.OrderInfo._SourceName"readonly >
                                  </div>
                                </div>
                                <div class="layui-inline">
                                  <label class="layui-form-label">OTA昵称</label>
                                  <div class="layui-input-inline">
                                    <input type="text" class="layui-input" ng-model="o.OrderInfo._SourceGuest"readonly   style="width: calc(100% - 42px);display: inline-block;">
                                    
                                    <a class="layui-btn layui-btn-normal" target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid={{o.OrderInfo._SourceGuest}}&site=cntaobao&s=1&charset=utf-8" 
                                      style="display: inline-block;padding-left: 5px;padding-right: 5px;">旺旺</a>
                                  </div>
                                </div>
                              </div>
                            </div>
                            <div class="layui-card">
                              <table class="layui-table" lay-size="sm" lay-even='true' id="OrderDetilTabTable{{$index}}" style="overflow: auto;" lay-filter="OrderDetilTabTable{{$index}}">
                                <thead>
                                  <tr>
                                    <th lay-data="{field:'checkbox',width: 30}" style="width: 30px;">
                                      <div class="layui-form">
                                        <input id="checkbox_{{OrderDetilDataIndex}}" class="OrderDetilDataIndex" lay-filter="checkbox_{{OrderDetilDataIndex}}" type="checkbox" name="checkbox"
                                          OrderIndex="{{OrderDetilDataIndex}}"
                                          lay-skin="primary" ng-model="o.checkbox[OrderDetilDataIndex]" ng-checked="o.checkbox[OrderDetilDataIndex]"
                                        >
                                        </div>
                                    </th>
                                    <th lay-data="{field:'_index', width:30}" style="width: 30px;">序号</th>
                                    <th lay-data="{field:'_Name', width:100}" style="width: 100px;">姓名</th>
                                    <th lay-data="{field:'_PackageName'}">产品</th>
                                    <th lay-data="{field:'_StatusType',width:70}" style="width: 70px;">办理人状态</th>
                                  </tr>
                                </thead>
                                <tbody>
                                  <tr ng-repeat="od in OrderDetil[OrderDetilDataIndex].NameList" on-finish-render-filters="OrderDetilListTableFinish">
                                    <input type="hidden" ng-bind="OrderDetilListtCount[OrderDetilDataIndex]=$index+1">
                                    <td>
                                      <div class="layui-form">
                                        <input id="checkbox_{{OrderDetilDataIndex}}_{{$index}}" lay-filter="checkbox_{{OrderDetilDataIndex}}_{{$index}}" type="checkbox" name="checkbox"
                                          lay-skin="primary" ng-model="od.checkbox" ng-checked="od.checkbox"
                                        >
                                      </div>
                                    </td>
                                    <td>{{$index+1}}</td>
                                    <td><div>{{od._Name}}</div><div style="color: #959595;">{{od._passPortNo}}</div></td>
                                    <td>{{o.OrderInfo._PackageName}}</td>
                                    <td><div>{{od._StatusType}}</div><div  style="color: #959595;">【{{od._StatusVisa}}】</div></td>
                                  </tr>
                                </tbody>
                              </table>
                            </div>
                          </div>
                        </div>
                        <div class="layui-col-md3">
                          <div class="layui-card">
                            <div class="layui-form-item layui-form-text">
                              <label class="layui-form-label">寄回材料</label>
                              <div class="layui-input-block">
                                <textarea class="layui-textarea" lay-filter="SendGoodsList" style="height: 200px; min-height: 60px;" ng-model="o.OrderInfo.SendGoodsList"></textarea>
                              </div>
                            </div>
                          </div>
                          <div class="layui-card">
                            <div class="layui-form-item layui-form-text" style="margin: 5px 0;">
                              <label class="layui-form-label">发票登记</label>
                              <div class="layui-input-block" style="border: 1px solid #e6e6e6;">
                                <div class="layui-card">
                                  <input type="radio" name="invoice" value="无登记发票" ng-model="invoice" title="无登记发票" ng-checked="invoice=='无登记发票'"> <input type="radio" name="invoice"
                                    value="发票待处理" ng-model="invoice" title="发票待处理" ng-checked="invoice=='发票待处理'"
                                  > <input type="radio" name="invoice" value="发票已处理" ng-model="invoice" title="发票已处理" ng-checked="invoice=='发票已处理'">
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                        <div style="clear: both;"></div>
                      </div>              
                    </div>
                  </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- ------------------------------------------------------------------------------------------------------------ -->
  
  <script type="text/javascript">
    var ID='';
    <%
    if (!ID.equals("")){
    %>
      ID='<%=ID%>';
    
    <%
    }
    %>    
  </script>

  <script src="OrderSendGoods2019_angular.js?12321"></script>
  <script src="OrderSendGoods2019_layui.js"></script>
</body>

<jsp:include page="/Content/BookingOrder/Form/BookingOrderSelect.jsp" />
</html>