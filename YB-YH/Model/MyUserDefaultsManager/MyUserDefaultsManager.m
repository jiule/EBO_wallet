//
//  MyUserDefaultsManager.m
//  框架
//
//  Created by Apple on 16/8/15.
//  Copyright © 2016年 框架. All rights reserved.
//

#import "MyUserDefaultsManager.h"


@interface MyUserDefaultsManager () <CAAnimationDelegate>

@end

@implementation MyUserDefaultsManager

XMGSingletoM
//保存值
-(void)setJNObject:(nullable id)value forKey:(NSString *)defaultName
{
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    [df setObject:value forKey:defaultName];
    [df synchronize];
}
+(void)setJNObject:(nullable id)value forkey:(NSString *)defaultName
{
    [[MyUserDefaultsManager sharedInstance]setJNObject:value forKey:defaultName];
}
//取值
-(nullable id)JNobjectForKey:(NSString *)defaultName
{
     NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    return  [df objectForKey:defaultName];
}

+(nullable id)JNobjectForKey:(NSString *)defaultName
{
    return [[MyUserDefaultsManager sharedInstance]JNobjectForKey:defaultName];
}

-(void)removeKey:(NSString *)defaultName{
     NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    [df removeObjectForKey:defaultName];
    [df synchronize];
}

+(void)removeKey:(NSString *)defaultName
{
    [[MyUserDefaultsManager sharedInstance]removeKey:defaultName];
}

+(NSString *)readAddressBi
{
    return [NSString stringWithFormat:@"%@%@",[PersonalManager readPersonalModel].uid,@"ADDRESS"];
}

+(NSString *)readAddressSign
{
    return [NSString stringWithFormat:@"%@%@",[PersonalManager readPersonalModel].uid,@"ADDRESIGN"];
}

+(NSString *)readCoinTypes
{
    return  [NSString stringWithFormat:@"%@CoinTypes",[PersonalManager readPersonalModel].uid];
}

+(NSString *)readAssets{
  return  [NSString stringWithFormat:@"%@ZiAssets",[PersonalManager readPersonalModel].uid];
}

@end
