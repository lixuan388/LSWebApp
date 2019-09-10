package com.ecity.java.web.ls.Parameter.Json;

public class VisaSpeedJson extends BaseJsonClass {
  
  public VisaSpeedJson()
  {
    super("select avs_id as ID,avs_name as Name from avs_visa_speed where avs_status<>'D' order by avs_name","Name","ID");

  }
 
}
