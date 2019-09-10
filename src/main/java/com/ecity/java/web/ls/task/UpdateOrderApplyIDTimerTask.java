package com.ecity.java.web.ls.task;

import java.sql.SQLException;
import java.util.TimerTask;

import com.ecity.java.mvc.service.taobao.ota.TaoBaoOTAService;
import com.ecity.java.mvc.service.visa.ota.BookingOrderNameListService;
import com.ecity.java.sql.db.DBTable;
import com.ecity.java.web.ls.system.fun.GFunction;
import com.ecity.java.web.taobao.api.alitripTravelTradeQueryClass;
import com.java.sql.SQLCon;
import com.taobao.api.ApiException;

public class UpdateOrderApplyIDTimerTask extends TimerTask {

  @Override
  public void run() {

    GFunction.TimeTaskLog("UpdateOrderApplyIDTimerTask","同步订单ApplyID","24小时");
    // TODO Auto-generated method stub
    System.out.println("------UpdateOrderApplyIDTimerTask begin ------");
    DBTable table = new DBTable(SQLCon.GetConnect(), "select Ebo_SourceOrderNo,Ebo_id from Ebon_BookingOrder_NameList,Ebo_BookingOrder \r\n" + 
        "where isnull(Ebon_ApplyId,'')='' and Ebon_StatusOTA<>''\r\n" + 
        "and Ebon_id_Ebo=Ebo_id and ebo_statustype<>'已取消'   group by Ebo_SourceOrderNo,Ebo_id");
    try {
      table.Open();
      BookingOrderNameListService service=new BookingOrderNameListService();
      TaoBaoOTAService otaService=new TaoBaoOTAService();
      while (table.next()) {
        String Ebo_SourceOrderNo=table.getString("Ebo_SourceOrderNo");
        String Ebo_id=table.getString("Ebo_id");

        alitripTravelTradeQueryClass.OrderInfo(Ebo_SourceOrderNo, true);         
        service.UpdateApplyIDByOrderID(Ebo_SourceOrderNo);

        service.UpdateVisaApplicantInfo(Ebo_SourceOrderNo,Ebo_id);

//        alitripTravelTradeQueryClass.OrderInfo(Ebo_SourceOrderNo, true); 
//        service.UpdateApplyIDByOrderID(Ebo_SourceOrderNo);
         
      }
    } catch (SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      table.CloseAndFree();
    }

    System.out.println("------UpdateOrderApplyIDTimerTask end ------");
  }

}
