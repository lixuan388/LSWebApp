/**

 @Name：layuiAdmin 主页控制台
 @Author：贤心
 @Site：http://www.layui.com/admin/
 @License：GPL-2
		
 */


layui.define(function(exports){
	
	/*
		下面通过 layui.use 分段加载不同的模块，实现不同区域的同时渲染，从而保证视图的快速呈现
	*/
	
	
	//区块轮播切换
	layui.use(['admin', 'carousel'], function(){
		var $ = layui.$
		,admin = layui.admin
		,carousel = layui.carousel
		,element = layui.element
		,device = layui.device();

		//轮播切换
		$('.layadmin-carousel').each(function(){
			var othis = $(this);
			carousel.render({
				elem: this
				,width: '100%'
				,arrow: 'none'
				,interval: othis.data('interval')
				,autoplay: othis.data('autoplay') === true
				,trigger: (device.ios || device.android) ? 'click' : 'hover'
				,anim: othis.data('anim')
			});
		});
		
		element.render('progress');
		
	});
	
//	layui.use(['admin'],function(){
//		var $ = layui.$
//		,setter = layui.setter
//		,admin=layui.admin;
//		//读取订单状态统计
//		
//		function loaddata()
//		{
//			console.log('loaddata');
//			admin.req({
//				url: setter.ContextPath+'/web/system/OrderStatusStatistics.json'
//				,type: 'get'
//				,success: function(res){
//					if (res.MsgID!='1')
//					{
//						console.log(res.MsgText);
//					}
//					else
//					{
//						$('#DBSH_WRL').html(res.WRL);
//						$('#DBSH_WWC').html(res.WWC);
//						$('#DBSH_YRL').html(res.YRL);
//						$('#DBSH_YFH').html(res.YFH);
//						$('#DBSH_ERR').html(res.ERR);
//					}
//				}
//			});
//			
//			admin.req({
//				url: setter.ContextPath+'/web/system/AlitripTravelTradesCheckSearch.json'
//				,type: 'get'
//				,success: function(res){
//					if (res.MsgID!='1')
//					{
//						console.log(res.MsgText);
//					}
//					else
//					{
//						$('#DRDD_Alitrip').html(res.Alitrip);
//						$('#DRDD_Local').html(res.Local);
//						$('#DRDD_LocalErr').html(res.LocalErr);
//					}
//				}
//			});
//			setTimeout("loaddata()", 1000*10);  
//		}
//		loaddata()
////		setTimeout("loaddata()", 1000*60*5);
////		setInterval(loaddata(), 1000*10);
//	});

	//数据概览
	layui.use(['admin', 'carousel', 'echarts','element'], function(){
		var $ = layui.$
		,setter = layui.setter
		,admin = layui.admin
		,carousel = layui.carousel
		,element = layui.element
		,echarts = layui.echarts;
		
		var echartsApp = [], options = [
			//今日流量趋势
			{
				title: {
					text: '周订单量',
					x: 'center',
					textStyle: {
						fontSize: 14
					}
				},
				tooltip : {
					trigger: 'axis',
					formatter: "订单数: {c}"
				},
				legend: {
					data:['','']
				},
				xAxis : [{
					type : 'category',
					boundaryGap : false,
					data: []
				}],
				yAxis : [{
					type : 'value'
				}],
				series : [{
					type:'line',
					smooth:true,
					itemStyle: {normal: {areaStyle: {type: 'default'}}},
					data: []
				}]
			},
			
			//访客浏览器分布
			{ 
				title : {
					text: '访客浏览器分布',
					x: 'center',
					textStyle: {
						fontSize: 14
					}
				},
				tooltip : {
					trigger: 'item',
					formatter: "{a} <br/>{b} : {c} ({d}%)"
				},
				legend: {
					orient : 'vertical',
					x : 'left',
					data:['Chrome','Firefox','IE 8.0','Safari','其它浏览器']
				},
				series : [{
					name:'访问来源',
					type:'pie',
					radius : '55%',
					center: ['50%', '50%'],
					data:[
						{value:9052, name:'Chrome'},
						{value:1610, name:'Firefox'},
						{value:3200, name:'IE 8.0'},
						{value:535, name:'Safari'},
						{value:1700, name:'其它浏览器'}
					]
				}]
			},
			
			//新增的用户量
			{
				title: {
					text: '最近一周新增的用户量',
					x: 'center',
					textStyle: {
						fontSize: 14
					}
				},
				tooltip : { //提示框
					trigger: 'axis',
					formatter: "{b}<br>新增用户：{c}"
				},
				xAxis : [{ //X轴
					type : 'category',
					data : ['11-07', '11-08', '11-09', '11-10', '11-11', '11-12', '11-13']
				}],
				yAxis : [{	//Y轴
					type : 'value'
				}],
				series : [{ //内容
					type: 'line',
					data:[200, 300, 400, 610, 150, 270, 380],
				}]
			}
		]
		,elemDataView = $('#LAY-index-dataview').children('div')
		,renderDataView = function(index){
			echartsApp[index] = echarts.init(elemDataView[index], layui.echartsTheme);
			echartsApp[index].setOption(options[index]);
			//window.onresize = echartsApp[index].resize;
			admin.resize(function(){
				echartsApp[index].resize();
			});
		};
		
		
		//没找到DOM，终止执行
		if(!elemDataView[0]) return;
		
		
		
		renderDataView(0);
		
		//监听数据概览轮播
		var carouselIndex = 0;
		carousel.on('change(LAY-index-dataview)', function(obj){
			renderDataView(carouselIndex = obj.index);
		});
		
		//监听侧边伸缩
		layui.admin.on('side', function(){
			setTimeout(function(){
				renderDataView(carouselIndex);
			}, 300);
		});
		
		admin.req({
			url: setter.ContextPath+'/web/system/OrderInfoStatistics.json'
			,type: 'get'
			,success: function(res){
				if (res.MsgID!='1')
				{
					console.log(res.MsgText);
				}
				else
				{
					options[0].xAxis[0].data=res.date1;
					options[0].series[0].data=res.count1;
					renderDataView(0);
				}
			}
		});
	  element.on('tab(layadmin-layout-tabs)', function(){

    	//console.log(this.getAttribute('lay-id'));
	    if (this.getAttribute('lay-id')=='home' )
	    {
	    	renderDataView(carouselIndex);
	    	//console.log('renderDataView');
	    }
	  });
	  

	});
	
	//最新订单
	layui.use('table', function(){
		var $ = layui.$
		,table = layui.table;
		
		//今日热搜
		table.render({
			elem: '#LAY-index-topSearch'
			,url: layui.setter.base + 'json/console/top-search.js' //模拟接口
			,page: true
			,cols: [[
				{type: 'numbers', fixed: 'left'}
				,{field: 'keywords', title: '关键词', minWidth: 300, templet: '<div><a href="https://www.baidu.com/s?wd={{ d.keywords }}" target="_blank" class="layui-table-link">{{ d.keywords }}</div>'}
				,{field: 'frequency', title: '搜索次数', minWidth: 120, sort: true}
				,{field: 'userNums', title: '用户数', sort: true}
			]]
			,skin: 'line'
		});
		
		//今日热贴
		table.render({
			elem: '#LAY-index-topCard'
			,url: layui.setter.base + 'json/console/top-card.js' //模拟接口
			,page: true
			,cellMinWidth: 120
			,cols: [[
				{type: 'numbers', fixed: 'left'}
				,{field: 'title', title: '标题', minWidth: 300, templet: '<div><a href="{{ d.href }}" target="_blank" class="layui-table-link">{{ d.title }}</div>'}
				,{field: 'username', title: '发帖者'}
				,{field: 'channel', title: '类别'}
				,{field: 'crt', title: '点击率', sort: true}
			]]
			,skin: 'line'
		});
	});
	
	exports('console', {})
});