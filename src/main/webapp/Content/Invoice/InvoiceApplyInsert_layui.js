
layui.define(['table','element', 'form','laytpl','laydate' ], function(exports){
    
    
  var table = layui.table
  ,form = layui.form
  ,laytpl=layui.laytpl
  ,element=layui.element
  ,$ = layui.$,
  laydate = layui.laydate;


  form.on('checkbox()', function(data){
    console.log('checkbox');
    console.log(data);
    data.elem.checked=!data.elem.checked;
    $(data.elem).trigger('click');
  });
  form.on('radio()', function(data){
    data.elem.click();
  });
  
  form.on('select()', function(data){
    $(data.elem).change();
  });  

  form.render();
  
});
