package com.ecity.java.web.ls.Parameter.Json;

import java.sql.SQLException;

import com.ecity.java.json.JSONArray;
import com.ecity.java.json.JSONObject;
import com.ecity.java.sql.table.MySQLTable;

public class BaseJsonClass {

  public JSONObject JsonData=new JSONObject();
  
  public BaseJsonClass(String SqlStr,String FieldName ,String FieldValue)
  {
    MySQLTable table=new MySQLTable(SqlStr);
    try
    {      
      table.Open();
      JSONArray JsonArray=new JSONArray();
      JSONObject data=new JSONObject();
      while (table.next())
      {
        JSONObject data2=new JSONObject();
        data2.put("ID", table.getString(FieldValue));
        data2.put("Name", table.getString(FieldName));
        JsonArray.put(data2);                
        data.put(table.getString(FieldValue), table.getString(FieldName));
      }
      JsonData.put("Data", data);
      JsonData.put("DataList", JsonArray);
    }catch (SQLException e) {
      // TODO Auto-generated catch block

      e.printStackTrace();
      return;
    }
    finally
    {
      table.Close();
    }
  }
  
  
 
  
  public String GetJsonString()
  {
    return JsonData.toString();
  }
  public String GetJsonDataString()
  {
    return JsonData.getJSONObject("Data").toString();
  }
  public String GetJsonDataListString()
  {
    return JsonData.getJSONArray("DataList").toString();
  }
  
}
