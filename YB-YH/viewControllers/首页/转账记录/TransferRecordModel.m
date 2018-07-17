//
//  TransferRecordModel.m
//  YB-YH
//
//  Created by Apple on 2018/6/22.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "TransferRecordModel.h"

@implementation TransferRecordModel

-(void)setDict:(NSMutableDictionary *)dict
{
    [super setDict:dict];
    self.transFerArrays = [NSMutableArray array];
    NSArray * transFerArray= dict[@"transFerArray"];
    for (int  i= 0 ; i < transFerArray.count; i++) {
        TransferModel * model = [[TransferModel alloc]initWithDict:transFerArray[i]];
        [self.transFerArrays addObject:model];
    }
}
@end

@implementation TransferModel
@end
