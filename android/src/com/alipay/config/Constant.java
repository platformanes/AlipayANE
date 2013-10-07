package com.alipay.config;
//package com.alipay.android.msp.demo;
//
//import java.util.HashMap;
//import java.util.Map;
//
//import android.content.Context;
//import android.content.Intent;
//
//public class Constant {
//	public static final int RQF_PAY = 1;
//
//	public static final int START_EXTERNAL = 0;
//
//	public static int sStartActivity = START_EXTERNAL;
//	public static boolean sIsPopupResult = true;
//	public static String sResult = null;
//
//	public static final Map<String, Integer> sLaunchActivities;
//
//	private static final String DEFAULT_PARTNER = "2088901007825435";
//	private static final String DEFAULT_SELLER = "2088901007825435";
//
//	static {
//		sLaunchActivities = new HashMap<String, Integer>();
//		sLaunchActivities.put("外部商户订单", START_EXTERNAL);
//	}
//
//	public static String getPartner(Context context) {
//		return DEFAULT_PARTNER;
//	}
//
//	public static String getSeller(Context context) {
//		return DEFAULT_SELLER;
//	}
//
//	public static Intent getIntent(Context context) {
//		Intent i;
//		switch (sStartActivity) {
//		case START_EXTERNAL:
//		default:
//			i = new Intent(context, ExternalPartner.class);
//			break;
//		}
//
//		return i;
//	}
//
//}
