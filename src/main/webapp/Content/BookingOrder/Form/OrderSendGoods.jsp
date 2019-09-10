
<%@page import="com.java.version"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/layuihead2018.jsp" />
<link href="OrderSendGoods.css" rel="stylesheet">
<title>发货</title>
<style type="text/css">
.layui-textarea {
  resize: none;
}

#ExpressCode,.BillImage,.ExpressCodeLabel {
    display: none;
}

.doing #ExpressCode {
    display: inline-block;
    width: 200px;
}

.doing .BillImage,.doing .ExpressCodeLabel {
    display: inherit;
}

.doing .mark {
    width: calc(100% - 40px);
    position: absolute;
    height: 100%;
    z-index: 100;
    background-color: #e6e6e6;
    opacity: 0.5;
    display: inherit;
}

 .mark {
    display: none;
}

.doing  .CreateExpress {
    display: none;
}



</style>
</head>
<body>
  <form class="layui-form" action="" style="margin: 10px">
    <div class="layui-form-item">
      <div class="layui-inline">
        <label class="layui-form-label">搜索：</label>
        <div class="layui-input-block" style="width: 280px;">
          <input type="text" autocomplete="off" placeholder="OTA订单号/OTA昵称/联系人姓名/手机" class="layui-input" id="QueryText">
        </div>
      </div>
      <div class="layui-inline">
        <button type="button" class="layui-btn" lay-event="Query">查询</button>
      </div>
    </div>
  </form>
  <div style="margin: 10px" class="mainForm">
    <form class="layui-form" action="" style="margin: 10px" lay-filter="SendGoodsForm">
      <div class="layui-form-item" style="margin: 10px;">
        <div class="layui-inline">
          <button type="button" class="layui-btn CreateExpress" lay-submit="" lay-filter="CreateExpress">生成物流单号</button>
          <label class="layui-form-label ExpressCodeLabel">物流单号：</label><input type="text" name="ExpressCode" autocomplete="off" placeholder="" class="layui-input" id="ExpressCode"  readonly>

          <a  id='BillImage' class=' BillImage layui-btn' target="_blank" href="/SFWayBillImage/" role="button" >查看快递单</a>
          <a  id='OpenBillImage' class='BillImage layui-btn' lay-submit="" href="javascript:void(0)" role="button" >打印快递单</a>
        </div>
      </div>
      <div style="padding: 10px;">
        <div class="mark"></div>
        <div class="layui-form-item" style="margin: 10px;">
          <div class="layui-inline">
            <input type="radio" name="PayType" value="1" title="月结寄付" checked=""> <input type="radio" name="PayType" value="2" title="到付寄出">
          </div>
          <div class="layui-inline">
            <input type="checkbox" name="Document" title="已确认回寄材料"> <input type="checkbox" name="invoice" title="已确认回寄发票"> <input type="checkbox" name="SMS"
              title="发送短信"
            >
          </div>
        </div>
        <div class="layui-form-pane" style="margin: 10px">
          <div class="layui-row layui-col-space5">
            <div class="layui-col-xs6" style="height: 148px;">
              <div class="layui-form-item layui-form-text" style="margin-bottom: 0px;">
                <label class="layui-form-label">回寄地址</label>
              </div>
              <div class="layui-form-item address " style="height: 100%;">
                <div class="layui-input-block" style="height: 100%;">
                  <div class="layui-inline width33">
                    <label class="layui-form-label">省：</label>
                    <div class="layui-input-block" style="">
                      <input type="text" name="Province" lay-verify="title" autocomplete="off" placeholder="" class="layui-input" id="Province">
                    </div>
                  </div>
                  <div class="layui-inline width33">
                    <label class="layui-form-label">市：</label>
                    <div class="layui-input-block" style="">
                      <input type="text" name="City" lay-verify="title" autocomplete="off" placeholder="" class="layui-input" id="City">
                    </div>
                  </div>
                  <div class="layui-inline width33">
                    <label class="layui-form-label">区：</label>
                    <div class="layui-input-block" style="">
                      <input type="text" name="County" lay-verify="title" autocomplete="off" placeholder="" class="layui-input" id="County">
                    </div>
                  </div>
                  <div class="layui-inline width50">
                    <label class="layui-form-label">联系人：</label>
                    <div class="layui-input-block" style="">
                      <input type="text" name="Contact" lay-verify="title" autocomplete="off" placeholder="" class="layui-input" id="Contact">
                    </div>
                  </div>
                  <div class="layui-inline width50">
                    <label class="layui-form-label">电话：</label>
                    <div class="layui-input-block" style="">
                      <input type="text" name="Tel" lay-verify="title" autocomplete="off" placeholder="" class="layui-input" id="Tel">
                    </div>
                  </div>
                  <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">地址</label>
                    <div class="layui-input-block">
                      <textarea placeholder="" class="layui-textarea" name="Address" id="Address" lay-filter="SendMsgContent" style="height: 60px; min-height: inherit;"></textarea>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="layui-col-xs6">
              <div class="layui-form-item" style="margin-bottom: 0px;">
                <div class="layui-inline" style="width: calc(50% - 12px);">
                  <label class="layui-form-label">通知模板：</label>
                  <div class="layui-input-block" style="">
                    <select lay-filter="MessageTemplateList" id="MessageTemplateList">
                    </select>
                  </div>
                </div>
                <div class="layui-inline" style="width: calc(50% - 12px);">
                  <label class="layui-form-label">接收手机：</label>
                  <div class="layui-input-block" style="">
                    <input type="text" name="SendPhone" lay-verify="title" autocomplete="off" placeholder="请输入手机号码" class="layui-input" id="SendPhone">
                  </div>
                </div>
              </div>
              <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">短信内容</label>
                <div class="layui-input-block">
                  <textarea placeholder="请输入内容" class="layui-textarea" id="SendMsgContent" name="SendMsgContent" lay-filter="SendMsgContent" style="height: 110px;"></textarea>
                </div>
              </div>
            </div>
          </div>
        </div>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 0px; margin-left: 10px; margin-right: 10px;">
          <legend>订单详情</legend>
        </fieldset>
        <div class="OrderDetil">
          <input type="hidden" name="EboID"  id="EboID" >
          <div class="layui-form-pane" style="margin: 10px 10px 0px 10px;">
            <div class="layui-row  layui-col-space5">
              <div class="layui-col-xs3">
                <label class="layui-form-label">来源：</label>
                <div class="layui-input-block">
                  <input type="text" name="_SourceName" autocomplete="off" class="layui-input" id="_SourceName" readonly>
                </div>
              </div>
              <div class="layui-col-xs3">
                <label class="layui-form-label">订单号：</label>
                <div class="layui-input-block">
                  <input type="text" name="_SourceOrderNo" autocomplete="off" class="layui-input" id="_SourceOrderNo" readonly>
                </div>
              </div>
              <div class="layui-col-xs3">
                <label class="layui-form-label">成交日期：</label>
                <div class="layui-input-block">
                  <input type="text" name="_PayDate" autocomplete="off" class="layui-input" id="_PayDate" readonly>
                </div>
              </div>
              <div class="layui-col-xs3">
                <label class="layui-form-label">OTA昵称：</label>
                <div class="layui-input-block">
                  <input type="text" name="_SourceGuest" autocomplete="off" class="layui-input" id="_SourceGuest" readonly>
                </div>
              </div>
            </div>
            <div class="layui-row  layui-col-space5 ">
              <div class="layui-col-xs6">
                <div class="layui-form-item layui-form-text" style="margin-bottom: 0px;">
                  <label class="layui-form-label">寄回材料</label>
                  <div class="layui-input-block">
                    <textarea placeholder="请输入内容" class="layui-textarea" id="SendGoodsList" name="SendGoodsList" lay-filter="SendGoodsList" style="height: 60px; min-height: 60px;"></textarea>
                  </div>
                </div>
              </div>
              <div class="layui-col-xs6">
                <div class="layui-form-item layui-form-text" style="margin-bottom: 0px;">
                  <label class="layui-form-label">发票</label>
                  <div class="layui-input-block">
                    <textarea placeholder="请输入内容" class="layui-textarea" id="SendInvoice" name="SendInvoice" lay-filter="SendInvoice" style="height: 60px; min-height: 60px;"></textarea>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div style="margin: 0px 10px;">
            <table id='NameListTable' lay-filter="NameListTable">
            </table>
          </div>
        </div>
      </div>
    </form>
  </div>
  <script>
      
    <%@ include file = "/Content/BookingOrder/Form/OrderSendGoods.js" %>
      
    </script>
</body>
</html>