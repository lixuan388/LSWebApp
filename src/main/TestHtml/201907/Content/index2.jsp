<%@page import="com.ecity.java.web.ls.Parameter.Json.SupplierInfoJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.CountryJson"%>
<%@page import="com.ecity.java.web.ls.Parameter.Json.ProductTypeJson"%>
<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

    <jsp:include page="/head.jsp"/>
    
  <link href="<%=request.getContextPath() %>/Content/index.css" rel="stylesheet">
</head>	
<body>


<div style="overflow-x: auto;overflow: auto;height: 100%;">
<jsp:include page="/Content/Product/Form/ProductPackage.jsp"/>


</div> 
   
   
<script type="text/javascript">
var ProductTypeJson=<%=new ProductTypeJson().GetJsonDataListString()%>
var ProductTypeName=<%=new ProductTypeJson().GetJsonDataString()%>

var CountryJson = <%=new CountryJson().GetJsonDataListString()%>
var CountryName = <%=new CountryJson().GetJsonDataString()%>
var SupplierJson = <%=new SupplierInfoJson().GetJsonDataListString()%>
var SupplierName = <%=new SupplierInfoJson().GetJsonDataString()%>
</script>
     
</body>
 
</html>
