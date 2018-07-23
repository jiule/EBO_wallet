//
//  BaseDDView.m
//  YB-YH
//
//  Created by Apple on 2018/7/23.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "BaseDDView.h"

@implementation BaseDDView

-(instancetype)initWithLeftName:(nullable NSString *)leftName title:(NSString *)title{
    return  [super initWithFrame:CGRectZero leftName:leftName title:title];
}

-(instancetype)initWithLeftName:(nullable NSString *)leftName title:(NSString *)title rightImageName:(BOOL)rightImageName{
    return [super initWithFrame:CGRectZero leftName:leftName title:title rightImageName:rightImageName];
}

-(instancetype)initWithLeftName:(nullable NSString *)leftName title:(NSString *)title rightName:(nullable NSString *)rightName{
    return  [super initWithFrame:CGRectZero leftName:leftName title:title rightImageName:rightName];
}


-(void)drawRect:(CGRect)rect
{
    [self show];
}

@end
