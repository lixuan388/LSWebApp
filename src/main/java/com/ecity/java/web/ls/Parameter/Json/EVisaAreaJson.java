package com.ecity.java.web.ls.Parameter.Json;

public class EVisaAreaJson extends BaseJsonClass {
  
  public EVisaAreaJson()
  {
  	super("select eva_id as ID,eva_name as Name from Eva_Visa_Area where Eva_status<>'D' order by Eva_name","Name","ID");  
  }
}
