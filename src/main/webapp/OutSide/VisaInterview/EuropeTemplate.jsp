<%@page import="com.ecity.java.web.WebFunction"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.java.sql.SQLCon"%>
<%@page import="com.ecity.java.sql.db.DBTable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String ID=request.getParameter("ID")==null?"":(String )request.getParameter("ID");
if (ID.equals(""))
{
  return;
}

DBTable table =new DBTable(SQLCon.GetConnect(),"select avin_name_act,avin_name,avin_name_bvac,avin_name_vis,avin_date_meet,avin_address_bvac,avin_Metro_bvac,avin_user_send,avin_data,avin_process_bvac from avin_visa_interview_notice where avin_status<>'D' and avin_id="+ID);
String Country="";
String GuestName="";
String Department="";
String VIS="";
String BookingDate="";
String Address="";
String Metro="";
String SendName="";
String VisaData="";
String Process="";


    try {
  table.Open();
  if (table.next()) {
    Country=table.getString("avin_name_act");
    GuestName=table.getString("avin_name");
    Department=table.getString("avin_name_bvac");
    VIS=table.getString("avin_name_vis");
    
    BookingDate=table.getString("avin_date_meet");
    Address=table.getString("avin_address_bvac");
    Metro=table.getString("avin_Metro_bvac");
    SendName=table.getString("avin_user_send");
    VisaData=table.getString("avin_data").replaceAll("(\r\n|\n)", "<br>");;
    Process=table.getString("avin_process_bvac");
    
  }
  else {
    return;
  }
    }catch (SQLException e) {
  // TODO Auto-generated catch block
  e.printStackTrace();
    } finally {
  // TODO: handle finally clause
  table.CloseAndFree();
    }
    if (!VIS.equals(""))
    {
  VIS=VIS+"有指纹记录，无需本人亲自前往";
    }
    if (!Process.equals("")){
  Process="<img src='http://ls.17ecity.cc:18888/UploadFile/"+Process+"'>";
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>预约通知</title>
<style type="text/css">
body>div{
  padding-top:31.1500pt;
  padding-bottom:23.4000pt;
  padding-left:36.0000pt;
  padding-right:36.0000pt;
}
    body.WordPage {
      width:1020px;
      margin-left: auto;
      margin-right: auto;
      height: 100%;
      padding: 0px;
      /*width: 100%;*/
      
      font-family: Arial,sans-serif;
      font-size: 18px;
      z-index:-10000;
    }
</style>
</head>
<body class="WordPage">
<div>
<p style="margin-right:7px;text-align:center;line-height:150%">
    <strong><span style=";font-family:宋体;line-height:150%;font-weight:bold;font-size:24px"><span style="font-family:宋体"><%=Country%></span></span></strong><strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:24px"><span style="font-family:宋体">签证申请递交通知</span></span></strong>
</p>
<p style="margin-right:7px;line-height:150%">
<strong>
    <span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:16px"><span style="font-family:宋体">&nbsp;&nbsp;应<%=Country%>驻广州总领事馆通知</span></span></strong>
    <strong><span style="text-decoration:underline;">
    <span style=";font-family:Calibri;line-height:150%;font-weight:bold;text-underline:single;font-size:16px"><%=GuestName%></span></span></strong>
    
    <strong><span style=";font-family:宋体;line-height:150%;font-weight:bold;text-underline:single;font-size:16px">
    <span style="font-family:宋体">，在<%=Country%>驻广州总领事馆下设<%=Department%>接受</span></span></strong>
    <strong><span style="text-decoration:underline;"><span style=";font-family:Calibri;line-height:150%;color:rgb(255,0,0);font-weight:bold;text-underline:single;font-size:16px">
    <span style="font-family:宋体">签证资料递交申请及双手指纹采集（需本人亲自前往）</span></span></span></strong><strong>
    <span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:16px"><span style="font-family:宋体">，请准备好相关材料。</span></span></strong>
</p>
<p style="margin-right:7px;line-height:150%">
    <strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:16px"><span style="font-family:宋体"><%=VIS %><br/></span></span></strong>
</p>
<p style="margin-right:7px;line-height:150%">
    <strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:16px"><span style="font-family:宋体">时间：</span></span></strong><strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:16px"> <%=BookingDate%></span></strong><strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:16px"></span></strong>
</p>
<p style="margin-right:7px;line-height:150%">
    <strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:16px"><span style="font-family:宋体">地址：<%=Address%></span></span></strong><strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:16px"><span style="font-family:宋体"></span></span></strong>
</p>
<p style="margin-right:7px;line-height:150%">
    <strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:16px"><span style="font-family:宋体">地铁指引</span></span></strong><strong><span style=";font-family:宋体;line-height:150%;font-weight:bold;font-size:16px"><span style="font-family:宋体">：</span></span></strong><strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:16px"><span style="font-family:宋体"><%=Metro%></span></span></strong><strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:16px"><span style="font-family:宋体"></span></span></strong>
</p>
<p style="margin-right:7px;line-height:150%">
    <strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:16px"><span style="font-family:宋体">送签联系人：<%=SendName%></span></span></strong>
    <strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:16px"></span></strong>
</p>
<p style="margin-right:7px;margin-left:7px;text-align:center;line-height:150%">
    <strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:19px"><span style="font-family:宋体">递交签证申请您需携带以下材料：</span></span></strong>
</p>
<p>
    <%=VisaData%>
</p>
<p style="margin-right:7px;text-indent:0;line-height:150%">
    <span style=";font-family:&#39;Times New Roman&#39;;line-height:150%;font-size:16px">&nbsp;</span>
</p>
<p style="margin-right:7px;line-height:150%">
    <strong><span style=";font-family:&#39;Times New Roman&#39;;line-height:150%;font-weight:bold;font-size:16px"><span style="font-family:宋体">递交申请流程：</span></span></strong>
</p>
<p>
    <%=Process %>
</p>
<p>
    <br/>
</p>
<p style="margin-right:7px;line-height:150%">
    <strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:19px"><span style="font-family:宋体">温馨提示：</span></span></strong>
</p>
<p style="margin-right:7px;line-height:150%">
    <strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:19px">1<span style="font-family:宋体">、除</span></span></strong><strong><span style=";font-family:Calibri;line-height:150%;color:rgb(255,0,0);font-weight:bold;font-size:19px"><span style="font-family:宋体">护照、身份证、户口簿、单位证明、银行流水账单</span></span></strong><strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:19px"><span style="font-family:宋体">外，以上提及原件在递交资料时</span></span></strong><strong><span style=";font-family:Calibri;line-height:150%;color:rgb(255,0,0);font-weight:bold;font-size:19px"><span style="font-family:宋体">可选择性提交</span></span></strong><strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:19px"><span style="font-family:宋体">，所提交的原件由领馆收取用于签证审核用途，待签证官受理完后连同签证结果一起返还给您。</span></span></strong>
</p>
<p style="margin-right:7px;line-height:150%">
    <strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:19px">2<span style="font-family:宋体">、如有需要，领馆会对申请人进行电话调查</span></span><span style=";font-family:宋体;line-height:150%;font-weight:bold;font-size:19px"><span style="font-family:宋体">或邮件咨询</span></span><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:19px"><span style="font-family:宋体">，请留意接听电话</span></span><span style=";font-family:宋体;line-height:150%;font-weight:bold;font-size:19px"><span style="font-family:宋体">或查询邮箱</span></span><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:19px"><span style="font-family:宋体">。签证最终结果由签证官对申请人的资料审核完后做出判断。我司为协助办理机构，无法干涉领馆的工作流程和签证结果。因此，如遇拒签我司收取的签证受理费用不予退还。请见谅！</span></span></strong>
</p>
<p style="margin-right:7px;line-height:150%">
    <strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:19px">3<span style="font-family:宋体">、因须录入指纹和拍照，请注意仪容仪表，不要化浓妆或佩戴美瞳</span></span><span style=";font-family:宋体;line-height:150%;font-weight:bold;font-size:19px"><span style="font-family:宋体">、项链或耳环</span></span><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:19px"><span style="font-family:宋体">。</span></span></strong>
</p>
<p style="margin-right:7px;text-indent:14px;text-align:center;line-height:150%">
    <strong><span style=";font-family:Calibri;line-height:150%;font-weight:bold;font-size:29px"><span style="font-family:宋体">祝</span> <span style="font-family:宋体">签</span> <span style="font-family:宋体">证</span> <span style="font-family:宋体">成</span> <span style="font-family:宋体">功</span></span></strong><strong><span style=";font-family:宋体;line-height:150%;font-weight:bold;font-size:29px"><span style="font-family:宋体">！</span></span></strong>
</p>
<p>
    <br/>
</p></div>
</body>
</html>