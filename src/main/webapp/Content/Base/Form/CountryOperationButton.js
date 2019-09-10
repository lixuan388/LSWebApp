// <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
layui.config({
  base : '<%=request.getContextPath() %>/layuiadmin/' // 静态资源所在路径
  ,
  ContextPath : '<%=request.getContextPath() %>' //
  ,
  version : '<%=version.Version%>'//
}).extend({
  index : 'lib/index' // 主入口模块
}).use([ 'index', 'table', 'form',  'admin' ], function() {
  var $ = layui.$, admin = layui.admin, setter = layui.setter, table = layui.table, form = layui.form, layer = layui.layer;
  
  $body = $('body');
  
  
  for (item in AreaName){
    $("#SelectArea").append('<option value="'+item+'">'+AreaName[item]+'</option>');
  }
  form.render('select');
  
  var InitTable=function(){
//      console.log('InitTable');
      table.render({
        elem : '#CountryOperationButtonTable',
        //url : '<%=request.getContextPath() %>/web/system/CountryOperationButtonQuery.json',
        limit : 100,
        cols : [ [ {
          field : 'act_id',
          width : 60,
          align : 'center',
          title : 'ID'
        }, {
          field : 'act_name',
          width : 200,
          align : 'center',
          title : '名称', toolbar: '#act_nameTpl'
        }, { align:'center', toolbar: '#barDemo'}] ],
        page : false,
        height: 'full-90',
        response : {
          statusCode : 1
        // 重新规定成功的状态码为 200，table 组件默认为 0
        },
        parseData : function(res) { // 将原始数据解析成 table 组件所规定的数据
          return {
            "code" : res.MsgID, // 解析接口状态
            "msg" : res.MsgText, // 解析提示文本
            "count" : res.CountryData.length, // 解析数据长度
            "data" : res.CountryData
          // 解析数据列表
          };
        },        
      });
      events.Query();
    }
  

  
  admin.req({
    url: setter.ContextPath+'/web/system/OperationButtonQuery.json'
    ,type: 'get'
    ,success: function(res){
      if (res.MsgID!=1)
      {
        console.log(res.MsgText);
      }
      else
      {
//        console.log(res.Data);
        var demo="";
        for (item in res.Data){
          var _id=res.Data[item]._id;
          var _name=res.Data[item]._name;
          demo=demo+'<div class="checkboxDiv"><input type="checkbox" lay-filter="actbutton" name="a['+_id+'{{d.act_id}}]" buttonid="'+_id+'" actid="{{d.act_id}}" title="'+_name+'" {{# if (d.button['+_id+'] === "0") { }}value="false"{{# } else { }} value="true" checked{{#}}}{{# if (d.button['+_id+'] === "0") { }}OldValue="false"{{# } else { }} OldValue="true" checked{{#}}}></div>';
        }
//        console.log('InitTable1');
        demo='<form class="layui-form" lay-filter="form{{d.act_id}}">'+
          '<div><div class="checkboxDiv"><a class="layui-btn" href="javascript:void();" layadmin-event="SelectYes" style="background-color: #5FB878;" actid="{{d.act_id}}">全选</a></div><div class="checkboxDiv"><a  layadmin-event="SelectNo"  class="layui-btn layui-btn-primary" actid="{{d.act_id}}" href="javascript:void();">全不选</a></div><div style="clear: both;"></div></div>'+
          '<div>'+demo+'</div></form>';
        $('#barDemo').html(demo);
        InitTable();
          
      }
    }
  });
  
  events={
    Query:function(){
//      table.reload("CountryOperationButtonTable",{
//        where:{
//          'QueryText':$('#QueryText').val()
//        }
//      });

      var $loadingToast =loadingToast();
      admin.req({
        url: setter.ContextPath+'/web/system/CountryOperationButtonQuery.json'
        ,type: 'get'
        ,data:{
          'QueryText':$('#QueryText').val(),
          'SelectArea':$('#SelectArea').val()
        }
        ,success: function(res){

          $loadingToast.modal("hide");
          if (res.MsgID!=1)
          {
            console.log(res.MsgText);
          }
          else
          {
//            console.log(res);
            var button={};
            for (item in res.ButtonData){
              var d=res.ButtonData[item];
              if (!button[d.acb_id_act]){
                button[d.acb_id_act]={};
              }
//              if (button[d.acb_id_act][d.acb_id_sob]){
//                button[d.acb_id_act][d.acb_id_sob]={};
//              }
              button[d.acb_id_act][d.acb_id_sob]=d.acb_flag;
            }
              
            var Data=[];
            for (item in res.CountryData){
              var v={};
              v.act_id=res.CountryData[item].act_id;
              v.act_name=res.CountryData[item].act_name;
              v.button=button[v.act_id]?button[v.act_id]:{};
              Data.push(v);
            }

            console.log(Data);
            table.reload("CountryOperationButtonTable",{
              data:Data
            });
          }
        }
      });
    },
    PostData:function(){      
      var Data=[]
      $('[lay-filter="actbutton"]').each(function(){
        var t=this;
        var buttonid=$(this).attr('buttonid');
        var actid=$(this).attr('actid');

        var value=$(this).attr('value')=='false'?0:1;
        var OldValue=$(this).attr('OldValue')=='false'?0:1;
        if (value!=OldValue){
         
  //        console.log($(this).attr('value'));
          var json={'acb_id_act':actid,'acb_id_sob':buttonid,'acb_flag':value};
          Data.push(json);
        }
      })
      var json={'DataRows':Data};

      var $loadingToast =loadingToast();
      admin.req({
        url: setter.ContextPath+'/web/system/CountryOperationButtonPost.json'
        ,type: 'post'
        ,data: JSON.stringify(json)
        ,success: function(res){

          $loadingToast.modal("hide");
          if (res.MsgID==-1)
          {
            layer.alert(res.MsgText,  function(index){
              //do something
              layer.close(index);
            });
          }
          else{
            layer.alert('保存成功！',  function(index){
              //do something
              layer.close(index);
              events.Query();
            });
          }
        }
      });      
      console.log(Data);
    },
    SelectYes:function(elem){
      console.log(elem);
      var actid=$(elem).attr('actid');
      console.log('actid:'+actid);
      
      var v={};
      $('[type=checkbox][actid='+actid+']').each(function(){
        var name=$(this).attr('name');
        v[name]=true;

        $(this).attr('value',true);
      });
      var formName='form'+actid;
      form.val(formName,v);
    },
    SelectNo:function(elem){
      console.log(elem);
      var actid=$(elem).attr('actid');
      console.log('actid:'+actid);

      var v={};
      $('[type=checkbox][actid='+actid+']').each(function(){
        var name=$(this).attr('name');
        v[name]=false;
        $(this).attr('value',false);
      });
      console.log(JSON.stringify(v));
      var formName='form'+actid;
      form.val(formName,v);
    }
  }
  
  form.on('checkbox(actbutton)', function(data){
    $(data.elem).attr('value',data.elem.checked);
  });        
  
  //点击事件
  $body.on('click', '*[layadmin-event]', function(){
    var othis = $(this)
    ,attrEvent = othis.attr('layadmin-event');
    //console.log($(this));
    events[attrEvent] && events[attrEvent].call(this, othis);
  });

});