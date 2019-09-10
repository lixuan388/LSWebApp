<%@ page isELIgnored="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="layui-fluid">
  <div class="layui-row layui-col-space15">
    <!-- ------------------------------------------------------------------------------------- -->
    <div class="layui-col-md8">
      <div class="layui-row layui-col-space15">
        <div class="layui-col-md6">
          <div class="layui-card">
            <div class="layui-card-header">快捷方式</div>
            <div class="layui-card-body">

              <div class="layui-carousel layadmin-carousel layadmin-shortcut">
                <div carousel-item>
                  <ul class="layui-row layui-col-space10">
                  </ul>
                </div>
              </div>

            </div>
          </div>
        </div>
        <div class="layui-col-md6">
          <div class="layui-card">
            <div class="layui-card-header">待办事项</div>
            <div class="layui-card-body">
              <div class="layui-carousel layadmin-carousel layadmin-backlog">
                <div carousel-item>
                  <ul class="layui-row layui-col-space10">
                    <li class="layui-col-xs3"><a
                      lay-href="/Content/BookingOrder/Form/BookingOrderQuery.jsp?status=%25E6%259C%25AA%25E8%25AE%25A4%25E9%25A2%2586"
                      class="layadmin-backlog-body">
                        <h3>未认领</h3>
                        <p>
                          <cite id="DBSH_WRL">0</cite>
                        </p>
                    </a></li>
                    <li class="layui-col-xs3"><a
                      lay-href="/Content/BookingOrder/Form/BookingOrderQuery.jsp?status=%25E5%25B7%25B2%25E8%25AE%25A4%25E9%25A2%2586"
                      class="layadmin-backlog-body">
                        <h3>已认领</h3>
                        <p>
                          <cite id="DBSH_YRL">0</cite>
                        </p>
                    </a></li>
                    <li class="layui-col-xs3"><a
                      lay-href="/Content/BookingOrder/Form/BookingOrderQuery.jsp?status=%25E6%259C%25AA%25E5%25AE%258C%25E6%2588%2590"
                      class="layadmin-backlog-body">
                        <h3>未完成</h3>
                        <p>
                          <cite id="DBSH_WWC">0</cite>
                        </p>
                    </a></li>
                    <li class="layui-col-xs3"><a
                      lay-hrefX="/Content/BookingOrder/Form/BookingOrderQuery.jsp?status=%25E6%259C%25AA%25E5%25AE%258C%25E6%2588%2590"
                      class="layadmin-backlog-body">
                        <h3>已发货</h3>
                        <p>
                          <cite id="DBSH_YFH">0</cite>
                        </p>
                    </a></li>
                    <li class="layui-col-xs4"><a
                      lay-hrefX="/Content/BookingOrder/Form/BookingOrderQuery.jsp?status=%25E5%25B7%25B2%25E5%25AE%258C%25E6%2588%2590"
                      class="layadmin-backlog-body" layadmin-event="OpenDBSH_ERR">
                        <h3>异常订单</h3>
                        <p>
                          <cite id="DBSH_ERR" style="color: red">0</cite>
                        </p>
                    </a></li>
                    <li class="layui-col-xs8"><a
                      lay-hrefX="/Content/BookingOrder/Form/BookingOrderQuery.jsp?status=%25E5%25B7%25B2%25E5%25AE%258C%25E6%2588%2590"
                      class="layadmin-backlog-body">
                        <h3>当日订单数</h3>
                        <p>
                          <cite style="font-size: 18px;"></cite><cite id="DRDD_Alitrip" lay-tips="线上订单数">&nbsp;</cite><cite
                            style="font-size: 18px;">/</cite><cite id="DRDD_Local" lay-tips="本地订单数">&nbsp;</cite><cite
                            style="font-size: 18px;">/</cite><cite id="DRDD_LocalErr" lay-tips="异常订单数">&nbsp;</cite><cite
                            style="font-size: 18px;"></cite>
                        </p>
                    </a></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="layui-col-md12">
          <div class="layui-card">
            <div class="layui-card-header">数据概览</div>
            <div class="layui-card-body">
              <div class="layui-carousel layadmin-carousel layadmin-dataview" data-anim="fade"
                lay-filter="LAY-index-dataview">
                <div carousel-item id="LAY-index-dataview">
                  <div>
                    <i class="layui-icon layui-icon-loading1 layadmin-loading"></i>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="layui-card"   ng-app="TimeTaskLogApp"   ng-controller="TimeTaskLogCtrl">
            <div class="layui-card-header">定时作业运行情况<span style="margin-left: 20px;color: red;font-size: 0.8em;">刷新时间：{{InitDate}}</span></div>
            <div class="layui-card-body">
              <table class="layui-table ">
                <thead>
                  <tr>
                    <th>作业名称</th>
                    <th style="width: 100px;">频率</th>
                    <th>最后一次运行时间</th>
                  </tr>
                </thead>
                <tbody>
                  <tr ng-repeat="d in Data">
                    <td>
                      <div>{{d.TimeTaskName}}</div>
                      <div style="color: silver;">{{d.remark}}</div>
                    </td>
                    <td>{{d.timeRemark}}</td>
                    <td>{{d.DateString}}</td>
                  </tr>                
                </tbody>                
              </table>
              
            </div>
          </div>
          
          <script type="text/javascript" src="<%=request.getContextPath() %>/Content/TimeTaskLog.js"></script>

        </div>
      </div>
    </div>
    <!-- ------------------------------------------------------------------------------------- -->
    <div class="layui-col-md4">

      <!-- ------------------------------------------------------------------------------------- -->
      <div class="layui-card">
        <jsp:include page="/Content/updateLog.jsp" />

      </div>
      <!-- ------------------------------------------------------------------------------------- -->
    </div>

  </div>
</div>