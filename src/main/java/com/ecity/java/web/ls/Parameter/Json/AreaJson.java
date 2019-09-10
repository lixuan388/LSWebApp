package com.ecity.java.web.ls.Parameter.Json;

public class AreaJson extends BaseJsonClass {
  
  public AreaJson()
  {
    super("select aar_id as ID,aar_name as Name from aar_area where aar_status<>'D' order by aar_name","Name","ID");
  }
 
}
