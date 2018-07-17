//
//  MyNetworkingModel.m
//  JNTest
//
//  Created by Apple on 2018/4/13.
//  Copyright © 2018年 YHCS. All rights reserved.
//

#import "MyNetworkingModel.h"

@implementation MyNetworkingModel
XMGSingletoM

-(void)setToken:(NSString *)token
{
    _token = token;
    [[CurrencyManager sharedInstance]Initialize];
}


@end
