package com.alipay.ane;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
/**
 * 
 * @author Rect 2013-10-5
 */
public class AliPayExtension implements FREExtension {

	@Override
	public FREContext createContext(String arg0) {
		// TODO Auto-generated method stub
		return new AliPayContext();
	}

	@Override
	public void dispose() {
		// TODO Auto-generated method stub

	}

	@Override 
	public void initialize() {
		// TODO Auto-generated method stub

	}

}
