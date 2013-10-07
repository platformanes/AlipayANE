package com.alipay.func;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.alipay.config.Keys;
import com.alipay.config.Result;
import com.alipay.config.Rsa;
/**
 * @author Rect 2013-10-5
 */
public class AlipayPay implements FREFunction {
	private String TAG = "AlipayPay";
	public static FREContext _context;
	
	public static final int RQF_PAY = 1;
	private static AlipayThread zip;
	@Override
	public FREObject call(final FREContext context, FREObject[] arg1) {
		// TODO Auto-generated method stub
		_context = context;
		Product product = null;
		sendMsgBacktoAS("begining");
		try
		{
			product = new Product();
			product.subject = arg1[0].getAsString();
			product.price = ""+arg1[1].getAsInt();
			product.body = arg1[2].getAsString();
			
			//args test
			sendMsgBacktoAS(product.subject);
			sendMsgBacktoAS(product.body);
			sendMsgBacktoAS(product.price);
		}
		catch(Exception e)
		{
			sendMsgBacktoAS("参数错误 tags:"+e.getMessage());
		}
		
		try {
			sendMsgBacktoAS("onItemClick");
			String info = getNewOrderInfo(product);
			String sign = Rsa.sign(info, Keys.PRIVATE);
			sign = URLEncoder.encode(sign);
			info += "&sign=\"" + sign + "\"&" + getSignType();
			sendMsgBacktoAS("start pay");
			// start the pay.
			Result.sResult = null;
			sendMsgBacktoAS("info = " + info);
//			final String orderInfo = info;
			
			if(zip != null)
			{
				zip.interrupt();
				zip = null;
			}
			zip = new AlipayThread();
			zip.TAB = this.TAG;
			zip.orderInfo =  info;
			zip.start();
			  

		} catch (Exception ex) {
			sendMsgBacktoAS("catch error");
			ex.printStackTrace();
		}
		
		sendMsgBacktoAS("ending");
		return null;
	}
	
	private String getNewOrderInfo(Product product) {
		StringBuilder sb = new StringBuilder();
		sb.append("partner=\"");
		sb.append(Keys.DEFAULT_PARTNER);
		sb.append("\"&out_trade_no=\"");
		sb.append(getOutTradeNo());
		sb.append("\"&subject=\"");
		sb.append(product.subject);
		sb.append("\"&body=\"");
		sb.append(product.body);
		sb.append("\"&total_fee=\"");
		sb.append(product.price);
		sb.append("\"&notify_url=\"");

		// 网址需要做URL编码
		sb.append(URLEncoder.encode(Keys.notify_url));
		sb.append("\"&service=\""+Keys.service);
		sb.append("\"&_input_charset=\"UTF-8");
		sb.append("\"&return_url=\"");
		sb.append(URLEncoder.encode(Keys.return_url));
		sb.append("\"&payment_type=\"1");
		sb.append("\"&seller_id=\"");
		sb.append(Keys.DEFAULT_SELLER);

		// 如果show_url值为空，可不传
		// sb.append("\"&show_url=\"");
		sb.append("\"&it_b_pay=\"1m");
		sb.append("\"");

		return new String(sb);
	}

	private String getOutTradeNo() {
		SimpleDateFormat format = new SimpleDateFormat("MMddHHmmss");
		Date date = new Date();
		String key = format.format(date);

		java.util.Random r = new java.util.Random();
		key += r.nextInt();
		key = key.substring(0, 15);
		sendMsgBacktoAS("outTradeNo: " + key);
		return key;
	}

	private String getSignType() {
		return "sign_type=\"RSA\"";
	}
	
	
	
	public static class Product {
		public String subject;
		public String body;
		public String price;
	}
	
	private void sendMsgBacktoAS(String msg)
	{
		Log.d(TAG, msg);
		_context.dispatchStatusEventAsync(TAG, msg);
	}
}
