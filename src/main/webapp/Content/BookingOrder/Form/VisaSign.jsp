<%@page import="com.ecity.java.web.ls.Parameter.Json.SourceSupplierInfoJson"%>
<%@page import="com.ecity.java.web.WebFunction"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.SourceInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.VisaSpeedJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.VisaTypeJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.CountryJson"%>
<%@ page isELIgnored="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

String ID=request.getParameter("ID")==null?"":request.getParameter("ID");
if (ID.equals(""))
{
	WebFunction.GoErrerHtml(request, response, "缺少参数（ID）");
  return;
}


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<jsp:include page="/head.jsp" />
<script src="<%=request.getContextPath() %>/res/js/bootstrap-treeview.min.js"></script>
<link href="<%=request.getContextPath() %>/Content/index.css" rel="stylesheet">
<title>签证订单</title>
<style type="text/css">
.caption {
  min-width: 80px;
  display: inline-block;
  text-align: right;
}

.DSTextEdit {
  /*display: block;
			width: 100%;
			height: 34px;*/
  width: 160px;
  padding: 1px 0.5em;
  /*font-size: 14px;*/
  line-height: 1.4em;
  color: #555;
  background-color: #fff;
  background-image: none;
  border: 1px solid #ccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
  -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
  transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}

.DSTextEdit[readonly], .DSTextEdit[disabled] {
  background-color: #eee;
  opacity: 1;
}

.DSTextEdit[disabled] {
  cursor: not-allowed;
}

span.DSTextEdit {
  display: inline-block;
  overflow: hidden;
  height: 23.6px;
}

.DataRow+.DataRow {
  margin-top: 5px;
}
</style>
</head>
<body>
  <div style="padding: 20px;">
    <div class="VisaSignInfo">
      <div class="DataRow">
        <span class="caption">受理号：</span><input class="DSTextEdit " type="text" FieldName="avg_invoiceno"> <span
          class="caption">客户类别：</span><input class="DSTextEdit " type="text" FieldName="avg_source"> <span
          class="caption">客人姓名：</span><input class="DSTextEdit lookup " lookup="SourceInfoName" type="text" FieldName="avg_id_asi"> <span
          class="caption">订单编号：</span><input class="DSTextEdit " type="text" FieldName="avg_groupcode">
      </div>
      <div class="DataRow">
        <span class="caption">办理国家：</span><input class="DSTextEdit lookup" lookup="CountryName" type="text" FieldName="avg_id_act"> <span
          class="caption">办理种类：</span><input class="DSTextEdit lookup" lookup="VisaSpeedName" type="text" FieldName="avg_id_avs"> <span
          class="caption">办理类型：</span><input class="DSTextEdit lookup" lookup="VisaTypeName" type="text" FieldName="avg_id_type">
      </div>
      <div class="DataRow">
        <span class="caption">单价：</span><input class="DSTextEdit" type="text" FieldName="avg_price"> <span
          class="caption">办理人数：</span><input class="DSTextEdit" type="text" FieldName="avg_num">
      </div>
      <div class="DataRow">
        <span class="caption">应收：</span><input class="DSTextEdit" type="text" FieldName="avg_amount"> <span
          class="caption">实收：</span><input class="DSTextEdit" type="text" FieldName="avg_actamt"> <span
          class="caption">待收：</span><input class="DSTextEdit" type="text" FieldName="avg_remain"> <span
          class="caption">供应商：</span><input class="DSTextEdit lookup" lookup="SourceSupplierInfoName" type="text" FieldName="avg_SupplierID">
      </div>
      


                
                
      <div class="DataRow">
        <span class="caption">备注：</span><input class="DSTextEdit" type="text" FieldName="avg_remark" style="width: 892px;">
      </div>
      <div class="DataRow">
        <span class="caption">订单状态：</span><input class="DSTextEdit" type="text" FieldName="avg_state"> <span
          class="caption">联系人：</span><input class="DSTextEdit" type="text" FieldName="avg_Source_link"> <span
          class="caption">联系电话：</span><input class="DSTextEdit" type="text" FieldName="avg_Source_tel"> 
          
      </div>
      <div class="DataRow">
        <span          class="caption">联系地址：</span><input class="DSTextEdit" type="text" FieldName="avg_Source_addr" style="width: 892px;">
      </div>
      <div class="DataRow">
        <span class="caption">录入人：</span><input class="DSTextEdit" type="text" FieldName="avg_user_enter"> <span
          class="caption">录入日期：</span><input class="DSTextEdit" type="text" FieldName="avg_date_enter">
      </div>
      <input class="DSTextEdit" type="hidden" FieldName="avg_id"> <input class="DSTextEdit" type="hidden"
        FieldName="avg_Date_Ins"> <input class="DSTextEdit" type="hidden" FieldName="avg_User_Ins"> <input
        class="DSTextEdit" type="hidden" FieldName="avg_Date_Lst"> <input class="DSTextEdit" type="hidden"
        FieldName="avg_User_Lst">
    </div>
    <div class="VisaSignDetil" style="overflow-x: auto; overflow: auto; height: 100%;">
      <table class="table table-hover table-striped  DataTable" style="width: 1500px; max-width: inherit;">
        <thead>
          <tr>
            <td style="width: 100px;">订单状态</td>
            <td style="width: 100px;">中文姓名</td>
            <td style="width: 100px;">英文姓名</td>
            <td style="width: 200px;">身份证</td>
            <td style="width: 120px;">护照号码</td>
            <td style="width: 80px;">性别</td>
            <td style="width: 120px;">出生年月</td>
            <td style="width: 120px;">签发日期</td>
            <td style="width: 120px;">有效期至</td>
            <td style="width: 100px;">签发地</td>
            <td style="width: 100px;">国家代码</td>
            <td style="width: 120px;">电话号码</td>
            <td style="width: 60px;">年龄</td>
            <td style="width: 120px;">备注</td>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td></td>
          </tr>
        </tbody>
      </table>
    </div>
    <div>
      <button id="PrintVisaButton" type="button" class="btn	btn-success" onclick="CreateVisaSign_PrintVisa(<%=ID%>)">打印签证标签</button>
    </div>
  </div>
  <div id="loadingToast" style="display: none;">
    <div class="weui-mask_transparent"></div>
    <div class="weui-toast">
      <i class="weui-loading weui-icon_toast"></i>
      <p class="weui-toast__content">数据加载中</p>
    </div>
  </div>

  <datalist id="url_list">
    <option label="W3Schools" value="270" />
    <option label="Google" value="10184" />
    <option label="Microsoft" value="1000" />
  </datalist>

  <script id="DetilTableTemplate" type="text/html">
        <tr style="cursor: pointer;" data-id="${ava_id}">
          <td>${ava_StatusType}</td>
          <td>${ava_name_c}</td>
          <td>${ava_name_e}</td>
          <td>${ava_idcard}</td>
          <td>${ava_PassPortNo}</td>
          <td><select class="form-control" type="text" FieldName="ava_sex"  value="${ava_sex}" disabled><option value="1" {%if (ava_sex=='1') %}selected{%else%}{%/if%}>男</option><option value="2" {%if (ava_sex=='2') %}selected{%else%}{%/if%}>女</option></select></td>
          <td>${ava_date_birth}</td>
          <td>${ava_Date_Sign}</td>
          <td>${ava_Date_End}</td>
          <td>${ava_place_issue}</td>
          <td>${ava_country_code}</td>
          <td>${ava_mobile}</td>
          <td>${ava_age}</td>
          <td>${ava_Remark}</td>
        </tr>
  </script>
  <script type="text/javascript"> 
  var LookupData={
    CountryName : <%=new CountryJson().GetJsonDataString()%>,
    VisaSpeedName: <%=new VisaSpeedJson().GetJsonDataString()%>,
    VisaTypeName: <%=new VisaTypeJson().GetJsonDataString()%>,
    SourceInfoName: <%=new SourceInfoJson().GetJsonDataString()%>,
    SourceSupplierInfoName: <%=new SourceSupplierInfoJson().GetJsonDataString()%>,
    }

 $(function () {
	 $('.VisaSignInfo').on('change','span[FieldName]',function(){
		 console.log(this);
	 })
	 VisaSign_Query();

   $("[FieldName]").attr("disabled","disabled");
 })
 
 function VisaSign_Query()
 {
   var $loadingToast = $('#loadingToast');
   $loadingToast.fadeIn(100);
   
   $.ajax({
     url: '<%=request.getContextPath() %>/Content/VisaSign/VisaSignGet.json?ID=<%=ID%>&d=' + new Date().getTime(),
     type: 'get',
     dataType: 'Json',
     success: function (data) {
       $loadingToast.fadeOut(100);
       if (data.MsgID != 1)
       { 
         alert(data.MsgText);
         return;
       } 
       else
       {
					for (item in data.VisaSignInfo)
					{
						var f=$(".VisaSignInfo [FieldName="+item+"]");
						if (f.length>0)
						{

							f.data("value",data.VisaSignInfo[item]);
							if (f.attr('lookup'))
							{
							  lookup=f.attr('lookup');
							  f.val(LookupData[lookup][data.VisaSignInfo[item]]);
							}
							else
							{
								f.val(data.VisaSignInfo[item]);
							}
						}
					}
	         $(".VisaSignDetil .DataTable>tbody").html("");
	         $("#DetilTableTemplate").tmpl(data.VisaSignDetil).appendTo($(".VisaSignDetil .DataTable>tbody"));  

       }
     }
   })  
 }
 
 function CreateVisaSign_PrintVisa(id)
 {

   window.open('LSWebPlug:VisaLablePrint%20'+id);
   /*
   var $loadingToast = loadingToast();
   
 	$.ajax({
 		url: 'http://127.0.0.1:58001/?VisaPrint&id='+id,
 		type: 'get',
 		dataType: 'Json',
 		success: function (data) {
 	    $loadingToast.modal("hide");
// 			console.log(data);
 			if (data.ErrCode=1)
 			{
 				//$(".ScanButton").removeAttr("disabled");

 	 			alert("打印完成");
 			}
 			else
 			{
 				alert(data.ErrMsg);
 			}
 		},
 		error:function(Req,err,e){
 			$loadingToast.modal("hide");
 			alert("打印失败");
 		}
 	})	
 	*/
 }
 </script>
</body>
</html>