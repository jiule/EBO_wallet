//
//  TransferRecordCell.m
//  YB-YH
//
//  Created by Apple on 2018/6/22.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "TransferRecordCell.h"
#import "TransferRecordModel.h"

@interface TransferRecordCell()
{
    UILabel * _typeLabel;
    UILabel * _timerLabel;
    UILabel * _priceLabel;
    UILabel * _biNameLabel;
}
@end

@implementation TransferRecordCell

-(void)createCell
{
    self.backgroundColor = COLOR_WHITE;
    _typeLabel = JnLabelType(CGRectMake(JNVIEW_X0, JN_HH(10), JN_HH(110), JN_HH(25)), UILABEL_2, @"", 0);
    [self addSubview:_typeLabel];
    _timerLabel = JnLabelType(CGRectMake(JNVIEW_X0, JN_HH(35), JN_HH(150), JN_HH(15)), UILABEL_4, @"", 0);
    [self addSubview:_timerLabel];
    _priceLabel = JnLabelType(CGRectMake(SCREEN_WIDTH * 0.45, JN_HH(15), SCREEN_WIDTH * 0.35, JN_HH(25)), UILABEL_2, @"", 1);
    [self addSubview:_priceLabel];
    _biNameLabel = JnLabelType(CGRectMake(SCREEN_WIDTH * 0.85, JN_HH(15), SCREEN_WIDTH * 0.1, JN_HH(25)), UILABEL_2, @"", 2);
    [self addSubview:_biNameLabel];

}

-(void)setTableViewModel:(DwTableViewModel *)tableViewModel
{
    [super setTableViewModel:tableViewModel];
    TransferModel * model = (TransferModel *)tableViewModel;
    _timerLabel.text = model.created_at;
    _priceLabel.text = model.user_income;
    _biNameLabel.text = model.coin_name;
    if ([model.user_income floatValue] > 0) {
         _typeLabel.text = [NSString stringWithFormat:@"转入[%@]",[CurrencyManager readInvite: [model.invite_type intValue ]]];
        _priceLabel.textColor = COLOR_BL_2;
    }else {
        _typeLabel.text = [NSString stringWithFormat:@"转出[%@]",[CurrencyManager readInvite: [model.invite_type intValue ]]];
        _priceLabel.textColor = COLOR_RED;
    }

    [self createcell_h:JN_HH(60) BgColor:nil xian_h:1];
}



@end
