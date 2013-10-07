/*
 * Copyright (C) 2010 The MobileSecurePay Project
 * All right reserved.
 * author: shiqun.shi@alipay.com
 */

package com.alipay.config;

//
// 请参考 Android平台安全支付服务(msp)应用开发接口(4.2 RSA算法签名)部分，并使用压缩包中的openssl RSA密钥生成工具，生成一套RSA公私钥。
// 这里签名时，只需要使用生成的RSA私钥。
// Note: 为安全起见，使用RSA私钥进行签名的操作过程，应该尽量放到商家服务器端去进行。
public final class Keys {

    // 合作商户ID，用签约支付宝账号登录www.alipay.com后，在商家服务页面中获取。
	public static  String DEFAULT_PARTNER = "2088901007825435";

    // 商户收款的支付宝账号
	public static  String DEFAULT_SELLER = "2088901007825435";

	public static String MD5_KEY = "";
    // 商户（RSA）私钥
	public static  String PRIVATE  = 
		"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMCsovVkgspYJeFDoutLarl/uN7zEQ88G" +
	"APOYrWavqzarD2V02x4gYEdLyyVtIptaHje7OocIBfkIMzXbIPmTrihUEDSL+oBcAFUXg03qdOpG8/W7n9O" +
	"y6TswRd6/c9GbiZd9uwBSoT4mlAfvc1sPFjRG7hvAR9/W87tpLBShAufAgMBAAECgYEAvZZh90MCq2ZXR7" +
	"RNEGgySPtThxX3+FyyaLRhTr9I1j+J8kOGOZrOG6UC8UUR1JBZl24MA0TPk5Knb8id/5/UXoFFMluXRSy+j" +
	"fbrS435djBpalrdT4/v4LVdbjlLOmcNcGVgqdhm/ymzim2uZM26VulaAeSwLQ/JDGvd3JmxLXECQQD+dB2W+y" +
	"CgTLFU9xr3Px2hf9qn1Ds4lbgeFCh0cc+0dG219+UflA6QLFjkKDE727E0S1onisSnz5eTQr7FhmF3AkEAwdhn" +
	"TVmBEdKTdVwJEaUJ30snTzg0Vm2gaF+YiGeo+NhnsGdrbKLhmv1xBGSiAx4NDctnsltNPNcrRvwtE1lxGQJBAN" +
	"0rCF0nQqCSiMCVWDb4AUVS4DdoXWE9oZ9jXhZ4plTvrjywj9L22gGuykTmOoUQ2+HcbSxZjb1ezx0Mssz1lNk" +
	"CQAzXv5BaW7jIkMh3vooSuyK2IfaXrLAFN1ly6/Itm/5QqB4B3BYofHX+UJyP5kP6m7bMQSSJ9AYR42YikwHz" +
	"LRECQQChv8yUG4qnEkYRNMDx/NpJEqi2Axsec2hofErio4on5z3FtcFW9xVJcYvNv1W6k62d1mM/qikDv7cbDUrU5tqm";

    // 支付宝（RSA）公钥
	public static  String PUBLIC = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2" +
			"W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8" +
			"OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB";

	public static String notify_url = "http://notify.java.jpxx.org/index.jsp";
	public static String service = "mobile.securitypay.pay";
	public static String return_url = "http://m.alipay.com";
}
