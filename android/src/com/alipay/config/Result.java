package com.alipay.config;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;

import android.app.Activity;
import android.util.Log;

public class Result extends Activity {
	private static final Map<String, String> sError;

	public static String sResult;

	static {
		sError = new HashMap<String, String>();
		sError.put("9000", "操作成功");
		sError.put("4000", "系统异常");
		sError.put("4001", "数据格式不正确");
		sError.put("4003", "该用户绑定的支付宝账户被冻结或不允许支付");
		sError.put("4004", "该用户已解除绑定");
		sError.put("4005", "绑定失败或没有绑定");
		sError.put("4006", "订单支付失败");
		sError.put("4010", "重新绑定账户");
		sError.put("6000", "支付服务正在进行升级操作");
		sError.put("6001", "用户中途取消支付操作");
		sError.put("7001", "网页支付失败");
	}

	public static String getResult() {
		String src = sResult.replace("{", "");
		src = src.replace("}", "");
		return getContent(src, "memo=", ";result");
	}

	public static void parseResult() {
		String resultStatus = null;
		String memo = null;
		String result = null;
		boolean isSignOk = false;
		try {
			String src = sResult.replace("{", "");
			src = src.replace("}", "");
			String rs = getContent(src, "resultStatus=", ";memo");
			if (sError.containsKey(rs)) {
				resultStatus = sError.get(rs);
			} else {
				resultStatus = "其他错误";
			}
			resultStatus += "(" + rs + ")";

			memo = getContent(src, "memo=", ";result");
			result = getContent(src, "result=", null);
			isSignOk = checkSign(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static boolean checkSign(String result) {
		boolean retVal = false;
		try {
			JSONObject json = string2JSON(result, "&");

			int pos = result.indexOf("&sign_type=");
			String signContent = result.substring(0, pos);

			String signType = json.getString("sign_type");
			signType = signType.replace("\"", "");

			String sign = json.getString("sign");
			sign = sign.replace("\"", "");

			if (signType.equalsIgnoreCase("RSA")) {
				retVal = Rsa.doCheck(signContent, sign, Keys.PUBLIC);
			}
		} catch (Exception e) {
			e.printStackTrace();
			Log.i("Result", "Exception =" + e);
		}
		Log.i("Result", "checkSign =" + retVal);
		return retVal;
	}

	public static JSONObject string2JSON(String src, String split) {
		JSONObject json = new JSONObject();

		try {
			String[] arr = src.split(split);
			for (int i = 0; i < arr.length; i++) {
				String[] arrKey = arr[i].split("=");
				json.put(arrKey[0], arr[i].substring(arrKey[0].length() + 1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return json;
	}

	private static String getContent(String src, String startTag, String endTag) {
		String content = src;
		int start = src.indexOf(startTag);
		start += startTag.length();

		try {
			if (endTag != null) {
				int end = src.indexOf(endTag);
				content = src.substring(start, end);
			} else {
				content = src.substring(start);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return content;
	}
}
