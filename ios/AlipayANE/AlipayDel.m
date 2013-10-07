//
//  AlipayDel.m
//  AlipayANE
//
//  Created by rect on 13-9-28.
//
//

#import "AlipayDel.h"


@implementation Product
@synthesize price = _price;
@synthesize subject = _subject;
@synthesize body = _body;
@synthesize orderId = _orderId;
@synthesize result = _result;

-(void)dealloc
{
    context = nil;
#if ! __has_feature(objc_arc)
    [_products release];
    [super dealloc];
#endif
}

@end

@implementation AlipayDel



//wap回调函数
-(void)paymentResult:(NSString *)resultd
{
    //结果处理
#if ! __has_feature(objc_arc)
    AlixPayResult* result = [[[AlixPayResult alloc] initWithString:resultd] autorelease];
#else
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
#endif
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            if (Ali_AlipayPubKey == NULL) {
                [self sendMegToAs:context code:@"AlipayPay" level:@"签名错误"];
                return;
            }
            NSString* key = Ali_AlipayPubKey;
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
                [self sendMegToAs:context code:@"AlipayPay" level:@"交易成功 验证签名成功，交易结果无篡改"];
                
			}
        }
        else
        {
            //交易失败
            [self sendMegToAs:context code:@"AlipayPay" level:@"交易失败 签名验证出错"];
        }
    }
    else
    {
        //失败
        [self sendMegToAs:context code:@"AlipayPay" level:@"失败"];
    }
    
}


/*
 *产生商品列表数据
 */
- (void)generateData
{
//	NSArray *subjects = [[NSArray alloc] initWithObjects:@"话费充值",
//						 @"魅力香水",@"珍珠项链",@"三星 原装移动硬盘",
//						 @"发箍发带",@"台版N97I",@"苹果手机",
//						 @"蝴蝶结",@"韩版雪纺",@"五皇纸箱",nil];
//	NSArray *body = [[NSArray alloc] initWithObjects:@"[四钻信誉]北京移动30元 电脑全自动充值 1到10分钟内到账",
//					 @"新年特惠 adidas 阿迪达斯走珠 香体止汗走珠 多种香型可选",
//					 @"[2元包邮]韩版 韩国 流行饰品太阳花小巧雏菊 珍珠项链2M15",
//					 @"三星 原装移动硬盘 S2 320G 带加密 三星S2 韩国原装 全国联保",
//					 @"[肉来来]超热卖 百变小领巾 兔耳朵布艺发箍发带",
//					 @"台版N97I 有迷你版 双卡双待手机 挂QQ JAVA 炒股 来电归属地 同款比价",
//					 @"山寨国产红苹果手机 Hiphone I9 JAVA QQ后台 飞信 炒股 UC",
//					 @"[饰品实物拍摄]满30包邮 三层绸缎粉色 蝴蝶结公主发箍多色入",
//					 @"饰品批发价 韩版雪纺纱圆点布花朵 山茶玫瑰花 发圈胸针两用 6002",
//					 @"加固纸箱 会员包快递拍好去运费冲纸箱首个五皇",nil];
//	
//	
//    
//	for (int i = 0; i < [subjects count]; ++i) {
//		Product *product = [[Product alloc] init];
//		product.subject = [subjects objectAtIndex:i];
//		product.body = [body objectAtIndex:i];
//		if (1==i) {
//			product.price = 1;
//		}
//		else if(2==i)
//		{
//			product.price = 10;
//		}
//		else if(3==i)
//		{
//			product.price = 100;
//		}
//		else if(4==i)
//		{
//			product.price = 1000;
//		}
//		else if(5==i)
//		{
//			product.price = 2000;
//		}
//		else if(6==i)
//		{
//			product.price = 6000;
//		}
//		else {
//			product.price = 0.01;
//		}
//		
//		
//#if ! __has_feature(objc_arc)
//		[product release];
//#endif
//	}
//	
//#if ! __has_feature(objc_arc)
//	[subjects release], subjects = nil;
//	[body release], body = nil;
//#endif
}


/*
 *生成订单信息及签名
 *由于demo的局限性，采用了将私钥放在本地签名的方法，商户可以根据自身情况选择签名方法
 */
-(void) createOrderandSinged:(NSString *)subject
                       price:(float)price
                        body:(NSString *)body
                    _context:(FREContext)_context
                  _partnerID:(NSString *)_partnerID
                   _sellerID:(NSString *)_sellerID
                    _MD5_KEY:(NSString *)_MD5_KEY
             _partnerPrivKey:(NSString *)_partenerPrivKey
               _allpayPubKey:(NSString *)_allpayPubKey
                 _notify_url:(NSString *)_notify_url
                    _service:(NSString *)_service
                 _return_url:(NSString *)_return_url
{
    
    [[AlipayDel alloc] sendMegToAs:_context code:@"AlipayPay" level:@"createOrderandSinged is begin"];

    
    NSString *appScheme = @"AlipayANE";
    
    _result = @selector(paymentResult:);
    [self generateData];
    
    context = _context;
    
    Ali_PartnerID = _partnerID;
    
    Ali_SellerID = _sellerID;
    
    Ali_MD5_KEY = _MD5_KEY;
    
    Ali_PartnerPrivKey = _partenerPrivKey;
    
    Ali_AlipayPubKey = _allpayPubKey;
    
    /*
	 *生成订单信息及签名
	 *由于demo的局限性，采用了将私钥放在本地签名的方法，商户可以根据自身情况选择签名方法
	 */
#if __has_feature(objc_arc)
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
#else
    AlixPayOrder *order = [[[AlixPayOrder alloc] init] autorelease];
#endif

    order.partner = _partnerID;
    [[AlipayDel alloc] sendMegToAs:_context code:@"AlipayPay" level:order.partner];
    
    order.seller = _sellerID;
    [[AlipayDel alloc] sendMegToAs:_context code:@"AlipayPay" level:order.seller];
    
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    [[AlipayDel alloc] sendMegToAs:_context code:@"AlipayPay" level:order.tradeNO];
    
	order.productName = subject;//product.subject; //商品标题
    [[AlipayDel alloc] sendMegToAs:_context code:@"AlipayPay" level:order.productName];

	order.productDescription = body;//product.body; //商品描述
    [[AlipayDel alloc] sendMegToAs:_context code:@"AlipayPay" level:order.productDescription];

	order.amount = [NSString stringWithFormat:@"%.2f",price]; //商品价格
    [[AlipayDel alloc] sendMegToAs:_context code:@"amount" level:order.amount];

	order.notifyURL =  _notify_url;//@"http%3A%2F%2Fwww.xxx.com"; //回调URL
    [[AlipayDel alloc] sendMegToAs:_context code:@"notifyURL" level:order.notifyURL];

    
    
    NSString *orderInfo = [order description];
    
    NSString* signedStr = [self doRsa:orderInfo];
    
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
	
    [[AlipayDel alloc] sendMegToAs:_context code:@"AlipayPay" level:@"createOrderandSinged is end"];

    
    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:_result target:self];
}


-(NSString*)getOrderInfo:(NSString *)_subject price:(float)_price body:(NSString *)_body _context:(FREContext)_context
{
    /*
	 *点击获取prodcut实例并初始化订单信息
	 */
	NSString* price = [NSString stringWithFormat:@"%.2f",_price]; //商品价格
    
    NSMutableString * discription = [NSMutableString string] ;
	[discription appendFormat:@"partner=\"%@\"", Ali_PartnerID];
	[discription appendFormat:@"&seller=\"%@\"", Ali_SellerID];
	[discription appendFormat:@"&out_trade_no=\"%@\"", [self generateTradeNO]];
	[discription appendFormat:@"&subject=\"%@\"", _subject];
	[discription appendFormat:@"&body=\"%@\"", _body];
	[discription appendFormat:@"&total_fee=\"%@\"", price];
	[discription appendFormat:@"&notify_url=\"%@\"", @"www.xxx.com"];
    
    [[AlipayDel alloc] sendMegToAs:_context code:@"AlipayPay" level:Ali_PartnerID];
	return discription;
}

- (NSString *)generateTradeNO
{
	const int N = 15;
	
	NSString *sourceString = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	NSMutableString *result = [[NSMutableString alloc] init] ;
	srand(time(0));
	for (int i = 0; i < N; i++)
	{
		unsigned index = rand() % [sourceString length];
		NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
		[result appendString:s];
	}
	return result;
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(Ali_PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

-(void)paymentResultDelegate:(NSString *)result
{
    NSLog(@"%@",result);
}

-(id) initWithFreContext:(FREContext)freContext{
    self = [super init];
    if(self){
        context = freContext;
    }
    return self;
}

-(void) initPayKey:(NSString *)_partnerID
         _sellerID:(NSString *)_sellerID
          _MD5_KEY:(NSString *)_MD5_KEY
   _partnerPrivKey:(NSString *)_partenerPrivKey
     _allpayPubKey:(NSString *)_allpayPubKey
{
    [[AlipayDel alloc] sendMegToAs:context code:@"AlipayInit" level:@"begin"];
}

-(void)sendMegToAs:(FREContext) _context code:(NSString *  )code level:(NSString * )level {
    
    NSLog(@"code = %@,level = %@",code,level);
    context = _context;
    FREDispatchStatusEventAsync( context,
                                (const uint8_t *)[code UTF8String],
                                (const uint8_t *)[level UTF8String]);
}

@end

