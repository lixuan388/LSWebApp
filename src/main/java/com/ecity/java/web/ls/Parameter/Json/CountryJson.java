package com.ecity.java.web.ls.Parameter.Json;

public class CountryJson extends BaseJsonClass {
  
  public CountryJson()
  {
    super("select act_id as ID,act_name as Name from act_country where act_status<>'D' order by act_name","Name","ID");
  }
 
}
