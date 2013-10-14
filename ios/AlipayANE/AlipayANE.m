/*
 
 Copyright (c) 2012, DIVIJ KUMAR
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met: 
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer. 
 2. Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution. 
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those
 of the authors and should not be interpreted as representing official policies, 
 either expressed or implied, of the FreeBSD Project.
 
 
 */

/*
 * AlipayANE.m
 * AlipayANE
 *
 * Created by rect on 13-9-27.
 * Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
 */

#import "AlipayANE.h"


/* AlipayANEExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml 
 */
void AlipayANEExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) 
{
    NSLog(@"Entering AlipayANEExtInitializer()");

    *extDataToSet = NULL;
    *ctxInitializerToSet = &ContextInitializer;
    *ctxFinalizerToSet = &ContextFinalizer;

    NSLog(@"Exiting AlipayANEExtInitializer()");
}

/* AlipayANEExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml 
 */
void AlipayANEExtFinalizer(void* extData) 
{
    NSLog(@"Entering AlipayANEExtFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting AlipayANEExtFinalizer()");
    return;
}

/* ContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    NSLog(@"Entering ContextInitializer()");
    
    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     */
    static FRENamedFunction func[] = 
    {
        MAP_FUNCTION(AlipayExit, NULL),
        MAP_FUNCTION(AlipayInit, NULL),
        MAP_FUNCTION(AlipayPay, NULL),
        MAP_FUNCTION(AlipayUrl, NULL)
    };
    
    *numFunctionsToTest = sizeof(func) / sizeof(FRENamedFunction);
    *functionsToSet = func;
    
    NSLog(@"Exiting ContextInitializer()");
}

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void ContextFinalizer(FREContext ctx) 
{
    NSLog(@"Entering ContextFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting ContextFinalizer()");
    return;
}


/* This is a TEST function that is being included as part of this template. 
 *
 * Users of this template are expected to change this and add similar functions 
 * to be able to call the native functions in the ANE from their ActionScript code
 */
ANE_FUNCTION(AlipayExit)
{
    NSLog(@"Entering AlipayExit()");
    
    FREObject fo;
    context = ctx;
    FREResult aResult = FRENewObjectFromBool(YES, &fo);
    if (aResult == FRE_OK)
    {
        NSLog(@"Result = %d", aResult);
    }
    else
    {
        NSLog(@"Result = %d", aResult);
    }
    
    
    [[AlipayDel alloc] sendMegToAs:context code:@"AlipayExit" level:@"alipay exit ending"];
    
	NSLog(@"Exiting AlipayExit()");
	return fo;
}

ANE_FUNCTION(AlipayInit)
{
    NSLog(@"Entering AlipayInit()");
    
    FREObject fo = NULL;
    context = ctx;
    
    [[AlipayDel alloc] sendMegToAs:context code:@"AlipayInit" level:@"alipay init begin"];
    
    
    [[AlipayDel alloc] sendMegToAs:context code:@"AlipayInit" level:@"alipay init ending"];
    
    NSLog(@"ending AlipayInit()");
    return fo;
}



ANE_FUNCTION(AlipayPay)
{
    NSLog(@"Entering AlipayPay()");
    
    FREObject fo = NULL;
    context = ctx;
    
    [[AlipayDel alloc] sendMegToAs:context code:@"AlipayPay" level:@"alipay pay begin"];
    
    Ali_subject = getStringFromFREObject(argv[0]);
    [[AlipayDel alloc] sendMegToAs:context code:@"AlipayPay" level:Ali_subject];
    
    Ali_price = getIntFromFreObject(argv[1]);
    [[AlipayDel alloc] sendMegToAs:context code:@"AlipayPay" level:@"price "];
    
    Ali_body = getStringFromFREObject(argv[2]);
    [[AlipayDel alloc] sendMegToAs:context code:@"AlipayPay" level:Ali_body];
    
    [[AlipayDel alloc] initWithFreContext:context];
    [[AlipayDel alloc] sendMegToAs:context code:@"AlipayPay" level:@"initWithFre is OK"];
    
    Ali_PartnerID = getStringFromFREObject(argv[3]);
    
    Ali_SellerID = getStringFromFREObject(argv[4]);
    
    Ali_MD5_KEY = getStringFromFREObject(argv[5]);
    
    Ali_PartnerPrivKey = getStringFromFREObject(argv[6]);
    
    Ali_AlipayPubKey = getStringFromFREObject(argv[7]);
    
    Ali_notify_url = getStringFromFREObject(argv[8]);
    
    Ali_service = getStringFromFREObject(argv[9]);
    
    Ali_return_url = getStringFromFREObject(argv[10]);
    
    
    [[AlipayDel alloc] createOrderandSinged:Ali_subject
                                      price:Ali_price
                                       body:Ali_body
                                   _context:context
                                 _partnerID:Ali_PartnerID
                                  _sellerID:Ali_SellerID
                                   _MD5_KEY:Ali_MD5_KEY
                            _partnerPrivKey:Ali_PartnerPrivKey
                              _allpayPubKey:Ali_AlipayPubKey
                                _notify_url:Ali_notify_url
                                   _service:Ali_service
                                _return_url:Ali_return_url];
    
    [[AlipayDel alloc] sendMegToAs:context code:@"AlipayPay" level:@"alipay pay ending"];
    NSLog(@"ending AlipayPay()");
    return fo;
}

ANE_FUNCTION(AlipayUrl)
{
    NSLog(@"Entering AlipayUrl()");
    
    FREObject fo = NULL;
    context = ctx;
    
    
    [[AlipayDel alloc] sendMegToAs:context code:@"AlipayUrl" level:@"alipay AlipayUrl begin"];
    
    NSString * urlStr = getStringFromFREObject(argv[0]);
    NSString * _allpayPubKey = getStringFromFREObject(argv[1]);
    
    NSURL * _alipayURL = [NSURL URLWithString:urlStr];
    
    [[AlipayDel alloc] parse:_alipayURL _allpayPubKey:_allpayPubKey _context:context];
    
    [[AlipayDel alloc] sendMegToAs:context code:@"AlipayUrl" level:@"alipay AlipayUrl ending"];
    NSLog(@"ending AlipaySignCheck()");
    return fo;
}

int getIntFromFreObject(FREObject freObject)
{
    int32_t value;
    FREGetObjectAsInt32(freObject, &value);
    return value;
    
}

/*
 *将FREObject转成NSString
 */
NSString * getStringFromFREObject(FREObject obj)
{
    uint32_t length;
    const uint8_t *value;
    FREGetObjectAsUTF8(obj, &length, &value);
    return [NSString stringWithUTF8String:(const char *)value];
}














