<%@ page isELIgnored="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


  <!-- Modal -->
  <div class="modal fade" id="SupplierInfoEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document" style="width: 800px;">
      <div class="modal-content" >
        <div class="modal-header">
          <h4 class="modal-title" id="myModalLabel">新增供应商</h4>
        </div>
        <div class="modal-body">
					<div class="form-group">
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">ID</span>
							<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="esi_id" readonly>
						</div>
						<div class="input-group">
							<span class="input-group-addon" id="basic-addon1">名称</span>
							<input type="text" class="form-control" placeholder="" aria-describedby="basic-addon1"FieldName="esi_Name">
						</div>
						<input type="hidden" FieldName="esi_status" >
						<input type="hidden" FieldName="esi_User_Ins" >
						<input type="hidden" FieldName="esi_Date_Ins" >
						<input type="hidden" FieldName="esi_User_Lst" >
						<input type="hidden" FieldName="esi_Date_Lst" >
          </div>          
        </div>          
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
          <button type="button" class="btn btn-primary" onclick="SupplierInfoEdit_Submit();" data-dismiss="modal">保存</button>
        </div>
      </div>
    </div>
  </div>  
  
<script type="text/javascript">



function SupplierInfoEdit_Submit()
{ 
  var $loadingToast = $('#loadingToast');
  $loadingToast.fadeIn(100);
  
  var Data={}
  $("#SupplierInfoDiv #SupplierInfoEditModal  [FieldName]").each(function(){
    var FieldName=$(this).attr("FieldName");
    var FieldValue=$(this).val();
    Data[FieldName]=FieldValue;
  })
  
  var DataRows=[];  
  DataRows[0]=Data; 
  var json={"DataRows":DataRows};
  

  //console.log(json);

  $.post("<%=request.getContextPath()%>/Content/Base/SupplierInfoPost.json",JSON.stringify(json),function(data){
    //console.log(data);
    $loadingToast.fadeOut(100);
    if (data.MsgID!=1)
    {
      alert(data.MsgText);
    }
    else
    {
      alert("供应商信息保存成功！");
      $("#SupplierInfoDiv #SupplierInfoEditModal").modal("hide");
      SupplierInfo_Query();
    }
  },"json");
}

</script>
  

</div>    