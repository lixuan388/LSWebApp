
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
  });        
  form.on('radio()', function(data){
    data.elem.click();
  });        
  
  form.on('select()', function(data){
    $(data.elem).change();
  });
  
  
});
