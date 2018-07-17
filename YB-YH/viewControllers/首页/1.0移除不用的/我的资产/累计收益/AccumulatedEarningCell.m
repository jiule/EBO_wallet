//
//  AccumulatedEarningCell.m
//  YB-YH
//
//  Created by Apple on 2018/6/21.
//  Copyright © 2018年 YB-YH. All rights reserved.
//

#import "AccumulatedEarningCell.h"
#import "AccumulatedEarningModel.h"

@interface AccumulatedEarningCell()
{
    UILabel * _numLabel;
    UILabel * _timerLabel;
}
@end


@implementation AccumulatedEarningCell


-(void)createCell
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.backgroundColor = COLOR_WHITE;
    _numLabel =JnLabel(CGRectMake(JN_HH(20), 0, self.width, JN_HH(40)), BI_A0STR1(@"0", @""), JN_HH(15.5), COLOR_A1, 0);
    _timerLabel = JnLabel(CGRectMake(JN_HH(20), 0, self.width, JN_HH(40)), @"1990-01-01", JN_HH(15.5), COLOR_A1, 2);
    [self addSubview:_numLabel];
    [self addSubview:_timerLabel];
}

-(void)setTableViewModel:(DwTableViewModel *)tableViewModel
{
    [super setTableViewModel:tableViewModel];
    AccumulatedEarningModel * model =(AccumulatedEarningModel *)tableViewModel;
    _numLabel.text = [NSString stringWithFormat:@"%.2f%@",[model.num floatValue],BI_A0];
    _timerLabel.text = model.timer;
    if ([model.selber intValue] == 1) {
        self.backgroundColor = COLOR_A1;
        _numLabel.textColor = COLOR_WHITE;
        _timerLabel.textColor = COLOR_WHITE;
    }else {
        self.backgroundColor = COLOR_WHITE;
        _numLabel.textColor = COLOR_A1;
        _timerLabel.textColor = COLOR_A1;
    }
    [self createcell_h:JN_HH(45) BgColor:DIVIDER_COLOR1 xian_h:5];
}

@end
