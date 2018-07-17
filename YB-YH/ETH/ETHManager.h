//
//  ETHManager.h
//  YB-YH
//
//  Created by Apple on 2018/6/27.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewJavascriptBridge.h"

@interface ETHManager : NSObject

XMGSingletoH
//-------------------------以太坊-----------------------
//生成一个明文账户 
+(void)createAccountPassword:(NSString *)password responseCallback:(WVJBResponseCallback)responseCallback;
//获取私钥
+(void)createKeyWithPassword:(NSString *)password account:(NSString *)account responseCallback:(WVJBResponseCallback)responseCallback;
//签名
+(void)createSignWithKey:(NSString *)key data:(id)data responseCallback:(WVJBResponseCallback)responseCallback;
//-----------------------比特币------------------------

@end
