<%@page import="java.net.URLDecoder"%>
<%@page import="com.ecity.java.mvc.service.system.SystemService"%>
<%@ page isELIgnored="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String status=request.getParameter("status")==null?"":request.getParameter("status");
status=URLDecoder.decode(status, "UTF-8");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<jsp:include page="/layuihead2018.jsp" />
<title>WebApp</title>
<style type="text/css">
.datagrid-row1 {
  height: 50px;
  text-align: center;
}

div>button {
  margin: 1px;
}

[readonly] {
  background-color: #fff;
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

tr.TRADE_CLOSED{
  background-color: red;
}
table.layui-table tr.TRADE_CLOSED td{
  color: white;
}

tr.layui-table-bover.TRADE_CLOSED td .TRADE_CLOSED{
  color: black;
}
</style>
</head>
<body>
  <div id="MianDiv" class="LayoutMain" style="background-color: white;margin: 5px;height: calc(100vh - 10px);">
    <div id="BookingOrderQueryDiv" class="LayoutColumn" style="position: relative;padding: 10px;height: calc(100vh - 30px);">
      <div>
        <div class="layui-form" style2="margin-top: 10px; margin-left: 20px;">
          <div class="layui-form-item">
            <div class="layui-inline">
              <label class="layui-form-label" style="width: 45px;">搜索：</label>
              <div class="layui-input-inline" style="width: 320px;">
                <input type="text" name="QueryText" autocomplete="off" class="layui-input"
                  placeholder="OTA订单号/OTA昵称/联系人姓名/手机" id="QueryText" >
              </div>
            </div>
            <div class="layui-inline">
              <label class="layui-form-label">订单状态：</label>
              <div class="layui-input-inline" style="width: 120px;">
                <select id="QueryStatus" lay-filter="QueryStatus">
                  <option value="" selected>全部</option>
                </select>
              </div>
            </div>
            <div class="layui-inline" style="margin-right: 0px;">
              <label class="layui-form-label">成交日期：</label>
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
          <div class="layui-form-item" style="margin: 0px 20px; ">          
              <button class="layui-btn layui-btn-xs layui-btn-danger " layadmin-event="Binding">批量认领</button>
          </div>          
        </div>
        <div style="margin: 10px 20px; border: 1px solid silver;"></div>
      </div>
      <div style="overflow: auto; height:calc(100vh - 138px);">
        <table id="DataGrid" lay-filter="DataGrid">

        </table>
      </div>
    </div>
  </div>

  <script type="text/javascript"> 
  var VisaAreaName;
  var QueryText=''

    <%
      if (!status.equals(""))
      {
        %>
        var QueryDateFr=''
        var QueryDateTo=''
        
        <%
      }
      else
      {
      %>
      var QueryDateFr='2018-01-01'
      var QueryDateTo='2018-01-01'
      <%
      }
    %>
  var QueryStatus='<%=status%>';
  
  </script>
  <script type="text/html" id="barDemo">
    <div><button class="layui-btn layui-btn-normal layui-btn-xs " lay-event="open" style="width:100%">查看</button></div>
    <div><button class="layui-btn layui-btn-danger layui-btn-xs " lay-event="edit" style="width:100%">修改状态</button></div>
  </script>
  <script type="text/html" id="LinkMan">
    <div>{{d.ebo_LinkMan}}</div>
    <div>{{d.ebo_Phone}} </div>
  </script>


  <script type="text/html" id="SourceOrderNo">
    <div>{{d.ebo_SourceOrderNo}}</div>
    <div style="color:#b5b5b5;font-size: 9px;" class="{{d.ebo_OrderState}}">{{d.ebo_OrderState}}</div>
  </script>
  <script type="text/html" id="SourceGuest">
    <div>{{d.ebo_SourceGuest}}</div>
    <div>
      <a target="_blank" href="http://amos.im.alisoft.com/msg.aw?v=2&uid={{d.ebo_SourceGuest}}&site=cntaobao&s=1&charset=utf-8" >
        <img border="0" src="http://amos.im.alisoft.com/online.aw?v=2&uid={{d.ebo_SourceGuest}}&site=cntaobao&s=1&charset=utf-8" alt="点击这里给我发消息" />
      </a>
    </div>
  </script>

  <script type="text/html" id="VisaAreaName">
    {{#var Ebo_id_Eva=d.ebo_id_Eva;}}
    {{#var name=VisaAreaName[Ebo_id_Eva]==undefined?"":VisaAreaName[Ebo_id_Eva];}}
    <div>{{name}}</div>
  </script>

  <script src="BookingOrderQuery.js"></script>
  
  <script type="text/javascript"> 
 //  layui.data(layui.setter.tableName+'.Json').VisaAreaName;
  </script>
</body>
</html>