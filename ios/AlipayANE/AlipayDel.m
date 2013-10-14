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
#if ! __has_feature(objc_arc)
    [_products release];
    [super dealloc];
#endif
}

@end

@implementation AlipayDel

-(void)dealloc
{
#if ! __has_feature(objc_arc)
    [Ali_PartnerID release];
    [Ali_SellerID release];
    [Ali_MD5_KEY release];
    [Ali_PartnerPrivKey release];
    [Ali_AlipayPubKey release];
    
    [super dealloc];
#endif
}


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
//    [Ali_PartnerID retain];
    
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



-(void)sendMegToAs:(FREContext) _context code:(NSString *  )code level:(NSString * )level {
    
    NSLog(@"code = %@,level = %@",code,level);
    context = _context;
    FREDispatchStatusEventAsync( context,
                                (const uint8_t *)[code UTF8String],
                                (const uint8_t *)[level UTF8String]);
}


- (void)parse:(NSURL *)url _allpayPubKey:(NSString *)_allpayPubKey _context:(FREContext)_context {
    
    [[AlipayDel alloc] sendMegToAs:_context code:@"AlipayUrl" level:@"parse begin"];
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            NSString* key = _allpayPubKey;
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
                [[AlipayDel alloc] sendMegToAs:_context code:@"AlipayUrl" level:@"验证签名成功，交易结果无篡改"];
			}
            else
            {
                [[AlipayDel alloc] sendMegToAs:_context code:@"AlipayUrl" level:@"签名验证错误，交易失败"];
            }
        }
        else
        {
            //交易失败
            [[AlipayDel alloc] sendMegToAs:_context code:@"AlipayUrl" level:@"交易失败"];
        }
    }
    else
    {
        //失败
        [[AlipayDel alloc] sendMegToAs:_context code:@"AlipayUrl" level:@"失败"];
    }
    
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
	return [[AlixPayResult alloc] initWithString:query];
#endif
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
	AlixPayResult * result = nil;
	
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    
	return result;
}

@end


