
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
  
  //同时绑定多个
  lay('.DateSelect').each(function(){
    laydate.render({
      elem: this
      ,trigger: 'click'
      ,done: function(value, date, endDate){
//        console.log(this.elem);
//        console.log(value); //得到日期生成的值，如：2017-08-18
//        console.log(date); //得到日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
//        console.log(endDate); //得结束的日期时间对象，开启范围选择（range: true）才会返回。对象成员同上。
        $(this.elem).change();
      }
    });
  });

  GridInit=function(){

//    console.log('init ExpressGrid');    
//    layui.table.init('InvoiceGrid',{height:'full-130',limit:100});    
  }
    
  //对外输出
  exports('InvoiceQueryLayui', {
    GridInit: GridInit
  });
  
});
