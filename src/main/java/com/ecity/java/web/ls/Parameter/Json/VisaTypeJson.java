package com.ecity.java.web.ls.Parameter.Json;

public class VisaTypeJson extends BaseJsonClass {
  
  public VisaTypeJson()
  {
  	super("select avt_id as ID,avt_name as Name from avt_visa_type where avt_status<>'D' order by avt_name","Name","ID");  
  }
}
