package com.ecity.java.web.ls.Parameter.Json;

public class SourceSupplierInfoJson extends BaseJsonClass {
  
  public SourceSupplierInfoJson()
  {
  	super("select asi_id as ID,asi_name as Name  from asi_source_info_supplier where asi_status<>'D' and asi_IsSupplier=1 order by asi_name","Name","ID");  
  }
 
}
