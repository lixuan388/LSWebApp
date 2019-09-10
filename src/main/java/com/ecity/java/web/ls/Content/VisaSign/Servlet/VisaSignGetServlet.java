package com.ecity.java.web.ls.Content.VisaSign.Servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.ecity.java.sql.table.MySQLTable;

@WebServlet("/Content/VisaSign/VisaSignGet.json")

public class VisaSignGetServlet extends HttpServlet {

  /**
   * 
   */
  private static final long serialVersionUID = -847620041160635539L;

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    // TODO Auto-generated method stub
    resp.setContentType("application/json;charset=utf-8");
    resp.setCharacterEncoding("UTF-8");
    resp.setHeader("Cache-Control", "no-cache");
    JSONObject ReturnJson = new JSONObject();
    try {

      ReturnJson.put("MsgID", "1");
      ReturnJson.put("MsgText", "Success");

      Map<String, String[]> params = req.getParameterMap();
      String ID = params.get("ID") == null ? "0" : (String) (params.get("ID")[0]);

      String Sql = "select avg_invoiceno,avg_source,avg_SourceName,avg_id_asi,\r\n"
          + "avg_groupcode,avg_id_act,avg_id_avs,avg_id_type,avg_price,avg_num,\r\n"
          + "avg_amount,avg_actamt,avg_remain,avg_SupplierID,\r\n"
          + "avg_remark,avg_Source_link,avg_Source_tel,avg_Source_addr,avg_state\r\n"
          + ",avg_id,avg_user_enter,avg_date_enter\r\n" + "from avg_visa_group where avg_id=" + ID;

      MySQLTable table = new MySQLTable(Sql);
      try {
        table.Open();
        while (table.next()) {
          JSONObject DataJson = new JSONObject();
          DataJson.put("avg_id", table.getString("avg_id"));
          DataJson.put("avg_invoiceno", table.getString("avg_invoiceno"));
          DataJson.put("avg_source", table.getString("avg_source"));
          DataJson.put("avg_SourceName", table.getString("avg_SourceName"));
          DataJson.put("avg_id_asi", table.getString("avg_id_asi"));
          DataJson.put("avg_groupcode", table.getString("avg_groupcode"));
          DataJson.put("avg_id_act", table.getString("avg_id_act"));
          DataJson.put("avg_id_avs", table.getString("avg_id_avs"));
          DataJson.put("avg_id_type", table.getString("avg_id_type"));
          DataJson.put("avg_price", table.getString("avg_price"));
          DataJson.put("avg_num", table.getString("avg_num"));
          DataJson.put("avg_amount", table.getString("avg_amount"));
          DataJson.put("avg_actamt", table.getString("avg_actamt"));
          DataJson.put("avg_remain", table.getString("avg_remain"));
          DataJson.put("avg_SupplierID", table.getString("avg_SupplierID"));
          DataJson.put("avg_remark", table.getString("avg_remark"));
          DataJson.put("avg_Source_link", table.getString("avg_Source_link"));
          DataJson.put("avg_Source_tel", table.getString("avg_Source_tel"));
          DataJson.put("avg_Source_addr", table.getString("avg_Source_addr"));
          DataJson.put("avg_state", table.getString("avg_state"));
          DataJson.put("avg_user_enter", table.getString("avg_user_enter"));
          DataJson.put("avg_date_enter", table.getString("avg_date_enter"));

          ReturnJson.put("VisaSignInfo", DataJson);
        }
      } catch (SQLException e) {
        // TODO Auto-generated catch block

        ReturnJson.put("MsgID", "-1");
        ReturnJson.put("MsgText", e.getMessage());
        e.printStackTrace();
        return;
      } finally {
        table.Close();
      }

      JSONArray VisaSignDetilJson = new JSONArray();
      Sql = "select ava_id, ava_StatusType,ava_name_c,ava_name_e,ava_idcard,ava_PassPortNo,ava_sex,\r\n"
          + "CONVERT(nvarchar(10),ava_date_birth,120) as ava_date_birth,\r\n"
          + "CONVERT(nvarchar(10),ava_Date_Sign,120) as ava_Date_Sign,\r\n"
          + "CONVERT(nvarchar(10),ava_Date_End,120) as ava_Date_End,\r\n" + "ava_place_issue,ava_country_code,\r\n"
          + "isnull(ava_mobile,'') as ava_mobile,ava_age,ava_Remark from ava_visa_application where ava_id_avg=" + ID;

      MySQLTable VisaSignDetil = new MySQLTable(Sql);
      try {
        VisaSignDetil.Open();
        while (VisaSignDetil.next()) {
          JSONObject DataJson = new JSONObject();
          DataJson.put("ava_id", VisaSignDetil.getString("ava_id"));
          DataJson.put("ava_StatusType", VisaSignDetil.getString("ava_StatusType"));
          DataJson.put("ava_name_c", VisaSignDetil.getString("ava_name_c"));
          DataJson.put("ava_name_e", VisaSignDetil.getString("ava_name_e"));
          DataJson.put("ava_idcard", VisaSignDetil.getString("ava_idcard"));
          DataJson.put("ava_PassPortNo", VisaSignDetil.getString("ava_PassPortNo"));
          DataJson.put("ava_sex", VisaSignDetil.getString("ava_sex"));
          DataJson.put("ava_date_birth", VisaSignDetil.getString("ava_date_birth"));
          DataJson.put("ava_Date_Sign", VisaSignDetil.getString("ava_Date_Sign"));
          DataJson.put("ava_Date_End", VisaSignDetil.getString("ava_Date_End"));
          DataJson.put("ava_place_issue", VisaSignDetil.getString("ava_place_issue"));
          DataJson.put("ava_country_code", VisaSignDetil.getString("ava_country_code"));
          DataJson.put("ava_mobile", VisaSignDetil.getString("ava_mobile"));
          DataJson.put("ava_age", VisaSignDetil.getString("ava_age"));
          DataJson.put("ava_Remark", VisaSignDetil.getString("ava_Remark"));

          VisaSignDetilJson.put(DataJson);
        }

        ReturnJson.put("VisaSignDetil", VisaSignDetilJson);
      } catch (SQLException e) {
        // TODO Auto-generated catch block

        ReturnJson.put("MsgID", "-1");
        ReturnJson.put("MsgText", e.getMessage());
        e.printStackTrace();
        return;
      } finally {
        VisaSignDetil.Close();
      }
    } finally {
      resp.getWriter().print(ReturnJson.toString());
      resp.getWriter().flush();
    }
  }
}
