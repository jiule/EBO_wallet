//
//  MyNetworkingHelp.m
//  JNTest
//
//  Created by Apple on 2018/4/13.
//  Copyright © 2018年 YHCS. All rights reserved.
//

#import "MyNetworkingHelp.h"
#import "EncryptionManager.h"
#import "RootViewController.h"

@implementation MyNetworkingHelp

+(BOOL)dealWithResponseDict:(NSDictionary *)responseDict;
{
    if ([responseDict[@"code"] intValue] == 1) {
        return  YES;
    }else if([responseDict[@"code"] intValue] == 10001){
        [MYAlertController showTitltle:@"登录已失效" selButton:^(MYAlertController *AlertController, int index) {
            [[ RootViewController sharedInstance]loginOFF];
        }];
        return  NO;
    }
    [MYAlertController showTitltle:responseDict[@"msg"]];
    return NO;
}

+(NSDictionary *)addSidWithDict:(NSDictionary *)dict
{
    return  [self addSidWithDict:dict type:Encryption_TYPE0];
}

+(NSDictionary *)addSidWithDict:(NSDictionary *)dict type:(Encryption_TYPE)type
{
    NSDictionary * sidDict = [self sidDicttype:type];
    NSMutableDictionary * returnDict = [[NSMutableDictionary alloc]initWithDictionary:dict];
    for (NSString * key in sidDict.allKeys) {
        [returnDict setObject:sidDict[key] forKey:key];
    }
    return returnDict;
}

+(NSString *)addSidStringWithDict:(NSDictionary *)dict
{
    return @"";
}

+(NSDictionary *)getSidDict
{
    return [self sidDicttype:Encryption_TYPE0];
}

+(NSDictionary *)sidDicttype:(Encryption_TYPE)type
{
    if ([MyNetworkingModel sharedInstance].token) {
        return @{@"json":@"1",@"token":[MyNetworkingModel sharedInstance].token};
    }
    return @{@"json":@"1"};
}

@end
