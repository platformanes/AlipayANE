package com.alipay.ane;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.alipay.func.AlipayExit;
import com.alipay.func.AlipayInit;
import com.alipay.func.AlipayPay;
/**
 * 映射
 * @author Rect 2013-10-5
 */
public class AliPayContext extends FREContext {

	/**
	 * initKey 
	 */
	public static final String ALIPAY_PAY_FUNCTION_INIT = "AlipayInit";
	/**
	 * 支付
	 */
	public static final String ALIPAY_PAY_FUNCTION_PAY = "AlipayPay";
	/**
	 * exit
	 */
	public static final String ALIPAY_PAY_FUNCTION_EXIT = "AlipayExit";
	
	@Override
	public void dispose() {
		// TODO Auto-generated method stub

	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		// TODO Auto-generated method stub
		Map<String, FREFunction> map = new HashMap<String, FREFunction>();
	       //映射
		   map.put(ALIPAY_PAY_FUNCTION_INIT, new AlipayInit()); 
	       map.put(ALIPAY_PAY_FUNCTION_PAY, new AlipayPay());    
	       map.put(ALIPAY_PAY_FUNCTION_EXIT, new AlipayExit());
	       return map;
	}

}
