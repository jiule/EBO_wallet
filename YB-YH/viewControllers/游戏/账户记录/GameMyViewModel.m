//
//  GameMyViewModel.m
//  YB-YH
//
//  Created by Apple on 2018/7/10.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "GameMyViewModel.h"

@implementation GameMyViewModel

-(void)setDict:(NSMutableDictionary *)dict
{
    [super setDict:dict];
    self.gameMyModelArrays = [NSMutableArray array];
    NSArray * transFerArray= dict[@"transFerArray"];
    for (int  i= 0 ; i < transFerArray.count; i++) {
        GameMyModel * model = [[GameMyModel alloc]initWithDict:transFerArray[i]];
        [self.gameMyModelArrays addObject:model];
    }
}

@end

@implementation GameMyModel

@end
