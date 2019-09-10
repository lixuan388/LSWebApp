package com.ecity.java.web.ls.Parameter.Json;


public class SupplierInfoJson  extends BaseJsonClass {
  
  public SupplierInfoJson()
  {
    super("select esi_id as ID,esi_Name as Name from esi_Supplier_Info where esi_status<>'D'","Name","ID");
  }  
}
