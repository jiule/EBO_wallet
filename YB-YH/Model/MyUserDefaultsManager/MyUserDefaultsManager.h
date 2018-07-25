//
//  MyUserDefaultsManager.h
//  框架
//
//  Created by Apple on 16/8/15.
//  Copyright © 2016年 框架. All rights reserved.
//




#define kEXPERSFILTERING_LISHI_ARRAY  @"LISHI_ARRAY_KEY"

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


NS_ASSUME_NONNULL_BEGIN
@interface MyUserDefaultsManager : NSObject 

XMGSingletoH

/**
 *  插入一个对象到 NSUserDefaults
 *
 *  @param value       值
 *  @param defaultName 键
 */
-(void)setJNObject:(nullable id)value forKey:(NSString *)defaultName;
+(void)setJNObject:(nullable id)value forkey:(NSString *)defaultName;
/**
 *  取 NSUserDefaults 对应的 defaultName 值
 *
 *  @param defaultName 建名称
 */
-(nullable id)JNobjectForKey:(NSString *)defaultName;
+(nullable id)JNobjectForKey:(NSString *)defaultName;
/**
 *  删除保存的值
 *
 *  @param defaultName nil
 */
-(void)removeKey:(NSString *)defaultName;
+(void)removeKey:(NSString *)defaultName;

//保存用户的 私钥加密 字段
+(NSString *)readAddressBi;
//保存用户的私钥地址
+(NSString *)readAddressSign;
//保存用户币种开通信息
+(NSString *)readCoinTypes;
//保存用户币种余额额
+(NSString *)readAssets;
+ (void)saveKeychainValue:(NSString *)sValue key:(NSString *)sKey;
+ (NSString *)readKeychainValue:(NSString *)sKey;
NS_ASSUME_NONNULL_END
@end
