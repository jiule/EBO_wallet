//
//  ShouyeQianView.m
//  YB-YH
//
//  Created by Apple on 2018/7/11.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "ShouyeQianView.h"

@implementation ShouyeQianView

-(instancetype)initWithFrame:(CGRect)frame
{
  self=  [super initWithFrame:frame];
    if (self) {
        [self createView];
        return self;
    }
    return nil;
}

-(void)createView
{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.6f;
    self.layer.shadowRadius = 4.0f;
    self.layer.cornerRadius = 4.0f;
    self.layer.shadowOffset = CGSizeMake(-1,2);

    _imggeView = JnImageView(CGRectMake(JN_HH(15), JN_HH(20), JN_HH(34), JN_HH(34)), MYimageNamed(@"sy_ebog"));

    [self addSubview:_imggeView];
    _eboLabel = JnLabel(CGRectMake(JN_HH(60), JN_HH(10), JN_HH(100), JN_HH(55)), BI_A0, JN_HH(27.5), COLOR_A1, 0);
    [self addSubview:_eboLabel];

    UILabel * eboLabel = JnLabelType(CGRectMake(self.width * 0.5, JN_HH(5), self.width *0.5 - JN_HH(15), JN_HH(40)), UILABEL_1, @"0", 2);
    eboLabel.font = [UIFont systemFontOfSize:JN_HH(20)];
    [self addSubview:eboLabel];
    _yueLabel = eboLabel;
    _rebLabel = JnLabelType(CGRectMake(self.width * 0.5, JN_HH(45), self.width *0.5 - JN_HH(15), JN_HH(20)), UILABEL_3, @"0", 2);
    [self addSubview:_rebLabel];
}

@end
