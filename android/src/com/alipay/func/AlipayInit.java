package com.alipay.func;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.alipay.config.Keys;
/**
 * @author Rect 2013-10-5
 */
public class AlipayInit implements FREFunction {
	private String TAG = "AlipayInit";
	private FREContext _context;
	@Override
	public FREObject call(final FREContext context, FREObject[] arg1) {
		// TODO Auto-generated method stub
		_context = context;
		sendMsgBacktoAS("begining");
		
		try
		{
			Keys.DEFAULT_PARTNER = arg1[0].getAsString();
			Keys.DEFAULT_SELLER = arg1[1].getAsString();
			Keys.MD5_KEY = arg1[2].getAsString();
			Keys.PRIVATE = arg1[3].getAsString();
			Keys.PUBLIC = arg1[4].getAsString();
			
			Keys.notify_url = arg1[5].getAsString();
			Keys.service = arg1[6].getAsString();
			Keys.return_url = arg1[7].getAsString();
			
			//args test
			sendMsgBacktoAS(Keys.DEFAULT_PARTNER);
			sendMsgBacktoAS(Keys.DEFAULT_SELLER);
			sendMsgBacktoAS(Keys.PRIVATE);
			sendMsgBacktoAS(Keys.PUBLIC);
			
			sendMsgBacktoAS(Keys.notify_url);
			sendMsgBacktoAS(Keys.return_url);
			sendMsgBacktoAS(Keys.service);
			
		}
		catch(Exception e)
		{
			sendMsgBacktoAS("参数错误,tags:"+e.getMessage());
		}
		
		sendMsgBacktoAS("ending");
		return null;
	}
	
	private void sendMsgBacktoAS(String msg)
	{
		Log.d(TAG, msg);
		_context.dispatchStatusEventAsync(TAG, msg);
	}
}
