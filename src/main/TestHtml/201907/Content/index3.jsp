<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>    
<!DOCTYPE>  
<html lang="zh-CN">  
<head>  
  
<meta charset="utf-8" />  
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">  
<title>jquery tmpl</title>  

<jsp:include page="/head.jsp"/>

   
<style>  
th{  
    width:25%;  
}  
</style>  
</head>  
<body class="">  
    
<a class="btn btn-default" href="javascript:void(0);" onclick="generate()"  role="button" >新增记录</a>
<div id="div_demo"></div>
<script id="demo" type="text/x-jquery-tmpl">
    <div style="margin-bottom:10px;">
    　　<span>(${ID})</span>
    　　<span style="margin-left:10px;">({{= ID}})</span>
    　　<span style="margin-left:10px;">({{= Name}})</span>
    　　<span style="margin-left:10px;">({{= Num}})</span>
    　　<span style="margin-left:10px;">({{= Status}})</span>
    <span style="margin-left:10px;">(${$item.getName1()})</span>
    </div>
</script>
<script type="text/javascript">
　　var users = [{ 'ID': 'think8848', Name: 'Joseph Chan', Num: '1', Status: 1 }, { ID: 'aCloud', Name: 'Mary Cheung', Num: '2'}];
　　 $("#demo").tmpl(users).appendTo('#div_demo');
	 function generate()
	 {
	   $("#demo").tmpl(users,{
	     getName: function (spr) {
	       console.log("getName")
	       return this.data.Name;
	    }
	    }).appendTo('#div_demo');
	 }
</script>
</body>  

</html>  