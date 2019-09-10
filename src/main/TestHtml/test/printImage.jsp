<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://libs.baidu.com/jquery/1.7.0/jquery.min.js"></script>
<script type="text/javascript" src="/Res/js/jquery.jqprint-0.3.js"></script>

<title>Insert title here</title>
</head>
<body>
<img id='image' alt="" width="378px"src="http://127.0.0.1:8080/SFWayBillImage/wayBillImage20181115144039.jpg">
<input type="button" onclick=" a()" value="打印"/>
<script type="text/javascript">

function  a(){
        $("#image").jqprint({
          debug: false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
          importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
          printContainer: true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
          operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
     });
    }
</script>
</body>
</html>