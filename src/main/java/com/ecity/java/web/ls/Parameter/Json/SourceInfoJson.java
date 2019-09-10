package com.ecity.java.web.ls.Parameter.Json;

public class SourceInfoJson extends BaseJsonClass {
  
  public SourceInfoJson()
  {
  	super("select asi_id as ID,asi_name as Name  from asi_source_info where asi_status<>'D' order by asi_name","Name","ID");  
  }
 
}
