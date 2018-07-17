//
//  GameModel.m
//  YB-YH
//
//  Created by Apple on 2018/7/5.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "GameModel.h"

@implementation GameModel

-(void)setDict:(NSMutableDictionary *)dict
{
    [super setDict:dict];
    self.game_id = dict[@"id"];
    self.ios =dict[@"upload_url"][@"ios"];
}


@end
