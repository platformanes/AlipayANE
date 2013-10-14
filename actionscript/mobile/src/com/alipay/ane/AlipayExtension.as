package com.alipay.ane 
{ 
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	/**
	 * more http://www.shadowkong.com
	 * @author Rect  2013-9-27 
	 * 
	 */
	public class AlipayExtension extends EventDispatcher 
	{ 
		private static var PartnerID:String;
		private static var SellerID:String;
		private static var MD5_KEY:String;
		private static var PartnerPrivKey:String;
		private static var AlipayPubKey:String
		private static var notify_url:String = "";
		private static var service:String = "";
		private static var return_url:String = "";
		/**
		 * Ailpay Init 
		 */		
		private static const ALIPAY_FUNCTION_INIT:String = "AlipayInit";
		
		/**
		 * Ailpay Pay
		 */		
		private static const ALIPAY_FUNCTION_PAY:String = "AlipayPay";
		/**
		 * Ailpay exit
		 */		
		private static const ALIPAY_FUNCTION_EXIT:String = "AlipayExit";
		
		private static const ALIPAY_FUNCTION_URL:String = "AlipayUrl";
		public static const EXTENSION_ID:String = "com.alipay.ane.AlipayANE";//与extension.xml中的id标签一致
		private var extContext:ExtensionContext;
		private static var _instance:AlipayExtension; 
		
		public function AlipayExtension(target:IEventDispatcher=null)
		{
			super(target);
			if(extContext == null) {
				extContext = ExtensionContext.createExtensionContext(EXTENSION_ID, "");
				extContext.addEventListener(StatusEvent.STATUS, statusHandler);
			}
		} 
		/**
		 * 
		 * @param _PartnerID
		 * @param _SellerID
		 * @param _MD5_KEY IOS版需要 android版本忽略
		 * @param _PartnerPrivKey
		 * @param _AlipayPubKey
		 * @param _notify_url
		 * @param _service
		 * @param _return_url
		 * @return 
		 * 
		 */		
		public function AlipayInit(
			_PartnerID:String,
			_SellerID:String,
			_MD5_KEY:String,
			_PartnerPrivKey:String,
			_AlipayPubKey:String,
			_notify_url:String = "",
			_service:String = "",
			_return_url:String = ""):String
		{
			if(extContext)
			{
				PartnerID = _PartnerID;
				SellerID = _SellerID;
				MD5_KEY = _MD5_KEY;
				PartnerPrivKey = _PartnerPrivKey;
				AlipayPubKey = _AlipayPubKey;
				
				notify_url = _notify_url;
				service = _service;
				return_url = _return_url;
				
				return extContext.call(ALIPAY_FUNCTION_INIT,
					PartnerID,
					SellerID,
					MD5_KEY,
					PartnerPrivKey,
					AlipayPubKey,
					notify_url,
					service,
					return_url) as String;
			}
			return "AlipayInit function failed";
		}
		/**
		 * 
		 * @param subject  商品名称
		 * @param price  价格 单位 （元）
		 * @param body  商品描述
		 * @return 
		 * 
		 */		
		public function AlipayPay(subject:String,price:int,body:String):String
		{
			if(extContext)   
			{
				return extContext.call(ALIPAY_FUNCTION_PAY,subject,price,body,
					PartnerID,SellerID,MD5_KEY,PartnerPrivKey,AlipayPubKey,
					notify_url,service,return_url) as String;
			}
			return "AlipayPay function failed";
		}
		/**
		 * IOS URL回调 
		 * @param url
		 * @return 
		 * 
		 */		
		public function AlipayURLHandle_JustIOS(url:String):String
		{
			if(extContext)   
			{   
				return extContext.call(ALIPAY_FUNCTION_URL,url,AlipayPubKey) as String;
			}
			return "AlipayURLHandle function failed";
		}
		
		/**
		 * 清理一些东西 
		 * @param key
		 * @return 
		 * 
		 */		
		public function AlipayExit(key:int = 0):String
		{
			if(extContext)   
			{   
				return extContext.call(ALIPAY_FUNCTION_EXIT,key) as String;
			}
			return "AlipayExit function failed";
		}
		
		/**
		 * 获取实例
		 * @return DLExtension 单例
		 */
		public static function getInstance():AlipayExtension
		{
			if(_instance == null) 
				_instance = new AlipayExtension();
			return _instance;
		}
		
		/**
		 * 转抛事件
		 * @param event 事件
		 */
		private function statusHandler(event:StatusEvent):void
		{
			dispatchEvent(event);
		}
	} 
	
	
}











