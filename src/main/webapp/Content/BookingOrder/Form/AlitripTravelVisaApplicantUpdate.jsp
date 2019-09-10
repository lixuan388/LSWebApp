<%@page import="com.ecity.java.web.taobao.service.TaobaoService"%>
<%@page import="com.ecity.java.web.WebFunction"%>
<%@ page isELIgnored="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  
	String ID=request.getParameter("ID")==null?"":request.getParameter("ID");
	if (ID.equals(""))
	{
		WebFunction.GoErrerHtml(request,response,"缺少参数（ID）");
		return;
	}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/head.jsp" />
<title>签证状态同步</title>
<style>
.popover2 {
  margin: 10px;
  padding: 1px;
  background-color: #fff;
  -webkit-background-clip: padding-box;
  background-clip: padding-box;
  border: 1px solid #ccc;
  border: 1px solid rgba(0, 0, 0, .2);
  border-radius: 6px;
  -webkit-box-shadow: 0 5px 10px rgba(0, 0, 0, .2);
  box-shadow: 0 5px 10px rgba(0, 0, 0, .2);
  line-break: auto;
}

.input-group {
  width: 100%;
}

.row {
  margin-bottom: 5px;
  margin-right: 0px;
  margin-left: 0px;
}

.row>div {
  padding-right: 1px;
  padding-left: 1px;
}

.taobao {
  font-size: 12px;
  color: #929292;
  margin: 20px;
  font-family: '宋体';
}

.taobao span {
  display: inline-block;
  font-size: 12px;
  color: #929292;
  line-height: 1.5em;
  vertical-align: middle;
}

.ApplicationUpdateButton button {
  margin-right: 5px;
  margin-bottom: 5px;
}

.ApplicationUpdateButtonList button {
  margin-right: 5px;
  margin-bottom: 5px;
}

.DateInvalid {
  background-color: red;
}

.form_datetime[readonly] {
  background-color: #fff
}

.DateInvalid, .DateInvalid.form_datetime[readonly] {
  background-color: red
}
</style>
</head>
<body>
  <div id="WaitScan" style="display: none;">
    <div class="weui-mask_transparent"></div>
    <div class="weui-toast">
      <i class="weui-loading weui-icon_toast"></i>
      <p class="weui-toast__content">请放入护照</p>
    </div>
  </div>
  <div id="MainDiv" style="margin: 20px;">
    <div id="NameDiv"></div>
    <div class="popover2 MenuButton" style="padding: 5px; display: none">
      <button id="DeviceInitButton" type="button" class="btn	btn-success" onclick="DeviceInit()">连接扫描仪</button>
      <button id="PostButton" type="button" class="btn	btn-success" onclick="UpdateApplicantInfosAll()">保存并更新申请人基本信息</button>
    </div>
    <div class="popover2 ApplicationUpdateButtonList" style="padding: 5px; display: none">
      <span>批量更改签证进度：</span>
    </div>
  </div>
  <div class="OrderInfo">
    <input type="hidden" FieldName="OrderNo" value=""> <input type="hidden" FieldName="ID" value="<%=
          ID
        %>">
  </div>
  <script id="NameDataTemplate" type="text/html">

	<div class="popover2" NameID="${_id}">
		<h3 class="popover-title">申请人${Index}</h3>
		<div class="popover-content">
			<div class="form-group container-fluid">
				<div class="row">
					<div class="col-sm-6">
						<div class="input-group ">
							<span class="input-group-addon" id="basic-addon1">姓(英)</span>
							<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="_lastname_e" value="${_lastname_e}">
						</div>
					</div>
					<div class="col-sm-6">
						<div class="input-group	col-md-6">
							<span class="input-group-addon" id="basic-addon1">名(英)</span>
							<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="_firstname_e" value="${_firstname_e}">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6">
						<div class="input-group ">
							<span class="input-group-addon" id="basic-addon1">姓(中)</span>
							<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1" FieldName="_lastname_c" value="${_lastname_c}">
						</div>
					</div>
					<div class="col-sm-6">
						<div class="input-group	col-md-6">
							<span class="input-group-addon" id="basic-addon1">名(中)</span>
							<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="_firstname_c" value="${_firstname_c}">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="input-group">
						<span class="input-group-addon" id="basic-addon1">护照号</span>
						<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="_PassPortNo" value="${_passPortNo}">
					</div>
				</div>				
				<div class="row">
					<div class="col-sm-6">
						<div class="input-group">
							<span class="input-group-addon " id="basic-addon1">有效期起</span>
							<input type="text" class="form-control form_datetime" placeholder="" aria-describedby="basic-addon1"FieldName="_date_Sign" lay-verify="date" value="${GetDateString(_date_Sign)}" readonly>
						</div>
					</div>
					<div class="col-sm-6">					
						<div class="input-group">
							<span class="input-group-addon " id="basic-addon1">有效期止</span>
							<input type="text" class="form-control form_datetime" placeholder="" aria-describedby="basic-addon1"FieldName="_date_End" lay-verify="date" value="${GetDateString(_date_End)}" readonly>
						</div>
					</div>
				</div>				
				<div class="row">
					<div class="col-sm-6">
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">签发地</span>
							<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="_place_issue" value="${_place_issue}">
						</div>
					</div>
					<div class="col-sm-6">
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">国家代码</span>
							<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="_country_code" value="${_country_code}">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-3">
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">性别</span>
							<select class="form-control" type="text" FieldName="_sex"	value="${_sex}"><option value="1" {%if (_sex=='1') %}selected{%else%}1{%/if%}>男</option><option value="2"  {%if (_sex=='2') %}selected{%/if%}>女</option></select>
						</div>
					</div>
					<div class="col-sm-3">
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">年龄</span>
							<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="_age" value="${_age}">
						</div>
					</div>
					<div class="col-sm-6">
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">出生日期</span>
							<input type="text" class="form-control form_datetime" placeholder="" aria-describedby="basic-addon1"FieldName="_date_birth" lay-verify="date" value="${GetDateString(_date_birth)}"  readonly>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">联系电话</span>
							<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="_Mobile" value="${_mobile}">
						</div>
					</div>
				</div>
				<input type="hidden" FieldName="_id" value="${_id}">
				<input type="hidden" FieldName="_ApplyID" value="${_ApplyID}">
				<input type="hidden" FieldName="_id_Ebo" value="<%=
      ID
    %>">
				<input type="hidden" FieldName="_Name" value="">
				<input type="hidden" FieldName="_name_c" value="">
				<input type="hidden" FieldName="_name_e" value="">
				<input type="hidden" FieldName="_PassPort" value="">
				<input type="hidden" FieldName="_id_avg" value="${_id_avg}">
				<input type="hidden" FieldName="_id_ava" value="${_id_ava}">
			</div>
			<div class="taobao">
				<span>飞猪申请人信息：</span>
				<span>【申请人】:</span><span id="surnamePinyin"></span>/<span id="givenNamePinyin"></span><span>;</span>
				<span>【applyId】:</span><span id ="applyId"></span><span>;</span>
				<span>【当前状态】:</span><span id="currentApplyStatus"></span><span>;</span>
				<span>【下一状态】:</span><span id="nextApplyStatus"></span><span>;</span>
			</div>
			<div class="taobao ApplicationUpdateButton" >
			</div>
			<div>
				<button onclick="Scan('${_id}');" disabled="disabled" class="btn btn-primary ScanButton">扫描</button>
				<!--  <button onclick="UpdateApplicantInfos('${_id}');" class="btn btn-primary">保存并更新申请人基本信息</button>-->
			</div>
		</div>
	</div>
</script>
  <script type="text/javascript">
	var TaoBaoVisaState=<%=new TaobaoService().GetVisaStateList().toString()%>
</script>
  <script type="text/javascript">
	function SendApplicationState(t)
	{
		var state=$(t).attr("state");
		var KeyID=$(t).attr("KeyID");
	}
	

	function UpdateApplicantInfos(id)
	{

		var $loadingToast = $('#loadingToast');

		$loadingToast.fadeIn(100);
		
		var NameJson={};
		$("[NameID="+id+"] [FieldName]").each(function(){
			var FieldName=$(this).attr("FieldName");
			var value=$(this).val();
			NameJson[FieldName]=value;
		})
			NameJson["_Name"]=$("[NameID="+id+"] [FieldName=_lastname_c]").val()+""+$("[NameID="+id+"] [FieldName=_firstname_c]").val();
			NameJson["_name_c"]=$("[NameID="+id+"] [FieldName=_lastname_c]").val()+""+$("[NameID="+id+"] [FieldName=_firstname_c]").val();
			NameJson["_name_e"]=$("[NameID="+id+"] [FieldName=_lastname_e]").val()+" "+$("[NameID="+id+"] [FieldName=_firstname_e]").val();
			NameJson["_PassPort"]=$("[NameID="+id+"] [FieldName=_PassPortNo]").val();
			
		var OrderNo=$(".OrderInfo [FieldName=OrderNo]").val();
		var JsonData={"OrderNo":OrderNo,"DataRows":[NameJson]}
		console.log(JsonData);
		
		$.post("<%=request.getContextPath()%>/web/visa/ota/BookingOrderNameListPostServlet.json?d="+new Date().getTime(),JSON.stringify(JsonData),function(data){
			//console.log(data);
			$loadingToast.fadeOut(100);
			if (data.MsgID!=1)
			{
				alert(data.MsgText);
			}
			else
			{
				alert("申请人信息保存成功！");
				Query();
			}
		},"json");
		//console.log(JsonData);
		
	}

	function UpdateApplicantInfosAll()
	{
	  var r=true;

    $("[FieldName=_age]").each(function(){
      $(this).removeClass('DateInvalid');
      var v=$(this).val();
      console.log(v);
      if (!v || isNaN(v)){
        $(this).addClass('DateInvalid');
        alert('请填写【年龄】');
        r=false;
        return false;
      } 
    })
    
    if (!r)
    {
      return;
    }
    if (!CheckDateFormat()){
      alert('日期填写错误！');
      return false;
    }

    $("[FieldName=_date_End]").each(function(){
      $(this).removeClass('DateInvalid');
      var d=$(this).val();
      if (d!=''){
        console.log(d);
        var d1=new Date(d).getTime();
        var d2=new Date().getTime();
        var d3=d1-d2;
        d3=d3/1000/60/60/24;
        console.log(d3);
        if (d3<30*6){
          $(this).addClass('DateInvalid');
          alert('签证有效期小于180天！<br>当前剩余有效天数：'+parseInt(d3)+'');
          return;
        }
      }
    })
      
		var $loadingToast = $('#loadingToast');

		$loadingToast.fadeIn(100);
		
		var DataRows=[];
		$("#NameDiv [NameID]").each(function(index){
			var NameJson={};
			var id =$(this).attr("NameID");

			//console.log(id);
			$("[NameID="+id+"] [FieldName]").each(function(){
				var FieldName=$(this).attr("FieldName");
				var value=$(this).val();
				NameJson[FieldName]=value;
			})
			
			NameJson["_Name"]=$("[NameID="+id+"] [FieldName=_lastname_c]").val()+""+$("[NameID="+id+"] [FieldName=_firstname_c]").val();
			NameJson["_name_c"]=$("[NameID="+id+"] [FieldName=_lastname_c]").val()+""+$("[NameID="+id+"] [FieldName=_firstname_c]").val();
			NameJson["_name_e"]=$("[NameID="+id+"] [FieldName=_lastname_e]").val()+" "+$("[NameID="+id+"] [FieldName=_firstname_e]").val();
			NameJson["_PassPort"]=$("[NameID="+id+"] [FieldName=_PassPortNo]").val();
			DataRows[index]=NameJson;
			
		})

		var OrderNo=$(".OrderInfo [FieldName=OrderNo]").val();
		var ID=<%=ID%>;
		var JsonData={"OrderNo":OrderNo,"ID":ID,"DataRows":DataRows}
		//console.log(JsonData);
		
		$.post("<%=request.getContextPath()%>/web/visa/ota/BookingOrderNameListPostServlet.json?d="+new Date().getTime(),JSON.stringify(JsonData),function(data){
			//console.log(data);
			$loadingToast.fadeOut(100);
			if (data.MsgID!=1)
			{
				alert(data.MsgText);
			}
			else
			{
				alert("申请人信息保存成功！");
				Query();
			}
		},"json");
		//console.log(JsonData);
		
	}

	function PostApplicationState(t)
	{

		//console.log(t);
		var id =$(t).attr("KeyID");
		var state=$(t).attr("state");		
		var ApplyID=$("[NameID="+id+"] [FieldName=_ApplyID]").val();
		var OrderNo=$(".OrderInfo [FieldName=OrderNo]").val();
		var eobID=<%=ID%>;
		var JsonData={"OrderNo":OrderNo,"ApplyID":ApplyID,"state":state,"eobID":eobID};
		
		var DataRows={"DataRows":[JsonData]};
		console.log(DataRows);
		SendApplicationState(DataRows);
	}
	
	function PostApplicationStateAll(t)
	{


		var DataRow=[];
		var state=$(t).attr("state");
		var OrderNo=$(".OrderInfo [FieldName=OrderNo]").val();
		var eboID=<%=ID%>;
		
		$("[NameID] [FieldName=_ApplyID]").each(function(index){
			var ApplyID=$(this).val();
			var JsonData={"OrderNo":OrderNo,"ApplyID":ApplyID,"state":state,"eboID":eboID};
			DataRow[index]=JsonData;
		})
		
		
		var DataRows={"DataRows":DataRow};
		//console.log(DataRows);
		SendApplicationState(DataRows);
	}
	function SendApplicationState(DataRows)
	{

		//return;

		var $loadingToast = $('#loadingToast');
		$loadingToast.fadeIn(100);
		$.post("<%=request.getContextPath()%>/web/taobao/AlitripTravelvisaApplicantUpdate.json?d="+new Date().getTime(),JSON.stringify(DataRows),function(data){
			//console.log(data);
			$loadingToast.fadeOut(100);
			if (data.MsgID!=1)
			{
				alert(data.MsgText);
			}
			else
			{
				alert("申请人签证进度更新成功！");
				Query();
			}
		},"json");
		//console.log(JsonData);
	}
	
	function Query()
	{

		var $loadingToast = loadingToast();
		$.ajax({
			url: '<%=request.getContextPath() %>/web/taobao/AlitripTravelVisaApplicantQuery.json?ID=<%=ID%>&d=' + new Date().getTime(),
          type : 'get',
          dataType : 'Json',
          success : function(data) {
            //console.log(data);
            //$loadingToast.fadeOut(100);
            if (data.MsgID != 1) {
              alert(data.MsgText);
              return;
            } else {
              $(".MenuButton").show();
              $(".ApplicationUpdateButtonList").show();
              $(".OrderInfo [FieldName=OrderNo]").val(data.OrderNo);
              //console.log(data.NameList);
              $("#NameDiv").html("");

              var TemplateData = data.NameList;
              for (i in TemplateData) {
                console.log((TemplateData[i]._date_Sign == undefined));
                console.log(TemplateData[i]._date_Sign);
                TemplateData[i]._date_Sign = TemplateData[i]._date_Sign == undefined ? '' : TemplateData[i]._date_Sign;
                console.log(TemplateData[i]._date_Sign);
                TemplateData[i]._date_End = TemplateData[i]._date_End == undefined ? '' : TemplateData[i]._date_End;
                TemplateData[i]._date_birth = TemplateData[i]._date_birth == undefined ? '' : TemplateData[i]._date_birth;
              }
              console.log(TemplateData);
              $("#NameDataTemplate").tmpl(TemplateData).appendTo('#NameDiv');

              $('.form_datetime').datetimepicker({
                weekStart : 0, //一周从哪一天开始
                todayBtn : 1, //
                autoclose : 1,
                todayHighlight : 1,
                startView : 2,
                minView : 2,
                forceParse : 0,
                showMeridian : 1,
                language : 'zh-CN',
                format : 'yyyy-mm-dd',
                startDate : '2000-01-01'
              });

              $(".ApplicationUpdateButton button").hide();
              $(".ApplicationUpdateButtonList button").hide();

              var traveller_info = data.taobao.alitrip_travel_trade_query_response.first_result.sub_orders.sub_order_info[0].travellers.traveller_info;

              //console.log(traveller_info);
              if (traveller_info) {
                $("[NameID]").each(function(index) {
                  var id = $(this).attr("NameID");
                  var info = traveller_info[index];
                  if (info) {
                    //console.log("index:"+index);
                    var credential_no = info.credential_no;
                    var phone = info.phone;
                    var extend_attributes_json = JSON.parse(info.extend_attributes_json);

                    var applyId = extend_attributes_json.applyId;
                    var surnamePinyin = extend_attributes_json.surnamePinyin;
                    var givenNamePinyin = extend_attributes_json.givenNamePinyin;
                    var holdStatus = extend_attributes_json.holdStatus;
                    var nextApplyStatus = extend_attributes_json.nextApplyStatus;
                    var currentApplyStatus = extend_attributes_json.currentApplyStatus;

                    if ($(this).find("[FieldName=_lastname_e]").val() == "") {
                      $(this).find("[FieldName=_lastname_e]").val(surnamePinyin);
                    }
                    if ($(this).find("[FieldName=_firstname_e]").val() == "") {
                      $(this).find("[FieldName=_firstname_e]").val(givenNamePinyin);
                    }

                    if ($(this).find("[FieldName=_lastname_c]").val() == "") {
                      $(this).find("[FieldName=_lastname_c]").val(surnamePinyin);
                    }
                    if ($(this).find("[FieldName=_firstname_c]").val() == "") {
                      $(this).find("[FieldName=_firstname_c]").val(givenNamePinyin);
                    }

                    $(this).find("[FieldName=_ApplyID]").val(applyId);
                    if ($(this).find("[FieldName=_Mobile]").val() == "") {
                      $(this).find("[FieldName=_Mobile]").val(phone);
                    }

                    $(this).find("[FieldName=_Name]").val(surnamePinyin + "" + givenNamePinyin);
                    $(this).find("[FieldName=_name_c]").val(surnamePinyin + "" + givenNamePinyin);
                    $(this).find("[FieldName=_name_e]").val(surnamePinyin + " " + givenNamePinyin);
                    $(this).find("[FieldName=_PassPortNo]").val(credential_no);
                    $(this).find("[FieldName=_PassPort]").val(credential_no);

                    var taobao = $(this).find(".taobao");
                    taobao.find("#surnamePinyin").html(surnamePinyin);
                    taobao.find("#givenNamePinyin").html(givenNamePinyin);
                    taobao.find("#applyId").html(applyId);
                    taobao.find("#currentApplyStatus").html(TaoBaoVisaState[currentApplyStatus] + "[" + currentApplyStatus + "]");
                    taobao.find("#nextApplyStatus").html(nextApplyStatus);

                    var statusJson = JSON.parse(nextApplyStatus);

                    //console.log(statusJson);
                    for (i in statusJson) {
                      $("button[KeyID=" + id + "][state=" + statusJson[i] + "]").show();
                      $(".ApplicationUpdateButtonList button[state=" + statusJson[i] + "]").show();
                    }

                    //console.log("credential_no:"+credential_no+";phone:"+phone+";extend_attributes_json:"+extend_attributes_json);
                  }
                });
              }
              //for (index in traveller_info )
              //{
              //	console.log(traveller_info[index]);
              //	var credential_no=traveller_info[index].credential_no;
              //	var phone=traveller_info[index].phone;
              //	var extend_attributes_json=JSON.parse(traveller_info[index].extend_attributes_json);
              //	console.log(extend_attributes_json);
              //	var applyId=extend_attributes_json.applyId;
              //	var surnamePinyin=extend_attributes_json.surnamePinyin;
              //	var givenNamePinyin=extend_attributes_json.givenNamePinyin;
              //	var holdStatus=extend_attributes_json.holdStatus;
              //	var nextApplyStatus=extend_attributes_json.nextApplyStatus;
              //	var currentApplyStatus=extend_attributes_json.currentApplyStatus;
              //	
              //	console.log("credential_no:"+credential_no+";phone:"+phone+";extend_attributes_json:"+extend_attributes_json);
              //}

            }

            $loadingToast.modal("hide");
          }
        })
      }
      $(function() {
        for (state in TaoBaoVisaState) {
          //console.log("state:"+state);
          //"1001":"无办理人信息",
          //"1002":"办理人已填写",
          //if (state!="1001" && state!="1002")
          //{
          var b = '<button onclick=\"PostApplicationState(this);\" state=\"' + state + '\" KeyID="${_id}" class=\"btn btn-info btn-sm\">' + TaoBaoVisaState[state] + '[' + state + ']' + '</button>'
          $("#NameDataTemplate .ApplicationUpdateButton").append(b);

          var b2 = '<button onclick=\"PostApplicationStateAll(this);\" state=\"' + state + '\" class=\"btn btn-info btn-sm\">' + TaoBaoVisaState[state] + '[' + state + ']' + '</button>'
          $(".ApplicationUpdateButtonList").append(b2)

          //}

        }
        Query();
      })

      function Scan(id) {

        var WaitScan = $('#WaitScan');
        WaitScan.fadeIn(100);

        $.ajax({
          url : 'http://127.0.0.1:58001/?Scan',
          type : 'get',
          dataType : 'Json',
          success : function(data) {
            //console.log(data);
            if (data.ErrCode == '1') {

              var tr = $("#NameDiv [NameID=" + id + "]");
              console.log(tr);
              tr.find("[FieldName=_name_c]").val(data.Field2);
              tr.find("[FieldName=_name_e]").val(data.Field3);
              tr.find("[FieldName=_PassPortNo]").val(data.Field1);
              if (data.Field23 == "男") {
                tr.find("[FieldName=_sex]").val(1);
              } else {
                tr.find("[FieldName=_sex]").val(2);
              }

              tr.find("[FieldName=_date_birth]").val(data.Field5);
              tr.find("[FieldName=_date_Sign]").val(data.Field16);
              tr.find("[FieldName=_date_End]").val(data.Field6);
              tr.find("[FieldName=_place_issue]").val(data.Field15);
              tr.find("[FieldName=_country_code]").val(data.Field12);

              var d = new Date() - new Date(data.Field5);
              d = d / (1000 * 60 * 60 * 24 * 365)
              tr.find("[FieldName=_age]").val(d.toFixed(0));
              tr.find("[FieldName=_firstname_e]").val(data.Field9);
              tr.find("[FieldName=_lastname_e]").val(data.Field8);

              var name_c = data.Field2;

              var index2 = name_c.length;

              tr.find("[FieldName=_lastname_c]").val(name_c.substring(0, 1));
              tr.find("[FieldName=_firstname_c]").val(name_c.substring(1, index2));

            }
            WaitScan.fadeOut(100);
          }
        })
      }
      function DeviceInit() {
        var $loadingToast = loadingToast("扫描仪连接中");
        $.ajax({
          url : 'http://127.0.0.1:58001/?DeviceInit',
          type : 'get',
          dataType : 'Json',
          success : function(data) {

            $loadingToast.modal("hide");
            //			console.log(data);
            if (data.ErrCode == '1') {
              $(".ScanButton").removeAttr("disabled");
            } else {
              alert(data.ErrMsg);
            }
          },
          error : function(Req, err, e) {
            $loadingToast.modal("hide");
            alert("扫描仪连接失败");
          }
        })
      }
      function CheckDateFormat() {
        var r = true;
        $("[lay-verify=date]").each(function() {
          $(this).removeClass('DateInvalid');
          var d = $(this).val();
          if (d != '') {
            if (!IsDate(d)) {
              $(this).addClass('DateInvalid');
              r = false;
            }
          }
        })
        return r;
      }
    </script>
</body>
</html>