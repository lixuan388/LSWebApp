layui.extend({
  index : 'lib/index' // 主入口模块
}).use([ 'index', 'console', 'element' ], function() {
  var $ = layui.$, setter = layui.setter, admin = layui.admin, element = layui.element, $body = $('body');
  // 读取订单状态统计
  function loaddata() {
    console.log('loaddata');
    admin.req({
      url : setter.ContextPath + '/web/system/OrderStatusStatistics.json',
      type : 'get',
      success : function(res) {
        if (res.MsgID != '1') {
          console.log(res.MsgText);
        } else {
          $('#DBSH_WRL').html(res.WRL);
          $('#DBSH_WWC').html(res.WWC);
          $('#DBSH_YRL').html(res.YRL);
          $('#DBSH_YFH').html(res.YFH);
          $('#DBSH_ERR').html(res.ERR);
        }
      }
    });
    admin.req({
      url : setter.ContextPath + '/web/system/AlitripTravelTradesCheckSearch.json',
      type : 'get',
      success : function(res) {
        if (res.MsgID != '1') {
          console.log(res.MsgText);
        } else {
          $('#DRDD_Alitrip').html(res.Alitrip);
          $('#DRDD_Local').html(res.Local);
          $('#DRDD_LocalErr').html(res.LocalErr);
        }
      }
    });
    setTimeout(function(){loaddata();}, 1000 * 60*5 );
  }
  loaddata();

  var events = {
    OpenDBSH_ERR : function(othis) {
      OpenWindowLayer('绑定产品', setter.ContextPath + '/Content/TaoBao/Form/alitripTravelTradesExceptionSearch.jsp?d=' + new Date().getTime(), function() {}, {
        'width' : '90%',
        'height' : '90%'
      })
    },
    OrderStatusSync : function OrderStatusSync(othis) {
      OpenWindowLayer('签证状态推送', setter.ContextPath + '/Content/System/OrderStatusSyncQuery.jsp?d=' + new Date().getTime(), function() {}, {
        'width' : '90%',
        'height' : '90%'
      })
    }
  }

  $body.on('click', '*[layadmin-event]', function() {
    var othis = $(this), attrEvent = othis.attr('layadmin-event');
    events[attrEvent] && events[attrEvent].call(this, othis);
  });

  function CreateMenu() {
    for (i in tree) {
      // console.log(tree[i])
      var p = tree[i];
      var li = $('<li data-name="home" class="layui-nav-item"></li>');
      li.append('<a href="javascript:;" lay-tips="' + p.text + '" lay-direction="2"><i class="layui-icon ' + p.icon + '"></i><cite>' + p.text + '</cite></a>');
      if (p.nodes.length > 0) {
        var dl = $('<dl class="layui-nav-child"></dl>');
        for (j in p.nodes) {
          var nodes = p.nodes[j];
          var dd = '<dd><a href="javascript:;" lay-href="' + nodes.href + '" ><i class="layui-icon ' + nodes.icon + '"></i><cite>' + nodes.text + '</cite></a></dd>'
          dl.append(dd);
          if (nodes.IsLink) {
            $('.layadmin-shortcut ul').append('<li class="layui-col-xs3"><a lay-href="' + nodes.href + '"><i class="layui-icon ' + nodes.icon + '"></i><cite>' + nodes.text + '</cite></a></li>');
          }
        }
        li.append(dl);
      }
      $('.layui-side-menu .layui-nav').append(li);
    }
    element.render();

  }
  CreateMenu();
})
