<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <!-- Modal -->
  <div class="modal fade " id="SelectProductPackageDetilModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document" style="width: 800px;">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="myModalLabel">选择产品</h4>
        </div>
        <div class="modal-body">      
          
          <div class="form-group">
            <div class="input-group">
              <input type="text" class="form-control" placeholder="请输入产品名称" id="SearchProductPackageName">
              <span class="input-group-addon btn" onclick="ProductPackageDetil_Search()">查询产品</span>
             </div>
          </div>
          <div class="form-group" style="height:400px;overflow-x: auto;" >
             <table class="table table-striped table-hover DataTable">
                <thead>
                  <td style="width:80px">内部ID</td>
                  <td>内部名称</td>
                  <td style="width:80px">供应商</td>
                  <td style="width:80px">国家</td>
                  <td style="width:50px">天数</td>
                  <td style="width:80px">成本价</td>
                  <td style="width:80px">销售价</td>
                  <td style="width:40px">&nbsp;</td>    
                </thead>
                <tbody>
                
                </tbody>
              </table>
          </div>          
          <input type="hidden" FieldName="epgd_id">
          <input type="hidden" FieldName="epgd_status">
          
        </div>    
        <div class="modal-footer">
          <button type="button" class="btn btn-default" onclick="$('#ProductPackageDiv #SelectProductPackageDetilModal').modal('hide');">取消</button>
        </div>
      </div>
    </div>
  </div>
  
  <script id="DataTableTemplate2" type="text/html">
    <tr>
        <td style="text-align:center;">${epi_id}</td>
        <td style="text-align:center;">${epi_Name}</td>
        <td style="text-align:center;">${CountryName[epi_id_act]}</td>
        <td style="text-align:center;">${SupplierName[epi_id_esi]}</td>
        <td style="text-align:center;">${epi_Day}</td>
        <td style="text-align:right;">${epi_CostMoney}</td>
        <td style="text-align:right;">${epi_SaleMoney}</td>    
        <td style="text-align:center;">
          <a style="width:100%  " 
          data-epi_id="${epi_id}" 
          data-epi_Name="${epi_Name}" 
          data-epi_id_act="${epi_id_act}" 
          data-epi_id_esi="${epi_id_esi}" 
          data-epi_Day="${epi_Day}" 
          data-epi_CostMoney="${epi_CostMoney}" 
          data-epi_SaleMoney="${epi_SaleMoney}" 
          class="btn btn-primary  btn-xs" href="javascript:void(0);" onclick="ProductPackageDetil_Select(this)"  role="button" >选择</a>
        </td>    
    </tr>
  </script>
    
  
<script type="text/javascript">


function ProductPackageDetil_Select(t)
{
  console.log($(t));
  var Data={};
  Data["epgd_id"]=$("#ProductPackageDiv #SelectProductPackageDetilModal [FieldName=epgd_id]").val();
  Data["epgd_status"]="I";
  Data["epgd_User_Ins"]="<%=request.getSession().getAttribute("UserName") %>";
  Data["epgd_Date_Ins"]=new Date().Format("yyyy-MM-dd HH:mm:ss");
  Data["epgd_id_epgm"]=$("#ProductPackageDiv #ProductPackageInsertModal [FieldName=epgm_id]").val();
  Data["epgd_id_epi"]=$(t).data("epi_id");
  Data["epgd_Name"]=$(t).data("epi_name");
  Data["epi_id_act"]=$(t).data("epi_id_act");
  Data["epi_id_esi"]=$(t).data("epi_id_esi");
  Data["epi_Day"]=$(t).data("epi_day");
  Data["epgd_Num"]=1;
  Data["epgd_CostMoney"]=$(t).data("epi_costmoney");
  Data["epgd_SaleMoney"]=$(t).data("epi_salemoney");
  
  //console.log(Data)
  $("#ProductPackageDiv #DetilTableTemplate").tmpl(Data).appendTo($("#ProductPackageDiv #ProductPackageInsertModal .DetilTable>tbody"));  
  $('#ProductPackageDiv #SelectProductPackageDetilModal').modal('hide');
  var cost=0;
  var sale=0;
  $("#ProductPackageDiv  #ProductPackageInsertModal .DetilTable>tbody>tr").each(function(){
    cost=cost+$(this).find("[FieldName=epgd_CostMoney]").val()*1;
    sale=sale+$(this).find("[FieldName=epgd_SaleMoney]").val()*1;
  })
  $("#ProductPackageDiv  #ProductPackageInsertModal [FieldName=epgm_CostMoney]").val(cost);
  $("#ProductPackageDiv  #ProductPackageInsertModal [FieldName=epgm_SaleMoney]").val(sale);
  
  
}

function ProductPackageDetil_Insert()
{
  var $loadingToast = $('#loadingToast');
  $loadingToast.fadeIn(100);
  
  $.ajax({
    url: '<%=request.getContextPath() %>/System/GetMaxID.json?d=' + new Date().getTime(),
    type: 'get',
    dataType: 'Json',
    success: function (data) {
      $loadingToast.fadeOut(100);
      if (data.MsgID != 1)
      { 
        alert(data.MsgText);
        return;
      } 
      else
      {

        $("#ProductPackageDiv #SelectProductPackageDetilModal")
        
        $("#ProductPackageDiv #SelectProductPackageDetilModal [FieldName=epgd_id]").val(data.MaxID*1);  
                
        $("#ProductPackageDiv #SelectProductPackageDetilModal").modal("show");        
      }
    }
  })    
}

function ProductPackageDetil_Search()
{
  var KeyName=$("#ProductPackageDiv #SearchProductPackageName").val();
  if ("KeyName"=="")
  {
    alert("请输入产品名称！")
    return ;
  }
  //alert(KeyID);
  $.ajax({
    url: '<%=request.getContextPath() %>/Content/Product/SearchProductPackageDetil.json?Name='+encodeURI(encodeURI(KeyName))+'&d=' + new Date().getTime(),
    type: 'get',
    dataType: 'Json',
    success: function (data) {
      //console.log(data);
      //$loadingToast.fadeOut(100);
      if (data.MsgID != 1)
      {
        alert(data.MsgText);
        return;
      } 
      else
      {
        //console.log(data.Data);
        $("#ProductPackageDiv #SelectProductPackageDetilModal .DataTable>tbody").html("");

        $("#ProductPackageDiv #DataTableTemplate2").tmpl(data.Data).appendTo('#ProductPackageDiv #SelectProductPackageDetilModal .DataTable>tbody');  
      }
    }
  })
}

</script>