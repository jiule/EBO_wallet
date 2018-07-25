//
//  MarketOrderCell.m
//  YB-YH
//
//  Created by Apple on 2018/6/14.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "MarketOrderCell.h"
#import "MarketOrderModel.h"

@interface MarketOrderCell()
{
    UILabel * _zhuanLabel;
    UILabel * _zhuantextLabel;
    UILabel * _zhuanStyleLabel;
    UILabel * _zhuanStyletextLabel;
    UILabel * _timerLabel;
    UILabel * _zhuangtaiLabel;
}



@property(nonatomic,retain)MarketOrderModel * markModel;

@property(nonatomic,retain)UIView * bgView;

@end

@implementation MarketOrderCell

-(void)createCell
{
    self.backgroundColor = COLOR_H3;
    self.bgView = JnUIView(CGRectMake(0, 0, SCREEN_WIDTH , JN_HH(100)), COLOR_WHITE);
    [self addSubview:self.bgView];
    float label_w = self.bgView.width;  float label_x = JN_HH(15);
    _zhuanLabel = JnLabelType(CGRectMake(label_x, JN_HH(10),label_w - label_x* 2 , JN_HH(30)), UILABEL_2,BI_A0STR1(@"转入", @""), 0);
    [self.bgView addSubview:_zhuanLabel];

    _zhuantextLabel = JnLabel(CGRectMake(JN_HH(100), JN_HH(10),label_w * 0.5 , JN_HH(30)), @"0", JN_HH(16.5), SXRGB16Color(0x8BBB51), 0);
    [self.bgView addSubview:_zhuantextLabel];

    _zhuanStyleLabel = JnLabelType(CGRectMake(label_x, JN_HH(40),label_w - label_x* 2 , JN_HH(30)),UILABEL_2, BI_A1STR1(@"转出", @""), 0);
    [self.bgView addSubview:_zhuanStyleLabel];

    _zhuanStyletextLabel = JnLabelType(CGRectMake(JN_HH(100), JN_HH(40),label_w * 0.5 , JN_HH(30)),UILABEL_2, @"0",  0);
    [self.bgView addSubview:_zhuanStyletextLabel];

    _zhuangtaiLabel = JnLabel(CGRectMake(label_w * 0.5, JN_HH(40),label_w * 0.5 - label_x , JN_HH(30)), @"确认中", JN_HH(15.5), COLOR_A1, 2);
    [self.bgView addSubview:_zhuangtaiLabel];

    _timerLabel = JnLabelType(CGRectMake(label_x, JN_HH(70), label_w, JN_HH(20)), UILABEL_4,@"2018-05-33 15:20", 0);
    [self.bgView addSubview:_timerLabel];



}


-(void)setTableViewModel:(DwTableViewModel *)tableViewModel
{
    [super setTableViewModel:tableViewModel];
    self.markModel = (MarketOrderModel *)tableViewModel;
    if ([self.markModel.coin_species isEqual:BI_A0]) {
        _zhuanLabel.text = BI_A0STR1(@"转入", @"");
        _zhuanStyleLabel.text = [NSString stringWithFormat:@"转出%@",self.markModel.ob_species];
        _zhuantextLabel.text = [NSString stringWithFormat:@"+%@",self.markModel.coin_num];
        _zhuanStyletextLabel.text = [NSString stringWithFormat:@"-%@",self.markModel.ob_coin];
    }else {
        _zhuanStyleLabel.text = [NSString stringWithFormat:@"转入%@",self.markModel.coin_species];
        _zhuanLabel.text = BI_A0STR1(@"转出", @"");
        _zhuanStyletextLabel.text = [NSString stringWithFormat:@"+%@",self.markModel.coin_num];
        _zhuantextLabel.text = [NSString stringWithFormat:@"-%@",self.markModel.ob_coin];
    }
    _zhuangtaiLabel.text = self.markModel.state_name;
    _timerLabel.text = self.markModel.create_time;
    [self createcell_h:JN_HH(100) BgColor:COLOR_H3 xian_h:2];

}




@end
