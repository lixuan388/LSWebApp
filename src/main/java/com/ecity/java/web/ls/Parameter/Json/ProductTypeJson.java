package com.ecity.java.web.ls.Parameter.Json;


public class ProductTypeJson  extends BaseJsonClass {
  
  public ProductTypeJson()
  {
    super("select ept_id as ID,ept_Name as Name from ept_Product_Type where ept_status<>'D' order by ept_index","Name","ID");
  }  
}
