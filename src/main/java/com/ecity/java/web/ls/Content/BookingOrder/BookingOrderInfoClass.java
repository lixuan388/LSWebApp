package com.ecity.java.web.ls.Content.BookingOrder;

import java.sql.SQLException;
import java.text.DecimalFormat;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.sql.db.DBTable;
import com.ecity.java.sql.table.MySQLTable;
import com.java.sql.SQLCon;

public class BookingOrderInfoClass {
  public String ID;
  public boolean HasSign = false;

  public BookingOrderInfoClass(String ID) {
    this.ID = ID;
  }

  @SuppressWarnings("finally")
  public JSONObject OpenTable() {

    JSONObject ReturnJson = new JSONObject();

    java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    try {
      DecimalFormat df = new DecimalFormat("0.00");

      String Sql = "select * from ebo_BookingOrder where ebo_status<>'D' and ebo_id=" + ID;
      MySQLTable OrderTable = new MySQLTable(Sql);
      try {
        OrderTable.Open();
        while (OrderTable.next()) {
          JSONObject DataJson = new JSONObject();
          DataJson.put("ebo_id", OrderTable.getString("ebo_id"));
          DataJson.put("ebo_SourceName", OrderTable.getString("ebo_SourceName"));
          DataJson.put("ebo_SourceOrderNo", OrderTable.getString("ebo_SourceOrderNo"));
          DataJson.put("ebo_StatusType", OrderTable.getString("ebo_StatusType"));
          DataJson.put("ebo_SourceGuest", OrderTable.getString("ebo_SourceGuest"));
          DataJson.put("ebo_PayDate", format.format(OrderTable.getDateTime("ebo_PayDate")));
          DataJson.put("ebo_PackageName", OrderTable.getString("ebo_PackageName"));
          DataJson.put("ebo_PackageVisa", OrderTable.getString("ebo_PackageVisa"));
          DataJson.put("ebo_PayMoney", df.format(OrderTable.getDouble("ebo_PayMoney")));
          DataJson.put("ebo_LinkMan", OrderTable.getString("ebo_LinkMan"));
          DataJson.put("ebo_Phone", OrderTable.getString("ebo_Phone"));
          DataJson.put("ebo_EMail", OrderTable.getString("ebo_EMail"));
          DataJson.put("ebo_WeiXin", OrderTable.getString("ebo_WeiXin"));
          DataJson.put("ebo_QQ", OrderTable.getString("ebo_QQ"));
          DataJson.put("ebo_AccountDate", format.format(OrderTable.getDateTime("ebo_AccountDate")));
          DataJson.put("ebo_Addr", OrderTable.getString("ebo_Addr"));
          DataJson.put("ebo_Remark", OrderTable.getString("ebo_Remark"));
          DataJson.put("ebo_AccountMoney", OrderTable.getString("ebo_AccountMoney"));
          DataJson.put("ebo_SaleName", OrderTable.getString("ebo_SaleName"));

          ReturnJson.put("OrderInfo", DataJson);
        }
      } finally {
        OrderTable.Close();
      }
      ReturnJson.put("MsgID", "1");
      ReturnJson.put("MsgText", "Success");

//      System.out.println("Success");

      JSONArray PackageArrayJson = new JSONArray();
      Sql = "select * from ebop_BookingOrder_Package where ebop_status<>'D' and ebop_id_ebo=" + ID
          + " order by ebop_id_ept,ebop_id";

//      System.out.println(Sql);

      MySQLTable PackageTable = new MySQLTable(Sql);

//      System.out.println("PackageTable.Open();");

      try {
        PackageTable.Open();
        while (PackageTable.next()) {
//          System.out.println("PackageTable.next()");
          JSONObject DataJson = new JSONObject();
          DataJson.put("ebop_id", PackageTable.getString("ebop_id"));
          DataJson.put("ebop_status", PackageTable.getString("ebop_status"));
          DataJson.put("ebop_id_ebo", PackageTable.getString("ebop_id_ebo"));
          DataJson.put("ebop_id_epi", PackageTable.getString("ebop_id_epi"));
          DataJson.put("ebop_StatusType", PackageTable.getString("ebop_StatusType"));
          DataJson.put("ebop_ProductCode", PackageTable.getString("ebop_ProductCode"));
          DataJson.put("ebop_id_ept", PackageTable.getString("ebop_id_ept"));
          DataJson.put("ebop_id_act", PackageTable.getString("ebop_id_act"));
          DataJson.put("ebop_ProductName", PackageTable.getString("ebop_ProductName"));
          DataJson.put("ebop_day", PackageTable.getString("ebop_day"));
          DataJson.put("ebop_Money", df.format(PackageTable.getDouble("ebop_Money")));
          DataJson.put("ebop_AddMoney", df.format(PackageTable.getDouble("ebop_AddMoney")));
          DataJson.put("ebop_SaleMoney", df.format(PackageTable.getDouble("ebop_SaleMoney")));
          DataJson.put("ebop_id_esi", PackageTable.getString("ebop_id_esi"));
          if (!PackageTable.IsNull("ebop_DateStart")) {
            DataJson.put("ebop_DateStart", format.format(PackageTable.getDateTime("ebop_DateStart")));
          }
          if (!PackageTable.IsNull("ebop_DateBack")) {
            DataJson.put("ebop_DateBack", format.format(PackageTable.getDateTime("ebop_DateBack")));
          }
          DataJson.put("ebop_id_ebon", PackageTable.getString("ebop_id_ebon"));

//          System.out.println(DataJson.toString());

          PackageArrayJson.put(DataJson);
        }
      } finally {
//        System.out.println("PackageTable.Close()1");
        PackageTable.Close();
      }

//      System.out.println("PackageTable.Close()2");

      JSONArray NameListArrayJson = new JSONArray();
      Sql = "select * from ebon_BookingOrder_NameList where ebon_status<>'D' and ebon_id_ebo=" + ID
          + " order by ebon_id";
      MySQLTable NameListTable = new MySQLTable(Sql);
      try {
        NameListTable.Open();
        while (NameListTable.next()) {
//          System.out.println("PackageTable.next()");
          JSONObject DataJson = new JSONObject();
          DataJson.put("ebon_id", NameListTable.getString("ebon_id"));
          DataJson.put("ebon_Name", NameListTable.getString("ebon_Name"));
          DataJson.put("ebon_PassPort", NameListTable.getString("ebon_PassPort"));
          DataJson.put("ebon_id_avg", NameListTable.getString("ebon_id_avg"));
          DataJson.put("ebon_id_ava", NameListTable.getString("ebon_id_ava"));
          if (!NameListTable.getString("ebon_id_ava").equals("-1")) {
            this.HasSign = true;
          }
          NameListArrayJson.put(DataJson);
        }
      } finally {
        NameListTable.Close();
      }

//      System.out.println("PackageArrayJson.toString()");
//      System.out.println(PackageArrayJson.toString());

      ReturnJson.put("PackageInfo", PackageArrayJson);
      ReturnJson.put("NameList", NameListArrayJson);

    } finally {

//      System.out.println("return");
      return ReturnJson;
    }
  }
  @SuppressWarnings("finally")
  public JSONObject Cost() {

    JSONObject ReturnJson = new JSONObject();


    try {
      String Sql = "select ebo_PayMoney,ebo_AccountMoney from ebo_BookingOrder where  ebo_id=" + ID;
      
      DBTable table1=new DBTable(SQLCon.GetConnect(), Sql);
      try {
        table1.Open();
        if (table1.next()) {
          ReturnJson.put("PayMoney",table1.getString("ebo_PayMoney"));
          ReturnJson.put("AccountMoney", table1.getString("ebo_AccountMoney"));
        }
      }catch (SQLException e) {
        // TODO: handle exception
        e.printStackTrace();
      }finally {
        table1.CloseAndFree();
      }
      
      Sql="select sum(agcld_costs) as agcld_costs from Ebo_BookingOrder,Ebon_BookingOrder_NameList ,\r\n" + 
          "agcld_Group_Cast_Link_Detail,agcm_Group_Cast_M\r\n" + 
          "where Ebo_id=Ebon_id_Ebo and ebon_id_ava=agcld_id_ava\r\n" + 
          "and agcm_id=agcld_id_agcm and agcm_status<>'D'\r\n" + 
          "and ebo_id="+ ID;
      DBTable table2=new DBTable(SQLCon.GetConnect(), Sql);
      try {
        table2.Open();
        if (table2.next()) {
          ReturnJson.put("VisaCost",table2.getString("agcld_costs"));
        }
      }catch (SQLException e) {
        // TODO: handle exception
        e.printStackTrace();
      }finally {
        table2.CloseAndFree();
      }

      
      Sql="select sum(isnull(Eboh_Money,0)) as Eboh_Money from [dbo].[Eboh_BookingOrderHistory] where eboh_type='赔付' and Eboh_id_ebo="+ ID;
      DBTable table3=new DBTable(SQLCon.GetConnect(), Sql);
      try {
        table3.Open();
        if (table3.next()) {
          ReturnJson.put("Compensation",table3.getString("Eboh_Money"));
        }
        else {

          ReturnJson.put("Compensation","0");
        }
      }catch (SQLException e) {
        // TODO: handle exception
        e.printStackTrace();
      }finally {
        table3.CloseAndFree();
      }
      
      
    } finally {

      return ReturnJson;
    }
  }

}
