package com.ecity.java.web.ls.Content.BookingOrder.test;

import com.ecity.java.json.JSONObject;
import com.ecity.java.web.ls.Content.BookingOrder.alitripOrderInfoClassXXX;
import com.ecity.java.web.ls.Content.BookingOrder.alitripOrderInfoPostClass;

public class alitripOrderInfoClassTest {
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String OrderID ="220282147573421792";


		alitripOrderInfoClassXXX Order=new alitripOrderInfoClassXXX(OrderID);
		JSONObject OrderJson=Order.OpenTable();
		
		System.out.println(OrderJson.toString());
		
//		alitripOrderInfoPostClass Post=new alitripOrderInfoPostClass(OrderID);
	}
	
}
