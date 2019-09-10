
layui.use(['table','element', 'form','laytpl' ],function() {
  var table = layui.table
  ,form = layui.form
  ,laytpl=layui.laytpl
  ,element=layui.element
  ,$ = layui.$;


//  console.log('20190713.01');

  form.on('checkbox()', function(data){
    data.elem.checked=!data.elem.checked;
    $(data.elem).trigger('click');    
    if ($(data.elem).hasClass('OrderDetilDataIndex')){
      var OrderIndex=$(data.elem).attr('OrderIndex');
      console.log(OrderIndex);
      angular.element(OrderSendGoodsApp).scope().CheckAll(OrderIndex,data.elem.checked);
      angular.element(OrderSendGoodsApp).scope().$apply()
      layui.form.render(null,'OrderDetilListTab');
      
    }
    
  });        
  form.on('radio()', function(data){
    data.elem.click();
    console.log(data);
    if ($(data.elem).hasClass('MailCheckBox')){
      angular.element(OrderSendGoodsApp).scope().MailCheckBox=data.value;
      angular.element(OrderSendGoodsApp).scope().contactor=angular.element(OrderSendGoodsApp).scope().OrderDetil[data.value].contactor;
      angular.element(OrderSendGoodsApp).scope().SendPhone=angular.element(OrderSendGoodsApp).scope().OrderDetil[data.value].contactor.phone;
      angular.element(OrderSendGoodsApp).scope().$apply();

      $('.OrderDetilTitleMailCheckBox').removeClass('OrderDetilTitleMailCheckBox');
      $('.OrderDetilTitle'+data.value+'').addClass('OrderDetilTitleMailCheckBox');
      
    }
  });        
  
  form.on('select()', function(data){
    $(data.elem).change();
  });
  
  
});
