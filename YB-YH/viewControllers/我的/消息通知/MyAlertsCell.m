//
//  MyAlertsCell.m
//  YB-YH
//
//  Created by Apple on 2018/7/23.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MyAlertsCell.h"
#import "MyAlertsModel.h"

@interface MyAlertsCell()
{
    UILabel * _textLabel;
    UILabel * _timerLabel;
}
@end


@implementation MyAlertsCell

-(void)createCell
{
    _textLabel = JnLabelType(CGRectMake(JNVIEW_X0, 0, SCREEN_WIDTH * 0.5, JN_HH(44)), UILABEL_2, @"", 0);
    [self addSubview:_textLabel];

    _timerLabel = JnLabelType(CGRectMake(SCREEN_WIDTH * 0.5 + JNVIEW_X(0),0 , SCREEN_WIDTH * 0.5 - JNVIEW_X(44), JN_HH(44)), UILABEL_4, @"", 2);
    [self addSubview:_timerLabel];

    [self addSubview:JnImageView(CGRectMake(SCREEN_WIDTH - JN_HH(44), 0, JN_HH(44), JN_HH(44)), MYimageNamed(@"jiantou_A1_88"))];
}

-(void)setTableViewModel:(DwTableViewModel *)tableViewModel
{
    [super setTableViewModel:tableViewModel];
    MyAlertsModel * model = (MyAlertsModel *)tableViewModel;
    _textLabel.text = model.title;
    _timerLabel.text = [model.create_time  substringFromIndex:10];
    [super createcell_h:JN_HH(44) BgColor:nil xian_h:1];

}

@end
