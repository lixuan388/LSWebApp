
layui.use(['form','table','element','laytpl'], function(){
  var form = layui.form;

  var $ = layui.jquery
  ,element = layui.element //Tab的切换功能，切换事件监听等，需要依赖element模块
  ,table = layui.table //Tab的切换功能，切换事件监听等，需要依赖element模块
  ,laytpl = layui.laytpl; //Tab的切换功能，切换事件监听等，需要依赖element模块
  layui.element.tabChange('HistoryListTab', 'HistoryListTab0');

//  console.log('layui.use')
  form.on('select()', function(data){
    //console.log('form.on select');
    //console.log(data);
    $(data.elem).change();
  });

  angular.element(BookingOrderInfoApp).scope().BookingOrderInfo();
  element.on('tab(HistoryListTab)', function(data){
    angular.element(BookingOrderInfoApp).scope().HistoryListTabChange(data.index);
  });
  
  
});
