//
//  MyAlertsModel.m
//  YB-YH
//
//  Created by Apple on 2018/7/23.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MyAlertsModel.h"


@implementation MyAlertsModel

-(void)setDict:(NSMutableDictionary *)dict
{
    [super setDict:dict];
    if ([dict[@"description"] class] != [NSNull class]) {
            self.description_text = dict[@"description"];
    }

}

@end
