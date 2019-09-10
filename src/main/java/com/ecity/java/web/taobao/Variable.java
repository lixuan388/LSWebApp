package com.ecity.java.web.taobao;

import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;

public class Variable {
  public static String appkey = "XXX";
  public static String appsecret = "XXX";
  public static String Sessionkey = "6101330430a53e87b4d34b38097d173a2a6d3b12619a1af4059312230";
  // public static String url="https://118.178.187.56/router/rest";
  public static String url = "https://eco.taobao.com/router/rest";

  static TaobaoClient client = null;

  public static TaobaoClient Client() {
    if (client == null) {
      client = new DefaultTaobaoClient(url, appkey, appsecret);
    }
    return client;
  }
}
