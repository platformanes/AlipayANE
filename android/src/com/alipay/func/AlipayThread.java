package com.alipay.func;

import android.os.Handler;
import android.os.Message;
import android.util.Log;

import com.alipay.android.app.sdk.AliPay;
import com.alipay.config.Result;

/**
 * @author Rect 2013-10-5
 */
public class AlipayThread  extends Thread{

	  public  String TAB = "AlipayThread";
	  public  String orderInfo;
	  
	  public void run()
	  {
	    try
	    {
	    	sendMsgBacktoAS("orderInfo = " + orderInfo);
	    	
	    	String result = new AliPay(AlipayPay._context.getActivity(), mHandler).pay(orderInfo);
	    	
	    	sendMsgBacktoAS("result = " + result);
	    	Message msg = new Message();
	    	msg.what = AlipayPay.RQF_PAY;
	    	msg.obj = result;
	    	mHandler.sendMessage(msg);
	    }
	    catch (Exception e) {
	      sendMsgBacktoAS("trErr:" + e.getMessage());
	      e.printStackTrace();
	    }
	    super.run();
	  }
	  
	  Handler mHandler = new Handler() {
			public void handleMessage(android.os.Message msg) {
				Result.sResult = (String) msg.obj;

				switch (msg.what) {
				case AlipayPay.RQF_PAY: {
//					Toast.makeText(AlipayPay._context.getActivity(), Result.getResult(),
//							Toast.LENGTH_SHORT).show();
					
					sendMsgBacktoAS("AlipayThread:"+Result.getResult());

				}
					break;
				default:
					break;
				}
			};
		};

		
	  private void sendMsgBacktoAS(String msg)
		{
			Log.d(TAB, msg);
			AlipayPay._context.dispatchStatusEventAsync(TAB, msg);
		}
}
