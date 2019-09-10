package com.ecity.java.web.ls.task;

import java.io.File;
import java.io.IOException;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.bson.Document;

import com.ecity.java.web.taobao.service.TaobaoService;
import com.ecity.java.web.zjun.service.ZjunService;
import com.ecity.java.web.SF.api.SFApi;
import com.ecity.java.web.system.Config;
import com.ecity.java.web.taobao.Variable;
import com.java.version;
import com.java.sql.MongoCon;
import com.java.sql.SQLCon;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.Filters;

public class ServerStartInitializedTask implements ServletContextListener {

  private ScheduledExecutorService timer = Executors.newScheduledThreadPool(1);  

  public void contextDestroyed(ServletContextEvent event) {
    timer.shutdownNow();
    event.getServletContext().log("定时器ServerRunServlet销毁");
    System.out.println("LS.ServerStartTask.contextDestroyed");
  }

  public void contextInitialized(ServletContextEvent event) {
    System.out.println("LS.ServerStartTask.contextInitialized");
    String ContextPath=event.getServletContext().getContextPath().substring(1);
    
    System.out.println("ContextPath:"+ContextPath);
    System.out.println("-----ServerStartInitializedTask.contextInitialized-----");
    
    
    String tomcatPath = "";
    try {
      tomcatPath=new File(this.getClass().getResource("/").getPath()).getParentFile().getParentFile().getParentFile().getParentFile().getCanonicalPath();
    } catch (IOException e1) {
      // TODO Auto-generated catch block
      e1.printStackTrace();
    }  
    tomcatPath =tomcatPath.equals("")?System.getProperty("catalina.home"):tomcatPath;    
    Config.ConfigPath="\\conf\\"+ContextPath+".webConfig.properties";
    String ConfigPath = tomcatPath + Config.ConfigPath;
    ConfigPath=ConfigPath.replace("%20"," ");
    System.out.println(ConfigPath);
    try {
      Config c = new Config(ConfigPath);
      c.load();

      version.verType = c.getProperty("ls.version.verType")==""?version.ver_debug:c.getProperty("ls.version.verType");
      System.out.println("version.verType:"+version.verType);



//			System.out.println("IsDebugServer:"+c.getProperty("IsDebugServer"));
//			System.out.println("IsDebugServer:"+IsDebugServer);
      TaobaoService.appkey = c.getProperty("ls.taobao.appkey");
      TaobaoService.appsecret = c.getProperty("ls.taobao.appsecret");

      Variable.appkey = c.getProperty("ls.taobao.appkey");
      Variable.appsecret = c.getProperty("ls.taobao.appsecret");



      SQLCon.Url = c.getProperty("ls.SQLConnect.Url");
      SQLCon.DriverClassName = c.getProperty("ls.SQLConnect.DriverClassName");
      SQLCon.Username = c.getProperty("ls.SQLConnect.Username");
      SQLCon.Password = c.getProperty("ls.SQLConnect.Password");

      
      
      
      MongoCon.host = c.getProperty("ls.MongoConnect.host");
      MongoCon.port = c.getProperty("ls.MongoConnect.port", "0");
      MongoCon.Database = c.getProperty("ls.MongoConnect.Database", "Database");

      ZjunService.UserID = c.getProperty("ls.Zjun.UserID");
      ZjunService.UserName = c.getProperty("ls.Zjun.UserName");
      ZjunService.PassWord = c.getProperty("ls.Zjun.PassWord");
      ZjunService.SmsSign = c.getProperty("ls.Zjun.SmsSign");

      // 顺风接口
      SFApi.ClientCode = c.getProperty("ls.SF.ClientCode");// 此处替换为您在丰桥平台获取的顾客编码
      SFApi.CheckWord = c.getProperty("ls.SF.CheckWord");// 此处替换为您在丰桥平台获取的校验码
      SFApi.CustID = c.getProperty("ls.SF.CustID");
      SFApi.J_Province = c.getProperty("ls.SF.J_Province");
      SFApi.J_City = c.getProperty("ls.SF.J_City");
      SFApi.J_County = c.getProperty("ls.SF.J_County");
      SFApi.J_Company = c.getProperty("ls.SF.J_Company");
      SFApi.J_Contact = c.getProperty("ls.SF.J_Contact");
      SFApi.J_Tel = c.getProperty("ls.SF.J_Tel");
      SFApi.J_Address = c.getProperty("ls.SF.J_Address");
      SFApi.ReqURL = c.getProperty("ls.SF.ReqURL");
      SFApi.WayBillPrintURL = c.getProperty("ls.SF.WayBillPrintURL");

    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
      System.err.println("-------------------");
      System.err.println("配置文件读取失败！");
      System.err.println(ConfigPath);

    }

    try {
      MongoCollection<Document> collection = MongoCon.GetConnect().getCollection("api");
      FindIterable<Document> findIterable = collection.find(Filters.eq("Type", "Sessionkey"));
      MongoCursor<Document> mongoCursor = findIterable.iterator();
      Document document = mongoCursor.next();
      Variable.Sessionkey = document.getString("Value");
      TaobaoService.Sessionkey = Variable.Sessionkey;
    } catch (Exception e) {

      System.out.println("TaobaoService.Sessionkey读取失败");
    }

    
    timer.scheduleWithFixedDelay(new HeartBeatsTask(), 1, 1, TimeUnit.MINUTES);    
    if (version.verType.equals(version.ver_debug)) {
      System.out.println("测试服务器，不启动定时作业");
    } else {
      timer.scheduleWithFixedDelay(new GetAlitripTravelTradeInfoTask(), 1, 5, TimeUnit.MINUTES);
      timer.scheduleWithFixedDelay(new RefreshWaitBuyerPayTask(), 1, 5, TimeUnit.MINUTES);
      timer.scheduleWithFixedDelay(new CreateViewOrderTask(), 1, 5, TimeUnit.MINUTES);
      timer.scheduleWithFixedDelay(new WaitSellerSendGoodsTask(),  60, 60*24, TimeUnit.MINUTES);
      timer.scheduleWithFixedDelay(new UpdateOrderApplyIDTimerTask(), 60,60 * 24, TimeUnit.MINUTES);      
      timer.scheduleWithFixedDelay(new OrderStatusSyncTask(), 60, 60, TimeUnit.MINUTES);
      System.out.println("定时器ServerRunServlet已开启");
    }
  }
}
