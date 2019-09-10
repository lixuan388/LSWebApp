package com.java.web.weixin.base;

import com.ecity.java.web.WebFunction;

public class WeiXinVariable {
	private static String AppID="XXX";
	private static String AppSecret="XXX";
	private static String AccessToken="";
	private static long AccessTokenTimeOut=0;
	private static String jsapi_ticket="";
	private static long jsapi_ticket_TimeOut=0;	
	private static String APIKey="XXX";
	private static String SystemServerUrl="http://XXX";
	
	public static String getAppID() {
		return AppID;
	}
	
	public static void setAppID(String appID) {
		AppID = appID;
	}
	
	public static String getAppSecret() {
		return AppSecret;
	}
	
	public static void setAppSecret(String appSecret) {
		AppSecret = appSecret;
	}
	
	public static String getAccessToken() {
		long d=System.currentTimeMillis();
		String url=SystemServerUrl+"/WeiXin/System/GetJsapiTicket?d="+d;
		String result=WebFunction.sendHttpGet(url);
		return result;
	}
	
	public static void setAccessToken(String accessToken) {
		AccessToken = accessToken;
	}
	
	public static long getAccessTokenTimeOut() {
		return AccessTokenTimeOut;
	}
	
	public static void setAccessTokenTimeOut(long accessTokenTimeOut) {
		AccessTokenTimeOut = accessTokenTimeOut;
	}
	public static String getJsapi_ticket() {		
		long d=System.currentTimeMillis();
		String url=SystemServerUrl+"/WeiXin/System/GetJsapiTicket?d="+d;
		String result=WebFunction.sendHttpGet(url);
		return result;
	}
	
	public static void setJsapi_ticket(String jsapi_ticket) {
		WeiXinVariable.jsapi_ticket = jsapi_ticket;
	}
	
	public static long getJsapi_ticket_TimeOut() {
		return jsapi_ticket_TimeOut;
	}
	
	public static void setJsapi_ticket_TimeOut(long jsapi_ticket_TimeOut) {
		WeiXinVariable.jsapi_ticket_TimeOut = jsapi_ticket_TimeOut;
	}
	public static String getAPIKey() {
		return APIKey;
	}
	
	public static void setAPIKey(String aPIKey) {
		APIKey = aPIKey;
	}
	
	public static String getSystemServerUrl() {
		return SystemServerUrl;
	}
	
	public static void setSystemServerUrl(String systemServerUrl) {
		SystemServerUrl = systemServerUrl;
	}
	
}
