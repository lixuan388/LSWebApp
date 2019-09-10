<%@page import="com.ecity.java.web.ls.Parameter.Json.SourceSupplierInfoJson"%>
<%@page import="com.ecity.java.mvc.service.system.SystemService"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="com.ecity.java.mvc.service.visa.ota.BookingOrderService"%>
<%@page import="com.ecity.java.mvc.dao.uilts.SQLUilts"%>
<%@page import="com.ecity.java.web.WebFunction"%>
<%@page import="com.ecity.java.json.JSONArray"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.SourceInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.VisaTypeJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.VisaSpeedJson"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.java.sql.SQLCon"%>
<%@page import="com.ecity.java.json.JSONObject"%>
<%@page import="com.ecity.java.sql.table.MySQLTable"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.SupplierInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.CountryJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
<%@ page isELIgnored="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String ID=request.getParameter("ID")==null?"":request.getParameter("ID");
if (ID.equals(""))
{
	WebFunction.GoErrerHtml(request,response,"缺少参数（ID）");
	return;
}


JSONObject OrderJson=new JSONObject();

int epgd_num=0;

int avg_id_asi=3279;
String Ebo_SourceGuest="";
String avg_id="0";
MySQLTable ebo= new MySQLTable("select Ebo_SourceOrderNo,avs_id_act,avs_id,ebop_saleMoney as Epi_SaleMoney,Ebo_LinkMan,Ebo_Phone,Ebo_Addr,Ebo_Remark,Ebo_SourceGuest,act_name_aar,act_id_aar,act_id_asi,\r\n" +
		"count(0) as epgd_num\r\n"+
		"from Epi_Product_Info,Ebop_BookingOrder_Package,Ebo_BookingOrder,avs_visa_speed,act_country\r\n" + 
		"where epi_id=Ebop_id_Epi and ebop_id_ebo=ebo_id\r\n" + 
		"and Epi_InSideID=avs_id and epi_type=1 and act_id=Epi_id_act\r\n" + 
		"and Ebo_id="+ID +"\r\n"+
		"group by Ebo_SourceOrderNo,avs_id_act,avs_id,ebop_saleMoney,Ebo_LinkMan,Ebo_Phone,Ebo_Addr,Ebo_Remark,Ebo_SourceGuest,act_name_aar,act_id_aar,act_id_asi");
try
{
	ebo.Open();
	if (ebo.next())
	{
		BookingOrderService service=new BookingOrderService();
		NumberFormat numberFormat = NumberFormat.getNumberInstance();
		
		float saleMoney=service.getCountryVisaSpeedMoney( ebo.getInt("avs_id"), avg_id_asi);
		
		OrderJson.put("avg_id_act", ebo.getInt("avs_id_act"));
		OrderJson.put("avg_id_avs", ebo.getInt("avs_id"));
		OrderJson.put("avg_id_type", 1000);
		OrderJson.put("avg_price", numberFormat.format(saleMoney));
		OrderJson.put("avg_num", ebo.getInt("epgd_num"));
		epgd_num= ebo.getInt("epgd_num");
		Ebo_SourceGuest=ebo.getString("Ebo_SourceGuest");
		OrderJson.put("avg_remark", ebo.getString("Ebo_Remark"));
		OrderJson.put("avg_groupcode", ebo.getString("Ebo_SourceOrderNo"));
		OrderJson.put("avg_Source_link", ebo.getString("Ebo_LinkMan"));
		OrderJson.put("avg_Source_tel", ebo.getString("Ebo_Phone"));
		OrderJson.put("avg_Source_addr", ebo.getString("Ebo_Addr"));
		OrderJson.put("avg_amount", numberFormat.format(saleMoney*ebo.getInt("epgd_num")));
		OrderJson.put("avg_actamt", 0);
		OrderJson.put("avg_remain", numberFormat.format(saleMoney*ebo.getInt("epgd_num")));

		OrderJson.put("avg_name_aar", ebo.getString("act_name_aar"));
		OrderJson.put("avg_id_aar", ebo.getString("act_id_aar"));
		
		OrderJson.put("avg_invoiceno", SQLUilts.GetInvoicenoOutput(ebo.getInt("avs_id_act")));
    OrderJson.put("avg_SupplierID",ebo.getInt("act_id_asi"));
    
    System.out.println("act_id_asi:"+ebo.getInt("act_id_asi"));
	}
}
finally
{
	ebo.Close();	
}


OrderJson.put("avg_source", "同行");
OrderJson.put("avg_state","录入");
OrderJson.put("avg_user_enter",request.getSession().getAttribute("UserName"));
OrderJson.put("avg_username_lst",request.getSession().getAttribute("UserName"));

java.text.DateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
java.text.DateFormat format2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
String now = format.format(new Date());
String now2 = format2.format(new Date());


SystemService service = new SystemService();
String ReturnDate = service.GetVisaNextWorkDate(OrderJson.getString("avg_id_avs"),OrderJson.getString("avg_id_act"), now2);
    
    
    
OrderJson.put("avg_date_enter",now);
OrderJson.put("avg_date_sign",now);
OrderJson.put("avg_date_start",now);
OrderJson.put("avg_date_send",ReturnDate);

String DepartmentID=(String)request.getSession().getAttribute("DepartmentID");
if (DepartmentID.equals("3"))
{
//默认转单广州莱尚
OrderJson.put("avg_id_aco_to",1);
}
else
{
//默认转单广州莱尚
OrderJson.put("avg_id_aco_to",-1);
}

//广州电商
OrderJson.put("avg_id_aco",DepartmentID);
OrderJson.put("avg_id_ast",14);
OrderJson.put("avg_id_asi",avg_id_asi);
OrderJson.put("avg_SourceName","广州大方（FY)");

avg_id=SQLUilts.GetMaxID(SQLCon.GetConnect(), "avg_id");

OrderJson.put("avg_id",avg_id);


JSONArray VisaSignDetilJson = new JSONArray();

MySQLTable Ebon= new MySQLTable("select ebon_id,ebon_PassPort,Ebon_Name,Ebon_name_e,Ebon_sex,CONVERT(varchar(10),Ebon_date_birth,120) as Ebon_date_birth,CONVERT(varchar(10),Ebon_date_Sign,120) as Ebon_date_Sign,CONVERT(varchar(10),Ebon_date_End,120) as Ebon_date_End,Ebon_place_issue,"+
		"Ebon_country_code,Ebon_mobile,Ebon_age from  Ebon_BookingOrder_NameList where ebon_id_ebo="+ID );
try
{
	Ebon.Open();
	while (Ebon.next())
	{
		JSONObject DataJson = new JSONObject();   

		DataJson.put("ava_id",SQLUilts.GetMaxID(SQLCon.GetConnect(), "ava_id"));

		if (Ebon.getString("Ebon_Name").equals(""))
		{
			DataJson.put("ava_name_c", Ebo_SourceGuest);
		}
		else
		{
			DataJson.put("ava_name_c", Ebon.getString("Ebon_Name"));
		}
		
		DataJson.put("ava_StatusType", "录入");
		DataJson.put("ava_State", "报名");
		DataJson.put("ava_name_e", Ebon.getString("Ebon_name_e"));
		DataJson.put("ava_name_p",  Ebon.getString("Ebon_name_e"));
		DataJson.put("ava_PassPortNo", Ebon.getString("ebon_PassPort"));
		DataJson.put("ava_sex", Ebon.getString("Ebon_sex"));
		DataJson.put("ava_Remark", "");
		
		DataJson.put("ava_date_birth", Ebon.getString("Ebon_date_birth"));
		DataJson.put("ava_Date_Sign", Ebon.getString("Ebon_date_Sign"));
		DataJson.put("ava_Date_End",Ebon.getString("Ebon_date_End"));
		DataJson.put("ava_place_issue", Ebon.getString("Ebon_place_issue"));
		DataJson.put("ava_country_code", Ebon.getString("Ebon_country_code"));
		DataJson.put("ava_mobile",Ebon.getString("Ebon_mobile"));
		DataJson.put("ava_age",Ebon.getString("Ebon_age"));
		DataJson.put("ava_id_avg",avg_id);
		DataJson.put("ebon_id", Ebon.getString("ebon_id"));
		
		VisaSignDetilJson.put(DataJson);
	}
}
finally
{
	Ebon.Close();	
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/head.jsp" />
<script src="<%=request.getContextPath()%>/res/js/bootstrap-treeview.min.js"></script>
<link href="<%=request.getContextPath()%>/Content/index.css" rel="stylesheet">
<link href="/Res/js/jquery.select2/css/select2.min.css" rel="stylesheet" />
<script src="/Res/js/jquery.select2/js/select2.min.js"></script>
<title>生成签证订单</title>
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

.select-mania-inner {
  border-color: red;
}

.table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
    padding: 1px;
}

</style>
</head>
<body>
  <div style="padding: 20px;">
    <div class="VisaSignInfo">
      <div class="DataRow">
        <span class="caption">业务部门：</span><input class="DSTextEdit " type="text" value="<%=(String)request.getSession().getAttribute("DepartmentName") %>"  readonly>
      </div>
      <div class="DataRow">
        <span class="caption">受理号：</span><input class="DSTextEdit " type="text" FieldName="avg_invoiceno" readonly> <span class="caption">客户类别：</span><input class="DSTextEdit " type="text"
          FieldName="avg_source" readonly
        > <span class="caption">客人姓名：</span><input class="DSTextEdit lookup " type="text" FieldName="avg_id_asi" readonly> <span class="caption">订单编号：</span><input class="DSTextEdit "
          type="text" FieldName="avg_groupcode" readonly
        >
      </div>
      <div class="DataRow">
        <span class="caption">办理国家：</span><input class="DSTextEdit lookup" type="text" FieldName="avg_id_act" readonly> <span class="caption">办理种类：</span><input class="DSTextEdit lookup"
          type="text" FieldName="avg_id_avs" readonly
        > <span class="caption">办理类型：</span><input class="DSTextEdit lookup" type="text" FieldName="avg_id_type" readonly>
      </div>
      <div class="DataRow">
        <span class="caption">单价：</span><input class="DSTextEdit" type="text" FieldName="avg_price" readonly> <span class="caption">办理人数：</span><input class="DSTextEdit" type="text"
          FieldName="avg_num" readonly
        >
      </div>
      <div class="DataRow">
        <span class="caption">应收：</span><input class="DSTextEdit" type="text" FieldName="avg_amount" readonly> <span class="caption">实收：</span><input class="DSTextEdit" type="text"
          FieldName="avg_actamt" readonly
        > <span class="caption">待收：</span><input class="DSTextEdit" type="text" FieldName="avg_remain" readonly> <span class="caption">供应商：</span>
        <!--  <input class="DSTextEdit" type="text" FieldName="avg_SupplierID" readonly>-->
        <div style="display: inline-block; width: 160px;">
          <select class="avg_SupplierID" FieldName="avg_SupplierID" style="width:100%">
          </select>
        </div>
      </div>
      <div class="DataRow">
        <span class="caption">备注：</span><input class="DSTextEdit" type="text" FieldName="avg_remark" style="width: 892px;">
      </div>
      <div class="DataRow">
        <span class="caption">订单状态：</span><input class="DSTextEdit" type="text" FieldName="avg_state" readonly> <span class="caption">联系人：</span><input class="DSTextEdit" type="text"
          FieldName="avg_Source_link"
        > <span class="caption">联系电话：</span><input class="DSTextEdit" type="text" FieldName="avg_Source_tel">
      </div>
      <div class="DataRow">
        <span class="caption">联系地址：</span><input class="DSTextEdit" type="text" FieldName="avg_Source_addr" style="width: 892px;">
      </div>
      <div class="DataRow">
        <span class="caption">送签日期：</span><input class="DSTextEdit form_datetime" type="text" FieldName="avg_date_send" readonly onchange="CreateVisaSign_GetReturnDate()"> <span
          class="caption"
        >出签日期：</span><input class="DSTextEdit form_datetime" type="text" FieldName="avg_date_rtn" readonly>
      </div>
      <div class="DataRow">
        <span class="caption">录入人：</span><input class="DSTextEdit" type="text" FieldName="avg_user_enter" readonly> <span class="caption">录入日期：</span><input class="DSTextEdit" type="text"
          FieldName="avg_date_enter" readonly
        >
      </div>
      <input class="DSTextEdit" type="hidden" FieldName="avg_id"> <input class="DSTextEdit" type="hidden" FieldName="avg_date_sign"> <input class="DSTextEdit" type="hidden"
        FieldName="avg_date_start"
      > <input class="DSTextEdit" type="hidden" FieldName="avg_id_aco"> <input class="DSTextEdit" type="hidden" FieldName="avg_id_aco_to"> <input class="DSTextEdit" type="hidden"
        FieldName="avg_name_aar"
      > <input class="DSTextEdit" type="hidden" FieldName="avg_id_aar"> <input class="DSTextEdit" type="hidden" FieldName="avg_username_lst"> <input class="DSTextEdit" type="hidden"
        FieldName="avg_id_ast"
      > <input class="DSTextEdit" type="hidden" FieldName="avg_SourceName">
    </div>
    <div class="VisaSignDetil" style="overflow-x: auto; overflow: auto; height: 100%;">
      <table class="table table-hover table-striped  DataTable" style="max-width: inherit;">
        <thead>
          <tr>
            <td style="width: 80px;" width=80>&nbsp;</td>
            <td style="width: 100px;" width=100>订单状态</td>
            <td style="width: 100px;" width=100>中文姓名</td>
            <td style="width: 150px;" width=150>英文姓名</td>
            <td style="width: 200px;" width=200>身份证</td>
            <td style="width: 150px;" width=120>护照号码</td>
            <td style="width: 80px;" width=80>性别</td>
            <td style="width: 150px;" width=120>出生年月</td>
            <td style="width: 150px;" width=120>签发日期</td>
            <td style="width: 150px;" width=120>有效期至</td>
            <td style="width: 100px;" width=100>签发地</td>
            <td style="width: 100px;" width=100>国家代码</td>
            <td style="width: 120px;" width=120>电话号码</td>
            <td style="width: 60px;" width=60>年龄</td>
            <td style="width: 120px;" width=120>备注</td>
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
      <button id="DeviceInitButton" type="button" class="btn	btn-success" onclick="CreateVisaSign_DeviceInit()">连接扫描仪</button>
      <button id="saveButton" type="button" class="btn	btn-danger" onclick="CreateVisaSign_Post()">保存签证订单</button>
      <button id="PrintVisaButton" type="button" class="btn	btn-success" disabled="disabled" onclick="CreateVisaSign_PrintVisa(<%=avg_id%>)">打印签证标签</button>
    </div>
  </div>
  <script id="DetilTableTemplate" type="text/html">
	<tr  data-id="${ava_id}" data-ebon_id=${ebon_id}>
		<td>
			<button onclick="CreateVisaSign_Scan('${ava_id}');" disabled="disabled" class="btn btn-primary ScanButton">扫描</button>
		</td>
		<td>
			<input class="form-control" type="text" FieldName="ava_StatusType" readonly  value="${ava_StatusType}">		
			<input type="hidden" FieldName="ava_id" value="${ava_id}">
			<input type="hidden" FieldName="ava_id_avg" value="${ava_id_avg}">
		</td>
		<td><input class="form-control" type="text" FieldName="ava_name_c"  value="${ava_name_c}"></td>
		<td><input class="form-control" type="text" FieldName="ava_name_e"  value="${ava_name_e}"></td>
		<td><input class="form-control" type="text" FieldName="ava_idcard"  value="${ava_idcard}"></td>
		<td><input class="form-control" type="text" FieldName="ava_PassPortNo"  value="${ava_PassPortNo}"></td>
		<td><select class="form-control" type="text" FieldName="ava_sex"  value="${ava_sex}"><option value="1" {%if (ava_sex=='1') %}selected{%else%}{%/if%}>男</option><option value="2" {%if (ava_sex=='2') %}selected{%else%}{%/if%}>女</option></select>
		</td>
		<td><input class="form-control form_datetime" type="text" FieldName="ava_date_birth"  value="${ava_date_birth}"></td>
		<td><input class="form-control form_datetime" type="text" FieldName="ava_Date_Sign"  value="${ava_Date_Sign}"></td>
		<td><input class="form-control form_datetime" type="text" FieldName="ava_Date_End"  value="${ava_Date_End}"></td>
		<td><input class="form-control" type="text" FieldName="ava_place_issue"  value="${ava_place_issue}"></td>
		<td><input class="form-control" type="text" FieldName="ava_country_code"  value="${ava_country_code}"></td>
		<td><input class="form-control" type="text" FieldName="ava_mobile"  value="${ava_mobile}"></td>
		<td><input class="form-control" type="text" FieldName="ava_age"  value="${ava_age}"></td>
		<td><input class="form-control" type="text" FieldName="ava_Remark"  value="${ava_Remark}"></td>
	</tr>
</script>
  <script type="text/javascript">
	var CountryName = GetParameterData('CountryName');
	var VisaSpeedName=GetParameterData('VisaSpeedName');
	var VisaTypeName=GetParameterData('VisaTypeName');
  var SourceInfoName=GetParameterData('SourceInfoName');
  var SourceSupplierInfoName=GetParameterData('SourceSupplierInfoName');
  
  for (item in SourceSupplierInfoName){
    $('.avg_SupplierID').append('<option value="'+item+'">'+SourceSupplierInfoName[item]+'</option>');
  }
    
</script>
  <script type="text/javascript">
 var data={"VisaSignInfo":<%=OrderJson.toString()%>,"VisaSignDetil":<%=VisaSignDetilJson.toString()%>};

	<%@ include file = "/Content/BookingOrder/Form/CreateVisaSign.js" %>
</script>
</body>
</html>