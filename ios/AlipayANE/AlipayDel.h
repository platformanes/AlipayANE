//
//  AlipayDel.h
//  AlipayANE
//
//  Created by rect on 13-9-28.
//
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"
#import "AlixLibService.h"

@interface AlipayDel : NSObject{
    
    SEL _result;
    
    
    FREContext context;
}
-(id) initWithFreContext:(FREContext) freContext;
-(void)paymentResult:(NSString *)result;
-(void) sendMegToAs:(FREContext)_context
           code:(NSString *) code
          level:(NSString * )level;

-(void) initAlipay:(FREContext) _context
        _partnerID:(NSString *)_partnerID
         _sellerID:(NSString *)_sellerID
          _MD5_KEY:(NSString *)_MD5_KEY
   _partnerPrivKey:(NSString *)_partenerPrivKey
     _allpayPubKey:(NSString *)_allpayPubKey
       _notify_url:(NSString *)_notify_url
          _service:(NSString *)_service
       _return_url:(NSString *)_return_url;

-(void) createOrderandSinged:(NSString *)subject
                       price:(float)price
                        body:(NSString *)body
                     _context:(FREContext)_context;


- (void)parse:(NSURL *)url
     _context:(FREContext)_context;
@end

@interface Product : NSObject{
@public
float _price;
NSString *_subject;
NSString *_body;
NSString *_orderId;

NSMutableArray *_products;

}


@property (nonatomic, assign) float price;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *orderId;
@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。


@end

NSString * Ali_PartnerID;
NSString * Ali_SellerID;
NSString * Ali_MD5_KEY;
NSString * Ali_PartnerPrivKey;
NSString * Ali_AlipayPubKey;
NSString * Ali_notify_url;
NSString * Ali_service;
NSString * Ali_return_url;



