package com.ecity.java.web.ls.task;

import java.util.TimerTask;

import com.ecity.java.mvc.service.visa.ota.OrderStatusSyncService;
import com.ecity.java.web.ls.system.fun.GFunction;

public class OrderStatusSyncTask extends TimerTask {

  @Override
  public void run() {

    GFunction.TimeTaskLog("UpdateOrderApplyIDTimerTask","签证状态推送","1小时");
    OrderStatusSyncService svc=new OrderStatusSyncService();
    for (int i=0;i<5;i++) {
      svc.Synchronization();
    }
  }

}
