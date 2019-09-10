package com.ecity.java.web.ls.Parameter.Json;

public class EVisaTypeJson extends BaseJsonClass {
  
  public EVisaTypeJson()
  {
  	super("select evt_id as ID,evt_name as Name from Evt_Visa_Type where Evt_status<>'D' order by Evt_name","Name","ID");  
  }
}
