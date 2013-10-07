package com.alipay.func;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
/**
 * @author Rect 2013-10-5
 */
public class AlipayExit implements FREFunction {
	private String TAG = "AlipayExit";
	private FREContext _context;
	@Override
	public FREObject call(final FREContext context, FREObject[] arg1) {
		// TODO Auto-generated method stub
		_context = context;
		sendMsgBacktoAS("begining");
		
		sendMsgBacktoAS("ending");
		return null;
	}

	private void sendMsgBacktoAS(String msg)
	{
		Log.d(TAG, msg);
		_context.dispatchStatusEventAsync(TAG, msg);
	}
}
