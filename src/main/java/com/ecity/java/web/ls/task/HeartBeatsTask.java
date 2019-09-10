package com.ecity.java.web.ls.task;

import java.util.TimerTask;


import com.ecity.java.web.ls.system.fun.GFunction;
public class HeartBeatsTask extends TimerTask {
  @Override
  public void run() {
    GFunction.TimeTaskLog("HeartBeatsTask","心跳服务，验证主服务状态是否正常","1分钟");
    System.err.println("HeartBeatsTask");
  }
}
